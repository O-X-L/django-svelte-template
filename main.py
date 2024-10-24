#!/usr/bin/env python3
from os import environ, getpid

from django import setup as django_setup


def main():
    environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')
    environ['MAINPID'] = str(getpid())

    django_setup()

    # add pre-start-code here

    from webserver import init_webserver
    init_webserver()


if __name__ == '__main__':
    main()
