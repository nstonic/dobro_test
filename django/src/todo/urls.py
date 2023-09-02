from rest_framework.routers import DefaultRouter

from .views import CategoryViewSet, TaskViewSet

router = DefaultRouter()
router.register('tasks', TaskViewSet, basename='tasks')
router.register('categories', CategoryViewSet, basename='categories')

urlpatterns = router.urls
