# -*- coding: utf-8 -*-
#
# PISM, a Parallel Ice Sheet Model documentation build configuration file
#
# This file is execfile()d with the current directory set to its
# containing dir.

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#
# needs_sphinx = '1.0'

nitpicky = True

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = ['sphinx.ext.mathjax',
              'sphinxcontrib.bibtex']

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
source_suffix = '.rst'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This patterns also affect html_static_path and html_extra_path
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

def git(command):
    return subprocess.check_output(shlex.split(command)).strip().decode("utf-8")

# Get precise revision, author, and date information from Git:
try:
    import subprocess
    import shlex

    git_revision = git("git describe --always --match v?.?*")
    git_author = git('git --no-pager log -1 --pretty="format:%an"')
    git_date = git('git --no-pager log -1 --pretty="format:%ci"')
except:
    git_revision = "unknown Git revision"
    git_author = "unknown Git author"
    git_date = "unknown Git date"

rst_epilog = """
.. |git-revision| replace:: ``{git_revision}``
.. |git-author| replace:: {git_author}
.. |git-date| replace:: ``{git_date}``
""".format(git_revision=git_revision,
           git_author=git_author,
           git_date=git_date)

# This is needed to be able to put .. bibliography:: in a "References" section in HTML and
# just in the main document in LaTeX. (Otherwise Sphinx produces an empty "References"
# section in LaTeX.)

if tags.has('latex'):
    master_doc = 'index_latex'
    exclude_patterns.append('index.rst')
    exclude_patterns.append('zzz_references_html.rst')
else:
    master_doc = 'index'
    exclude_patterns.append('index_latex.rst')
    exclude_patterns.append('zzz_references_latex.rst')

# General information about the project.
project = 'PISM, a Parallel Ice Sheet Model'
copyright = '2004--2020, the PISM authors'
author = 'the PISM authors'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The short X.Y version.
version = '1.2.2'
# The full version, including alpha/beta/rc tags.
release = '1.2.2'

# The language for content autogenerated by Sphinx.
language = None

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# numbered figures and tables
numfig = True

# -- Options for HTML output ----------------------------------------------

html_context = {"git_revision": git_revision,
                "git_author": git_author,
                "git_date": git_date}

html_theme = 'alabaster'

html_show_sourcelink = False

html_theme_options = {"logo": "pism-logo.png",
                      "github_button": False,
                      "show_powered_by": False,
                      "body_text_align": "justify",
                      #                      "sidebar_collapse" : True,
                      }

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static', 'logo']

# Custom sidebar templates, must be a dictionary that maps document names
# to template names.
#
# This is required for the alabaster theme
# refs: http://alabaster.readthedocs.io/en/latest/installation.html#sidebars
html_sidebars = {
    '**': [
        'about.html',
        'navigation.html',
        'searchbox.html',
    ]
}

# -- Options for LaTeX output ----------------

latex_documents = [
    (master_doc, 'pism_manual.tex', project, author, 'manual'),
]

# latex_show_pagerefs = True

latex_elements = {
    'releasename': "version",
    'preamble': r'\usepackage{txfonts}'
}
