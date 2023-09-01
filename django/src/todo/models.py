from django.db import models


class Category(models.Model):
    name = models.CharField('Название', max_length=128)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'Категория'
        verbose_name_plural = 'Категории'


class Task(models.Model):
    title = models.CharField('Название', max_length=256)
    content = models.TextField('Содержимое', blank=True)
    created_at = models.DateTimeField('Создано', auto_now_add=True)
    done_at = models.DateTimeField('Сделано', null=True, blank=True)
    category = models.ForeignKey(
        Category,
        on_delete=models.SET_NULL,
        verbose_name='Категория',
        related_name='tasks',
        null=True,
        blank=True
    )

    class Meta:
        verbose_name = 'Задание'
        verbose_name_plural = 'Задания'
        ordering = ['-created_at']
