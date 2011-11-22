The Yorker Website
==================

You're browsing the main codebase for the news website 'The Yorker'.
The purpose of this file is to give you an overview of how the site
and codebase are structured.

Stack
-----

Briefly, the site was built, and is intended to be run, on

Linux - Ruby 1.9 - Rails 3

TODO: database

Some bits of the stack will be more version-dependent than others; use
your imagination.

Structure
---------

This is a fairly standard rails application.


Glossary
--------


* **Article**: A rich-text document created by a *writer*
* **Editor**:
* **Publish**: An *editor*, making an *article* written by a *writer* publicly available
* **Section**:
* **Submit**: A *writer*, making an *article* available to an *editor*
* **Withdraw**: An *editor* or a *writer* making an *article* unavailable.
* **Writer**:



Key Models
----------

### User


Represents users (writers and commenters)

### Section

Represents sections, in a tree

### Article

Represents articles, which are in exactly one section


Secondary Models
----------------

### Editor

Represents users having 'Editor' priveleges wrt a section.

Do we want to extend this to some more general concept of a role?

### Author?

Should we model relationships between authors and articles?

### Visibility?

Should we model visibilty of articles

Public-Facing Views
-------------------

* Article
* Section

Internal-Facing Views
---------------------





Article Pipeline
-----------------

### Top Level

Writer: Create -> Edit -> Submit
Editor: Read -> Edit -> Comment -> Request Revision
Writer: Revise -> Submit
Editor: Read -> Publish




Workflows
---------


Patterns
--------

**Ubiquitous Search**

**Low Barriers To Entry**

**Ad-Hoc Organisation**


