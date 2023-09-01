from django.contrib import admin

from todo.models import Task, Category

admin.site.register(Category)


@admin.register(Task)
class TaskAdmin(admin.ModelAdmin):
    list_display = [
        'title',
        'is_done',
    ]
    readonly_fields = ['is_done', 'created_at']
    fields = [
        'title',
        'category',
        'created_at',
        'done_at',
        'content'
    ]

    def is_done(self, obj):
        return bool(obj.done_at)

    is_done.short_description = 'Сделано'
    is_done.boolean = True
