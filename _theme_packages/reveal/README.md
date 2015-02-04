Reveal Theme for Jekyll Bootstrap
=================================

This is a "theme" for [jekyll bootstrap](http://jekyllbootstrap.com/)(JB)
that makes it easy to add presentations
made with the awesome
[reveal.js](http://lab.hakim.se/reveal-js/) library by 
[Hakim El Hattab](http://hakim.se/)
to your github-pages.
It's really just a copy of the reveal-library
packaged according to JB's
[theme api](http://jekyllbootstrap.com/api/theme-api.html)
so it plays along nicely with pages made with JB.

As jekyll parses markdown
and nicely handles the section tags
there is no need for reveal's own on-the-fly markdown parser.

For information on how to use reveal.js
see the README.md in
`assets/themes/reveal/`.

See it in action on http://kjarnet.no/jb-theme-reveal/.

Installation
------------
The theme is packaged to be installed with
JekyllBootstrap's rake script.
See instructions on 
[the JekyllBootstrap page](http://jekyllbootstrap.com/usage/jekyll-theming.html#install_themes).
The url to the git-repo is https://github.com/kjarnet/jb-theme-reveal.git
Alternatively, if you don't have ruby/rake,
just merge the _includes and assets folders
into the ones on your JekyllBootstrap site.

**NB**: 
Appearently, github's default markdown parser
doesn't parse markdown between `<section>` tags,
so you have to use redcarpet instead:
In your _config.yml file,
add a line "`markdown: redcarpet`"
somewhere at the top (at the root level).


Use as main theme
-----------------

You can use the theme for the whole page,
if you don't need any "normal" web-pages. 
Then you'd activate it as usual with
`rake theme:switch name="reveal"`
and write your index-page as pure slides
(using markdown if you wish)
like so:

    ---
    layout: page
    title: Header Title
    description: Description for meta tag
    ---
    <section>
    # Title-Slide header #
    Title-Slide sub-title
    </section>
    <section>
    ## Slide 2 header ##
    Slide 2 content
    </section>
    ...

(you only need layout in the front matter
as all other fields (title, tagline etc.)
are ignored.
It doesn't matter if you use
page- or post-layout
as they are identical).

Use only on sub-pages
---------------------

A more likely scenario is
that you'd like a slideshow
as a sub-page of your site
along with normal jekyll-pages
that use another theme.
To accoplish this,
use a normal theme for your site in general
(you can switch to a normal theme with e.g.
`rake theme:switch name="twitter"`).
Then add a custom layout
by adding something like
these two pages in the \_layouts folder:

presdefault.html:

    ---
    theme :
      name : reveal
    ---
    {% include JB/setup %}
    {% include themes/reveal/default.html %}

presentation.html:

    ---
    layout: presdefault
    ---
    {% include JB/setup %}
    {% include themes/reveal/page.html %}


Your presentation-page
(e.g. mycoolpres.md)
would then be something like this instead:

    ---
    layout: presentation
    title: Header Title
    description: Description for meta tag
    ---
    <section>
    # Title-Slide header #
    Title-Slide sub-title
    </section>
    <section>
    ## Slide 2 header ##
    Slide 2 content
    </section>
    ...

i.e. it would use the "presentation" layout
you just defined.

Credits
-------

All design and code by 
[Hakim El Hattab](http://hakim.se/).

License
-------

For the license of reveal.js
see the README.md in
`assets/themes/reveal/`.
This includes everything under that folder
as well as the file
`_includes/themes/reveal/default.html`
(i.e. nearly all code in this repository).

The rest is MIT license.


