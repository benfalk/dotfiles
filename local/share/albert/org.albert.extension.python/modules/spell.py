"""
    Spell Better N00b
"""
from albertv0 import *
from subprocess import Popen, PIPE
import re

__iid__ = 'PythonInterface/v0.1'
__prettyname__ = 'Spell'
__version__ = '1.0'
__trigger__ = 'spell '
__author__ = 'Ben Falk'
__dependencies__ = ['aspell']

def to_clip(str):
    return ClipAction(str)

def to_suggestions(query):
    spell = Popen(["aspell", "-a"], stdout=PIPE, stdin=PIPE)
    output = spell.communicate(input=query)[0].split('\n')[1]
    maybe_suggestions = re.match('.*:(.*)', output)

    if maybe_suggestions is None:
        return Item(
                id=str(query),
                text="correct",
                actions=[to_clip(query)]
                )
    else:
        suggestions = maybe_suggestions.groups()[0].split(',')
        return Item(
                id=str(query),
                text="suggestions",
                actions=map(to_clip, suggestions)
                )

def handleQuery(query):
    if query.isTriggered and len(query.string) < 3:
        return [Item(id='spell', text='Spell Better')]
    return to_suggestions(query.string)
