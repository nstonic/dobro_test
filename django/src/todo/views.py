from rest_framework import mixins, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from .serializers import TaskSerializer, CategorySerializer, TaskPermission
from .models import Task, Category


class TaskViewSet(
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet,
):
    serializer_class = TaskSerializer
    queryset = Task.objects.all()
    permission_classes = (IsAuthenticated, TaskPermission)

    def list(self, request, *args, **kwargs):
        queryset = Task.objects.filter(user=request.user)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class CategoryViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    viewsets.GenericViewSet,
):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()

    @action(methods=['get'], detail=True)
    def tasks(self, request, pk: int):
        category = Category.objects.get(pk=pk)
        queryset = Task.objects.filter(user=request.user, category=category)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = TaskSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = TaskSerializer(queryset, many=True)
        return Response(serializer.data)
