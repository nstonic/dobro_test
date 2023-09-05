from rest_framework.routers import DefaultRouter, Route

from .views import CategoryViewSet, TaskViewSet

router = DefaultRouter()
router.register('tasks', TaskViewSet, basename='tasks')
router.register('categories', CategoryViewSet, basename='categories')
router.routes.append(
    Route(
        url=r'^{prefix}/stat$',
        mapping={'get': 'stat'},
        name='{basename}-stat',
        detail=True,
        initkwargs={},
    ),
)

urlpatterns = router.urls
