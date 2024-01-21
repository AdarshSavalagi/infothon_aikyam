from django.urls import path
from .views import *

urlpatterns = [
    path('get_data/',IndexView.as_view(),name='data view'),
]
