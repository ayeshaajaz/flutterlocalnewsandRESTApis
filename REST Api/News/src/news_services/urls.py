from django.urls import path
from .views import CategoryView, CategoryViewDetails, ArticleView, UserArticle, UserArticleDetails, AdminViewDetails, \
    AdminView

urlpatterns = [
    path('category/', CategoryView.as_view()),
    path("category/<int:pk>/", CategoryViewDetails.as_view()),
    path('article/', ArticleView.as_view()),
    path('admin_article/<int:pk>', AdminViewDetails.as_view()),
    path('admin_article/', AdminView.as_view()),
    path('user_article/', UserArticle.as_view()),
    path("user_article/<int:pk>/", UserArticleDetails.as_view()),

]
