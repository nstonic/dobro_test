from statistics import mean
from typing import NamedTuple

from django.contrib.auth.models import User
from django.db import models
from django.db.models import QuerySet
from django.utils.timezone import now
from mptt.models import MPTTModel, TreeForeignKey


class Category(models.Model):
    name = models.CharField(
        'Название',
        max_length=128,
    )

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Категория'
        verbose_name_plural = 'Категории'


class TaskQuerySet(QuerySet):
    def filter_by_status(self, status):
        tasks_by_status = {
            key: list()
            for key in Task.STATUSES.keys()
        }
        for task in self:
            task_status = task.get_task_status()
            tasks_by_status[task_status.value].append(task.pk)

        return self.filter(pk__in=tasks_by_status[status])

    def get_stat(self):
        done_tasks = self.filter_by_status(Task.STATUSES['done'].value)
        active_tasks = self.filter_by_status(Task.STATUSES['active'].value)
        expired_tasks = self.filter_by_status(Task.STATUSES['expired'].value)
        overdue_tasks = [
            task
            for task in self
            if task.done_at and task.done_at > task.complete_due
        ]
        avg_complete_hours = mean([
            (task.done_at.timestamp() - task.created_at.timestamp()) / 3600
            for task in self
            if task.done_at
        ] or [0])
        overdue_percent = 100 * (len(overdue_tasks) + expired_tasks.count()) / self.count() if self.count() else 0
        return {
            'total_tasks_amount': self.count(),
            'done_tasks_amount': done_tasks.count(),
            'active_tasks_amount': active_tasks.count(),
            'expired_tasks_amount': expired_tasks.count(),
            'avg_complete_hours': round(avg_complete_hours, 0),
            'overdue_percent': round(overdue_percent, 1)
        }


class Task(MPTTModel):
    class Status(NamedTuple):
        value: str
        verbose_name: str

    STATUSES = {
        'expired': Status('expired', 'Просрочено'),
        'done': Status('done', 'Выполнено'),
        'active': Status('active', 'В работе'),
    }

    PRIORITY_CHOICES = [
        ("LOW", "Низкий"),
        ("MID", "Средний"),
        ("HIGH", "Высокий"),
    ]

    title = models.CharField(
        'Название',
        max_length=256,
    )
    content = models.TextField(
        'Содержимое',
        blank=True,
    )
    created_at = models.DateTimeField(
        'Создано',
        auto_now_add=True,
    )
    done_at = models.DateTimeField(
        'Сделано',
        null=True,
        blank=True,
    )
    complete_due = models.DateTimeField(
        'Сделать до',
        null=True,
        blank=True,
    )
    category = models.ForeignKey(
        Category,
        on_delete=models.SET_NULL,
        verbose_name='Категория',
        related_name='tasks',
        null=True,
        blank=True,
    )
    priority = models.CharField(
        'Приоритет',
        max_length=16,
        choices=PRIORITY_CHOICES,
        default='MID'
    )
    file = models.FileField(
        'Файл',
        upload_to='media/',
        null=True,
        blank=True,
    )
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='Пользователь',
        related_name='tasks',
    )
    parent = TreeForeignKey(
        'self',
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        related_name='children',
        verbose_name='Вложено в',
    )

    objects = TaskQuerySet.as_manager()

    def __str__(self):
        return f'{self.title} ({self.get_task_status().verbose_name}) пользователь: {self.user}'

    class Meta:
        verbose_name = 'Задание'
        verbose_name_plural = 'Задания'
        ordering = ['-created_at']

    class MPTTMeta:
        order_insertion_by = ['created_at']

    def get_task_status(self) -> Status:
        match self:
            case self if self.done_at:
                return self.STATUSES['done']
            case self if self.complete_due and self.complete_due < now():
                return self.STATUSES['expired']
            case _:
                return self.STATUSES['active']
