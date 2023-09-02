from rest_framework import permissions
from rest_framework.fields import HiddenField, CurrentUserDefault
from rest_framework.permissions import BasePermissionMetaclass
from rest_framework.serializers import ModelSerializer

from .models import Task, Category


class TaskPermission(metaclass=BasePermissionMetaclass):

    def has_permission(self, request, view):
        return not request.user.is_anonymous

    def has_object_permission(self, request, view, obj):
        if request.method in permissions.SAFE_METHODS:
            return True
        return obj.user == request.user


class TaskSerializer(ModelSerializer):
    user = HiddenField(default=CurrentUserDefault())

    class Meta:
        model = Task
        fields = [
            'title',
            'category',
            'content',
            'created_at',
            'done_at',
            'complete_due',
            'user',
        ]


class CategorySerializer(ModelSerializer):
    class Meta:
        model = Category
        fields = ['id', 'name']
