from os import environ

from django import template

register = template.Library()


@register.simple_tag
def dev_mode() -> bool:
    return 'DEV_MODE' in environ and str(environ['DEV_MODE']) == '1'
