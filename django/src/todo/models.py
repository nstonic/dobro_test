from django.db import models
from django.db.models import QuerySet

from todo.statuses import ToDoStatuses, get_task_status


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
        statuses = {
            ToDoStatuses.EXPIRED: 'expired',
            ToDoStatuses.DONE: 'done',
            ToDoStatuses.ACTIVE: 'active',
        }
        tasks_by_status = {
            'expired': [],
            'done': [],
            'active': [],
        }
        for task in self:
            task_status = get_task_status(task)
            status_key = statuses[task_status]
            tasks_by_status[status_key].append(task.pk)

        return self.filter(pk__in=tasks_by_status[status])


class Task(models.Model):
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
    objects = TaskQuerySet.as_manager()

    class Meta:
        verbose_name = 'Задание'
        verbose_name_plural = 'Задания'
        ordering = ['-created_at']
