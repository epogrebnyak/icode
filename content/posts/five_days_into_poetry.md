---
title: "Five Days Into  Poetry"
date: 2021-01-11
draft: false
tags: ["python"]
---

Being just several days into a package makes you a good reviewer. The impressions are fresh 
and mastering some new functionality is still a delight. This is where I am with [Poetry](https://python-poetry.org/), a next-generation Python package and virtual environment manager.

<!--more-->

## Part 1: 

### My previous workflow

My previous workflow was not too sophisticated and there was not much purity with package versions.
I had an Anaconda installation and occasionally added packages to global environment (yes, I did). 

I was isolating a package when needed to test remotely with Github Actions. For that I created an 
environment with `venv`, installed dependencies there and freezed them 
into `requirements.txt` with `pip`. There was a `setup.py` for PyPi-based projects, which I hestated 
to touch after I got it to work. 

Also maintained a separate `requirements-dev.txt` just to take note of extra tools I was using.
There where no binaries, so nothing required `conda` in my case.

### Why change that?

1. My interest to Poetry actually came from looking for a better project file structure. That led me to review [Hypermodern Python Packaging][hpp], which I started to adopt gradually. For example, I already used pytest, black, isort and mypy, but still see no additional value for me in `nox` test runner or more linters inside the project. 

[hpp]: https://cjolowicz.github.io/posts/hypermodern-python-01-setup/

2. Never quite liked remembering a path to `activate.bat` to be able to switch the environment on (now I can use `poetry shell`).

3. I thought a text-based configuration file can hold package information, not `setup.py` (which I had hard time editing) 

Poetry was not the first thing to adopt from [Hypermodern Packaging][hpp], but I realised that:

- Poetry defines a package file structure for you 
- package is controlled by `pyproject.toml
- there is a clever mechanism to resolve and lock dependencies

Also had some prejudice against `pipenv`, which targets same goal as Poetry, but [was not maintained for about a year](https://www.reddit.com/r/Python/comments/aox5ah/moving_away_from_pipenv). The big difference is that `pipenv` is based on the same `setuptools`, while poetry has its own engine for [PEP 517 backend](https://github.com/python-poetry/poetry-core).

### My new workflow

I tried poetry for a new project and liked the result. Here is a minimal example:

```bash
pip install poetry 
poetry new wee 
cd wee
echo "Let's see how the config file looks like"
cat pyproject.toml      
poetry add pandas
poetry add -D sphinx 
echo "Without `poetry install` your original package 'wee' is not in the env"
poetry install         
echo "There is a test sceleton with simple unit test that should pass"
poetry run pytest       
```

## Part 2: Were there any difficulties?

Coming up next.

<!--

## The Poetry mind model

What I wish someone told me from a start of using Poetry: 

poetry always creates an environment and runs everything in it.there is always some environment in use by poetry 
poetry shell is a way to enter environment, poetry run something acts the same
you add dependencies to environment, marking some dependencies as development or extra
you have to install your package into environment with poetry install 
your poetry based project is installable with pip, even from your github depository
you specify python version in project.toml
you can bump a version number with a command 
poetry is smart enough to make deterministic package tree from a list of your dependencies 
some package configurations will not run even on sister python versions
poetry leaves your git decisions to you, not integrated with version control (probably for good) 

# Fun fact 

Poetry escaped from benevolent disctatorship of Guido 


# Bumps

- no clear way to refer py toml  version in package
- building a tree sometimes takes up to 100 sec, even on some seemingly simple package addition
- poetry env command has strange help in CLI which is better explained in the docs
- some upstream virtualenv problem on Windows, had to fix a specific version
- a bit of research effort to setup Github actions (I wanted to simplify a template)

- i noticed Colab runs on python 3.6.9 and my installation in 3.8 , it never occurred to me 
- need to be careful if some dependency is in dev, but you think is is package core 
- Spyder doesn’t not seem virtualenv-friendly 


# My own config

.venv  + gitignore 
- use just command runner to auto me some tasks
- --src layout
- README.md, not README.rst

https://xkcd.com/1987/

-->

## When to use Poetry

Poetry is very enabling if:

- you already use virtual environments 
- you release to PyPI often
- do not depend on `setuptools` for some special features and not locked to `conda` for binaries
- already use pytest as your testing framework

<!--

## Discussions

This post benefited from discussions:

- ...
- ...
- ...

-->