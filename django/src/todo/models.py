from typing import NamedTuple

from django.contrib.auth.models import User
from django.db import models
from django.db.models import QuerySet
from django.utils.timezone import now


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


class Task(models.Model):
    class Status(NamedTuple):
        value: str
        verbose_name: str

    STATUSES = {
        'expired': Status('expired', 'Просрочено'),
        'done': Status('done', 'Выполнено'),
        'active': Status('active', 'В работе'),
    }

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
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        verbose_name='Пользователь',
        related_name='tasks',
        null=True
    )
    objects = TaskQuerySet.as_manager()

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = 'Задание'
        verbose_name_plural = 'Задания'
        ordering = ['-created_at']

    def get_task_status(self) -> Status:
        match self:
            case self if self.done_at:
                return self.STATUSES['done']
            case self if self.complete_due and self.complete_due < now():
                return self.STATUSES['expired']
            case _:
                return self.STATUSES['active']
