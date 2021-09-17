"""
    Spell Better
"""
from albert import *
from subprocess import Popen, PIPE
from os import path
import re

__iid__ = 'PythonInterface/v0.1'
__prettyname__ = 'Spell'
__version__ = '0.1.0'
__title__ = 'Spell'
__triggers__ = 'sp '
__author__ = 'Ben Falk'
__dependencies__ = ['aspell']
__icon__ = path.dirname(__file__) + '/icons/sp.png'

def handleQuery(query):
    if not query.isTriggered:
        return None

    if len(query.string) < 3:
        return [Item(id='spell', icon=__icon__, text='Spell Better')]

    proc = Popen(["aspell", "-a"], stdout=PIPE, stdin=PIPE)

    word = query.string

    output = proc.communicate(input=bytes(word, 'utf8'))[0].decode().split('\n')[1]

    maybe_suggestions = re.match('.*:(.*)', output)

    if maybe_suggestions is None:
        return Item(id=word, icon=__icon__, text="correct", actions=[to_clip(word)])
    else:
        suggestions = maybe_suggestions.groups()[0].split(',')
        return list(map(to_suggestion, suggestions))

def to_suggestion(word):
    word = word.strip()
    return Item(id=word, icon=__icon__, text=word, actions=[to_clip(word)])

def to_clip(word):
    return ClipAction(text=word, clipboardText=word)
