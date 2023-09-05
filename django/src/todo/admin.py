from copy import deepcopy

from django.contrib import admin
from django.contrib.auth.models import User
from django_mptt_admin.admin import FilterableDjangoMpttAdmin

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
class TaskAdmin(FilterableDjangoMpttAdmin):
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
                    'parent',
                    'priority',
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
        'priority',
        ToDoStatusFilter,
    ]

    def show_status(self, obj):
        status = obj.get_task_status()
        return status.verbose_name

    show_status.short_description = 'Статус'

    def save_form(self, request, form, change):
        obj = form.save(commit=False)
        if obj.parent:
            obj.user = obj.parent.user
        return form.save(commit=False)

    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        parent_task_pk = request.GET.get('insert_at')
        if not obj and parent_task_pk:
            if parent_task := Task.objects.filter(pk=parent_task_pk):
                form.base_fields['user'].initial = parent_task.first().user
        return form
