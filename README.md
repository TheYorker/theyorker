The Yorker Website
==================

You're browsing the main codebase for the news website 'The Yorker'.
The purpose of this file is to give you an overview of how the site
and codebase are structured.


Server Configuration
--------------------

This is correct for Debian 6.0 as of 06/01/12

```bash
    # too many servers don't install any locales,
    # so let's supress all those nasty error messages
    apt-get install locales
    dpkg-reconfigure locales

    # install basic packages
    apt-get install build-essential git-core curl zlib1g zlib1g-dev libssl-dev libopenssl-ruby libcurl4-openssl-dev postgresql

    # install rvm
    bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
    
    # exit & relogin to pick up rvm

    # install rvm packages
    rvm pkg install zlib
    rvm pkg install openssl

    # install ruby
    rvm install ruby-1.9.2
    rvm use ruby-1.9.2 --default

    # install passenger
    gem install passenger

    # if running on a VPS with little memory, something hacky may have
    # to happen here, like using a different VM for compilation
    passenger-install-nginx-module
    
    # install sphinx
    cd
    wget http://sphinxsearch.com/files/sphinx-2.0.3-release.tar.gz
    tar zxf sphinx-2.0.3-release.tar.gz
    cd sphinx-2.0.3-release.tar.gz
    ./configure --with-pgsql=`pg_config --pkgincludedir` --without-mysql
    make && make install
    cd

```



Stack
-----

Briefly, the site was built, and is intended to be run, on

Linux - Ruby 1.9 - Rails 3 - PostgreSQL

Otherwise known as heroku :)

Structure
---------

This is a fairly standard rails application.


Glossary
--------

* **Admin**: A *member* with broad-ranging authority to modify
    more-or-less anything dynamic.
* **Article**: A rich-text document created by a *writer*
* **Editor**: A *member* who has been given responsibility for some
    aspect of the journalistic management of The Yorker
* **Editorial Review**: The state of an *article* which has yet to be
    *published* but which is visible to *section* *editors* and
    available to be commented on, edited, or *published* by them; or,
    the process of commenting on, editing, and *publishing* an
    *article*.
* **Member**: Someone who has paid a membership fee to The Yorker
* **Pending**: The state of an article which is either *draft* or
    under *editorial review*
* **Publish**: To make an *article* visible to *visitors*
* **Section**: A hierarchial, themed grouping of *articles*
* **User**: Someone who is registered on The Yorker website.
* **Visitor**: Someone accessing The Yorker website to read news or
    participate in discussions.
* **Writer**: A *member* who writes *articles*

Layouts
-------

### Application ###

The main layout; all *visitor*-facing content renders within
this. It's where all the nice graphic design is spent.

### Member ###

All *member*-facing pages are rendered within this.

Public Views
------------

### Show Article ###

For a *visitor*, display an *article* formatted nicely for reading.

### Show Section ###

For a *visitor*, display a list of *articles* within subsections of a
given *section*.

Internal Views
--------------

### User Articles ###

For a *writer*, show *pending* and *published* *articles* by that
*writer*, and allow them to edit them, submit them for *editorial
review*, or *withdraw* them.

### User Sections ###

For an *editor*, show a nested list of sections for which they are an
*editor*, with an indication of the number of *pending* *articles* for
that section. Provides a link to each section to manage it.

### Edit Section ###

For an *editor*, show a list of *pending* and *published* *articles*
for a *section*, and allow them to edit them, *publish* them, or
*withdraw* them.

### Membership List ###

For an *admin*, allow them to edit the list of email addresses
corresponding to *members* of The Yorker for a given time period.

### Edit Article ###

For a *writer*, allow them to edit, submit for *editorial review*, or
*withdraw* an article.

### Review Article ###

For an *editor*, allow them to edit, *publish*, *withdraw*, or add
editorial comments to an article.

Core Principles
---------------

- Responsibility propagates up
- Mistakes are cheap

Principles
----------

### Sections are Hierarchical ###

All sections have exactly one parent, and are part of a tree which is
rooted at 'The Yorker'.

### Section Structure mirrors Organisational Structure ###

Permissions for parent sections are inherited for child sections.

### Editors Control Content Strategy ###

Currently, all this means is all articles are subject to editorial
review; further content-strategy management has to be done out of
band.

### All Visitor-visible content is Editorially Reviewed ###

*Writers* cannot themselves *publish* content directly to the public
 site.

This has two major exceptions. The first is that *writers* can alter
previously-published *articles*; these alterations take effect
immediately, and are therefore effectively *published* without the
intervention of an *editor*.

Solving this requires either:

1. Requiring a *writer* to *withdraw* an *article* prior to changing
it. This seems very horrible.
2. Only allowing *editors* to edit *articles* once they have been
*published*.
3. Introducing proper change manangement (i.e. version control)

The second is that, currently, the content of *section* and subsection
pages is determined automatically, through the fairly crude
instrument of an 'Importance' field on an *article*.

### All Mistakes are Reversible ###

Currently, this basically means 'only soft deletion'.

This is almost more false than true at the moment, as *article*
content is not versioned.

Proper change management will solve this.

---

David Morris, 2011

