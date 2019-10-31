Yugo  (融合)
============

(Fusion in Japanese)

![Yugo Ad](/extra/yugo-ad.jpg)

Runtime
-------

A Ruby / Rack runtime that tries to mimic the runtime semantics of ColdFusion. It would consist of a
directory (or nested directories) of ERB files that would be rendered by calling their relative path as a url.

For example:

    yugo-hello/templates/hello.cfm.erb

would render as,

    localhost:3990/hello.cfm

and

    yugo-hello/templates/this/is/a/test/hello.html.erb
    yugo-hello/templates/this/is/a/test/hello.erb

would render as,

    localhost:3990/this/is/a/test/hello.html
    localhost:3990/this/is/a/test/hello

The root directory of a site would contain a config.ru file that would load the runtime and handle the page
rendering.

Compiler
--------

We'll build a compiler that generates an AST and generated Yugo runtime code.
