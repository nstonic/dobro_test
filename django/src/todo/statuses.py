from enum import Enum

from django.utils.timezone import now


class ToDoStatuses(Enum):
    EXPIRED = 'Просрочено'
    DONE = 'Выполнено'
    ACTIVE = 'В работе'


def get_task_status(task):
    match task:
        case task if task.done_at:
            return ToDoStatuses.DONE
        case task if task.complete_due and task.complete_due < now():
            return ToDoStatuses.EXPIRED
        case _:
            return ToDoStatuses.ACTIVE
