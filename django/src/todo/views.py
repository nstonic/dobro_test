from rest_framework import mixins, viewsets
from rest_framework.decorators import action
from rest_framework.generics import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.status import HTTP_200_OK

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
    http_method_names = [
        'get',
        'post',
        'put',
        'delete',
    ]

    def list(self, request, *args, **kwargs):
        queryset = self.queryset.filter(user=request.user)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def stat(self, request):
        tasks = self.queryset.filter(user=request.user)
        return Response(
            tasks.get_stat(),
            status=HTTP_200_OK,
        )


class CategoryViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    viewsets.GenericViewSet,
):
    serializer_class = CategorySerializer
    queryset = Category.objects.all()

    @action(methods=['get'], detail=True)
    def tasks(self, request, pk: int):
        category = get_object_or_404(Category, pk=pk)
        tasks = Task.objects.filter(user=request.user, category=category)

        page = self.paginate_queryset(tasks)
        if page is not None:
            serializer = TaskSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = TaskSerializer(tasks, many=True)
        return Response(serializer.data)

    def stat(self, request):
        categories = {}
        for category in self.queryset:
            tasks = Task.objects.filter(user=request.user, category=category)
            categories[category.pk] = {
                'name': category.name,
                'stat': tasks.get_stat(),
            }

        return Response(
            categories,
            status=HTTP_200_OK,
        )
