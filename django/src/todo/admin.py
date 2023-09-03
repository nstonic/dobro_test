from django.contrib import admin

from .models import Task, Category, TaskQuerySet

admin.site.register(Category)


class ToDoStatusFilter(admin.SimpleListFilter):
    title = 'Статус'
    parameter_name = 'status'

    def lookups(self, request, model_admin):
        return Task.STATUSES.values()

    def queryset(self, request, qs: TaskQuerySet):
        if value := self.value():
            return qs.filter_by_status(status=value)


@admin.register(Task)
class TaskAdmin(admin.ModelAdmin):
    list_display = [
        'title',
        'category',
        'show_status',
        'complete_due',
    ]
    readonly_fields = [
        'created_at',
        'show_status',
    ]
    fieldsets = [
        [
            None,
            {
                'fields': [
                    'user',
                    'title',
                    'category',
                    'show_status',
                    'content',
                    'file',
                ],
            },
        ],
        (
            'Сроки',
            {
                'fields': [
                    'created_at',
                    'complete_due',
                    'done_at',
                ],
            },
        ),
    ]

    list_filter = [
        'category',
        ToDoStatusFilter,
    ]

    def show_status(self, obj):
        status = obj.get_task_status()
        return status.verbose_name

    show_status.short_description = 'Статус'
