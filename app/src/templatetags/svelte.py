from os import environ

from django import template

register = template.Library()


@register.simple_tag
def dev_mode() -> bool:
    print('DEV', 'DEV_MODE' in environ)
    return 'DEV_MODE' in environ
