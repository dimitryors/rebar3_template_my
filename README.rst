rebar3 my template
=========================

A `rebar3 <http://rebar3.org>`_ template for my applications.

Setup
-----

`Install rebar3 <http://www.rebar3.org/docs/getting-started>`_ if you haven't already.

then install this template::

    mkdir -p ~/.config/rebar3/templates
    git clone https://github.com/dimitryors/rebar3_template_my.git ~/.config/rebar3/templates/rebar3_template_my

Use
---

:: 

    rebar3 new my name=some_app
    cd some_app
    rebar3 release
    rebar3 shell


Author
------

Dmitry Orshansky

License
-------

Apache 2.0
