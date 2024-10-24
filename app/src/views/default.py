from django.shortcuts import render, redirect, HttpResponse


def index(request) -> HttpResponse:

    return render(request, status=200, template_name='index.html')


def catchall(_) -> HttpResponse:
    return redirect('/')
