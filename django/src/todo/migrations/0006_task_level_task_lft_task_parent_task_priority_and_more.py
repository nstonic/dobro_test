# Generated by Django 4.2.4 on 2023-09-05 14:04

from django.db import migrations, models
import django.db.models.deletion
import mptt.fields


class Migration(migrations.Migration):

    dependencies = [
        ('todo', '0005_task_file'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='level',
            field=models.PositiveIntegerField(editable=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='task',
            name='lft',
            field=models.PositiveIntegerField(editable=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='task',
            name='parent',
            field=mptt.fields.TreeForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='children', to='todo.task'),
        ),
        migrations.AddField(
            model_name='task',
            name='priority',
            field=models.CharField(choices=[('LOW', 'Низкий'), ('MID', 'Средний'), ('HIGH', 'Высокий')], default='MID', max_length=16, verbose_name='Приоритет'),
        ),
        migrations.AddField(
            model_name='task',
            name='rght',
            field=models.PositiveIntegerField(editable=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='task',
            name='tree_id',
            field=models.PositiveIntegerField(db_index=True, editable=False),
            preserve_default=False,
        ),
    ]
