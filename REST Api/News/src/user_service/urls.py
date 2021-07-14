from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import DjUserViews

router = DefaultRouter()
router.register("users", DjUserViews)


urlpatterns = [

]

urlpatterns += router.urls
