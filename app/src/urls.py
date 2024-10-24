from django.urls import re_path

from app.src.views.default import index, catchall

urlpatterns = [
    re_path('^$', index),
    re_path(r'^', catchall),
]
