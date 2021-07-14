"""news_room URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from rest_framework import permissions
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path, include, re_path
from drf_yasg.views import get_schema_view
from drf_yasg import openapi


schema_view = get_schema_view(
    openapi.Info(
        title="My API",
        default_version='v%s' % settings.API_VERSIONS[-1],
        description="Test description",
        terms_of_service="https://www.google.com/policies/terms/",
        contact=openapi.Contact(email="contact@snippets.local"),
        license=openapi.License(name="BSD License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)


def get_versioned_urls():
    urls = []
    selected_versions = settings.API_VERSIONS
    if settings.DEBUG:
        selected_versions = selected_versions[-1:]
    for version in selected_versions:
        urls.extend([
            path('api/v%s/auth_service/' % version, include(('auth_service.urls', 'auth_service'),
                                                            namespace='v%s-auth_service' % version)),
            path('api/v%s/user_service/' % version, include(('user_service.urls', 'user_service'),
                                                            namespace='v%s-user_service' % version)),
            path('api/v%s/news_services/' % version, include(('news_services.urls', 'news_services'),
                                                            namespace='v%s-news_services' % version)),
        ])
    return urls


urlpatterns = [
    path('admin/', admin.site.urls),
    path('error/', include('error_report.urls')),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    *get_versioned_urls(),
    re_path(r'^swagger(?P<format>\.json|\.yaml)$', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    re_path(r'^swagger/$', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    re_path(r'^redoc/$', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)