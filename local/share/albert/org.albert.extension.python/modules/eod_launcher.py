"""
    Start DAoC Client for Eve-of-Darkness
"""
from albertv0 import *
from os import path

__iid__ = 'PythonInterface/v0.1'
__prettyname__ = 'DAoC Eve-of-Darkness'
__version__ = '1.0'
__trigger__ = 'eod '
__author__ = 'Ben Falk'
__dependencies__ = []
__icon__ = path.dirname(__file__) + '/icons/phx.png'


def to_item(repo):
  return Item(
    id=str(repo),
    text=repo,
    icon=__icon__,
    actions=[
      ProcAction('Start', ['playonlinux', '--run', 'eod_'+repo])
    ]
  )

def handleQuery(query):
  if query.isTriggered and len(query.string) > 0:
    return [to_item(query.string)]
  return [Item(icon= __icon__, text='Eve-of-Darkness Daoc')]
