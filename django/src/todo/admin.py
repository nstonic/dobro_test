from django.contrib import admin

from todo.statuses import ToDoStatuses, get_task_status
from todo.models import Task, Category, TaskQuerySet

admin.site.register(Category)


class ToDoStatusFilter(admin.SimpleListFilter):
    title = 'Статус'
    parameter_name = 'status'

    def lookups(self, request, model_admin):
        return (
            ('expired', ToDoStatuses.EXPIRED.value),
            ('done', ToDoStatuses.DONE.value),
            ('active', ToDoStatuses.ACTIVE.value),
        )

    def queryset(self, request, qs: TaskQuerySet):
        if value := self.value():
            return qs.filter_by_status(status=value)


@admin.register(Task)
class TaskAdmin(admin.ModelAdmin):
    list_display = [
        'title',
        'show_status',
        'complete_due',
    ]
    readonly_fields = [
        'created_at',
        'show_status',
    ]
    fields = [
        'title',
        'show_status',
        'category',
        'created_at',
        'complete_due',
        'done_at',
        'content',
    ]
    list_filter = [
        ToDoStatusFilter,
    ]

    def show_status(self, obj):
        status = get_task_status(obj)
        return status.value

    show_status.short_description = 'Статус'
