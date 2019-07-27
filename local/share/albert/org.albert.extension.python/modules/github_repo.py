"""
    Github Repo Quick List
    Make sure you have ~/.github_cache/repo_names.txt generated
"""

from albertv0 import *
from os import path
from functools import reduce
import re
import copy

__iid__ = 'PythonInterface/v0.1'
__prettyname__ = 'Github Repo List'
__version__ = '1.0'
__trigger__ = 'ghr '
__author__ = 'Ben Falk'
__dependencies__ = []
__icon__ = path.dirname(__file__) + '/icons/octocat.png'

repo_names = []

name_path = path.expanduser("~/.github_cache/repo-names.txt")
if path.exists(name_path):
    name_file = open(name_path)
    repo_names = name_file.read().split('\n')
    name_file.close()

def index_repo(repo):
    return (repo, repo.lower(), 0)

def index():
    return list(map(index_repo, repo_names))

def repo_to_item(repo):
    url = "https://github.com/%s" % repo
    action = UrlAction(text=repo, url=url)
    return Item(id=repo, text=repo, actions=[action], icon=__icon__)

def handleQuery(query):
    if not query.isTriggered:
        return None

    if len(query.string) == 0:
        return Item(id='need-more', icon=__icon__, text="Github Repos", actions=[])
    
    results = index()

    for char in query.string.lower():
        rollup = []

        for (repo, name, idx) in results:
            pos = name.find(char, idx)
            if pos != -1:
                rollup.append((repo, name, pos+1))

        results = rollup

    
    names = [name for (name, _, _) in results]
    return list(map(repo_to_item, names))
