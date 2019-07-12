from django import template

register = template.Library()

@register.filter(name='fetch')
def fet(value,arg):
    return arg.count(value)

