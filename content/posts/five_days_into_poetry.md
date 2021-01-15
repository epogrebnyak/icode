---
title: "Five Days Into  Poetry"
date: 2021-01-11
lastmod: 2021-01-15
draft: false
tags: ["python"]
images: ["muka.jpg", "muka_small.jpg"]
---

Being just several days into a package makes you a good reviewer. The impressions are fresh and mastering some new functionality is still a delight. This is where I am with [Poetry](https://python-poetry.org/), a next-generation Python package and virtual environment manager.

<!--more-->

## My previous workflow

My previous workflow was not too sophisticated and there was not much purity with package versions.
I had an Anaconda installation and occasionally added packages to global environment (yes, I did). 

I was isolating a package when needed to test remotely with Github Actions. For that I created an environment with `venv`, installed dependencies there and freezed them 
into `requirements.txt` with `pip`. There was a `setup.py` for PyPi-based projects, which I hestated to touch after I got it to work. 

Also maintained a separate `requirements-dev.txt` just to take note of extra tools I was using. There where no binaries, so nothing required `conda` in my case.

#### Why change that?

1. My interest to Poetry came from looking for a better project file structure. That led me to review [Hypermodern Python Packaging][hpp], which I started to adopt gradually. For example, I already used pytest, black, isort and mypy, but still see no additional value for me in `nox` test runner or more linters inside the project. 

[hpp]: https://cjolowicz.github.io/posts/hypermodern-python-01-setup/

2. Never quite liked remembering a path to `activate.bat` to be able to switch the environment on (now I can use `poetry shell`).

3. I thought a text-based configuration file can hold package information, not `setup.py` (which I had hard time editing) 

Poetry was not the first thing to adopt from [Hypermodern Packaging][hpp], but I realised that:

- Poetry defines a package file structure for you 
- package is controlled by `pyproject.toml
- there is a clever mechanism to resolve and lock dependencies

Also had some prejudice against `pipenv`, which targets same goal as Poetry, but [was not maintained for about a year](https://www.reddit.com/r/Python/comments/aox5ah/moving_away_from_pipenv). The big difference is that `pipenv` is based on the same `setuptools`, while poetry has its own engine for [PEP 517 backend](https://github.com/python-poetry/poetry-core).


## My new workflow

I tried poetry for a new project and liked the result. Here is a minimal example:

{{< highlight bash >}}
pip install poetry 
poetry new wee 
cd wee
echo "Let's see how the config file looks like"
cat pyproject.toml      
poetry add pandas
poetry add -D sphinx 
echo "Without `poetry install` your package 'wee' is not in the environment"
poetry install         
echo "There is a simple unit test already configured"
poetry run pytest       
poetry show --tree
{{< / highlight >}}

## What I learned

There are a few things I wish someone told me from a start of using Poetry.

### 1. There is always an environment in use

The main thing to keep in mind is that Poetry always creates an virtual environment and runs everything in it. There is always some environment in use by Poetry. 

There are two ways to enter the environment, one is `poetry shell` + `exit`
after you are done. Another is `poetry run` followed by what 
what you want to run in the environment, for example `poetry run pytest`
to invoke pytest in environment.

#### Where are the environment files?

Which environment is active and where is the environment directory?
If you use just one environment, you might not even care, this is something 
Poetry took care of for you and put in own folder. 

I activated in-project option:

```
poetry config virtualenvs.in-project true
```

Now I can see `.venv` folder exlicitly, added it `.venv` to `.gitignore` and I can explore what is inside and even delete it by hand if everything else fails.

You can hack Poetry to work on global environment, but that is not the best use of it,
you loose functionality by doing that. 

### 2. You can specify Python version in project.toml

Poetry will set the Python version based on your global environment,
but you can change the version. In my case the default would be:

```
[tool.poetry.dependencies]
python = "^3.8"
```
For example, Google Colab currently uses Python 3.6.9, so I can 
possibly fix that version if I want my package to run on Colab.
However, some package configurations will not run even on sister 
Python versions.

### 3. You can add dependencies to package, tooling or as extras

This is well-documented in the manual. You can see what changed
`pyproject.toml`

```
poetry add pandas
poetry add -D black
cat pyproject.toml
```

### 4. You must install your own package to environment (!)

After `poetry add pandas` pandas is available in your 
environment, `poetry run python -c "import pandas"` 
should work. But form the start you own package 
(say, `foo`) is not installed. You have to add 
it with `poetry install`. I often forgot that step and 
that left me wondering why things did not work. 

This is a step similar to `pip install -e .`

### 5. Poetry-based project is installable with pip (!)

Just like this:

```
pip install pip install git+https://github.com/epogrebnyak/ssg-dataset
```

No need to create `setup.py` or `requirements.txt`.

### 6. You can bump a version number with a command 

Try any of:

```
pip version major
pip version minor 
pip version patch
```

and see how `pyproject.toml` changed:

```
[tool.poetry]
version = "1.1.2"
```

... but pkg.\_\_version\_\_ is not affected. 

The command will change the version im `pyproject.toml` seen at PyPI distribution, but not the `___version___ ` in the package, so there is a bit of disconnect there.


### 7. Poetry leaves your version control decisions to you

Poetry is not integrated with version control (probably for good).
When you create a new project with Poetry it is up to you
to thnk of a way to upload it to Github or Gitlab.

For publishing to PyPI there is a dedicated command
`poetry publish`. 

<!--
### Some bumps noticed

- Building a tree sometimes takes over 100 seconds, even on some seemingly simple package addition.
- Poetry `env` command has strange help in CLI which is better explained in the docs.
- I had lock into fix a specific virtualenv version to make Poetry work on Windows, but it is fixed now in new virtualenv release.
-->

## When to use Poetry

Poetry is very enabling if you:

- already use virtual environments 
- release to PyPI often
- do not depend on `setuptools` for some special features 
- not locked to `conda` for binaries
- already use pytest as your testing framework

Give it a try!

{{< admonition tip "Fun fact" true >}}

Poetry escaped from benevolent disctatorship of Guido
(and so did dependabot). 

{{< tweet 1227126706089021440 >}}

{{< /admonition >}}

<!-- https://xkcd.com/1987/ -->