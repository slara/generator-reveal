<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">

        <title><%= _.capitalize(presentationTitle) %></title>

        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <link rel="stylesheet" href="bower_components/reveal.js/css/reveal.min.css">
    <% if (useSass) { %>
        <link rel="stylesheet" href="css/theme.css" id="theme">
    <% } else { %>
        <link rel="stylesheet" href="bower_components/reveal.js/css/theme/default.css" id="theme">
    <% } %>

        <!-- For syntax highlighting -->
        <link rel="stylesheet" href="bower_components/reveal.js/lib/css/zenburn.css" id="highlight-theme">

        <!-- If the query includes 'print-pdf', use the PDF print sheet -->
        <script>
          document.write( '<link rel="stylesheet" href="bower_components/reveal.js/css/print/' + ( window.location.search.match( /print-pdf/gi ) ? 'pdf' : 'paper' ) + '.css" type="text/css" media="print">' );
        </script>

        <!--[if lt IE 9]>
        <script src="lib/js/html5shiv.js"></script>
        <![endif]-->
    </head>

    <body>

        <div class="reveal">

            <div class="slides">

                <%% _.forEach(slides, function(slide) { %>
                    <%% if (!_.isString(slide) && !_.isArray(slide) && _.isObject(slide)) { %>
                        <section <%%= _.map(slide.attr, function (val, attr) {return attr + '="' + val + '"'}).join(' ')%> <%% if (_.isString(slide.filename)) { %>data-<%% if (slide.filename.indexOf('.html') !== -1) { %>html<%% } else { %>markdown<%% }%>="slides/<%%= slide.filename %>"<%% } %>></section>
                    <%% } %>
                    <%% if (_.isString(slide)) { %>
                        <section data-<%% if (slide.indexOf('.html') !== -1) { %>html<%% } else { %>markdown<%% }%>="slides/<%%= slide %>"></section>
                    <%% } %>
                    <%% if (_.isArray(slide)) { %>
                        <section>
                            <%% _.forEach(slide, function(verticalslide) { %>
                                <%% if (!_.isString(verticalslide) && _.isObject(verticalslide)) { %>
                                    <section <%%= _.map(verticalslide.attr, function (val, attr) {return attr + '="' + val + '"'}).join(' ')%> <%% if (_.isString(verticalslide.filename)) { %>data-<%% if (verticalslide.filename.indexOf('.html') !== -1) { %>markdown<%% } else { %>html<%% }%>="slides/<%%= verticalslide.filename %>"<%% } %>></section>
                                <%% } %>
                                <%% if (_.isString(verticalslide)) { %>
                                    <section data-<%% if (verticalslide.indexOf('.html') !== -1) { %>html<%% } else { %>markdown<%% }%>="slides/<%%= verticalslide %>"></section>
                                <%% } %>
                            <%% }); %>
                        </section>
                    <%% } %>
                <%% }); %>
            </div>

        </div>

        <script src="bower_components/reveal.js/lib/js/head.min.js"></script>
        <script src="bower_components/reveal.js/js/reveal.min.js"></script>
        <script>
            // Configure Reveal
            // Full list of configuration options available here:
            // https://github.com/hakimel/reveal.js#configuration
            Reveal.initialize({
                controls: true,
                progress: true,
                history: true,
                center: true,

                theme: Reveal.getQueryHash().theme, // available themes are in /css/theme
                transition: Reveal.getQueryHash().transition || 'default', // default/cube/page/concave/zoom/linear/fade/none

                // Optional libraries used to extend on reveal.js
                dependencies: [
                    { src: 'bower_components/reveal.js/lib/js/classList.js', condition: function() { return !document.body.classList; } },
                    { src: 'bower_components/reveal.js/plugin/markdown/marked.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                    { src: 'bower_components/reveal.js/plugin/markdown/markdown.js', condition: function() { return !!document.querySelector( '[data-markdown]' ); } },
                    { src: 'bower_components/reveal.js/plugin/highlight/highlight.js', async: true, callback: function() { hljs.initHighlightingOnLoad(); } },
                    { src: 'bower_components/reveal.js/plugin/zoom-js/zoom.js', async: true, condition: function() { return !!document.body.classList; } },
                    { src: 'bower_components/reveal.js/plugin/notes/notes.js', async: true, condition: function() { return !!document.body.classList; } },
                    // { src: 'plugin/search/search.js', async: true, condition: function() { return !!document.body.classList; } }
                    //{ src: 'bower_components/reveal.js/plugin/remotes/remotes.js', async: true, condition: function() { return !!document.body.classList; } }

                    { src: 'js/loadhtmlslides.js', condition: function() { return !!document.querySelector( '[data-html]' ); } }
                ]
            });
        </script>

    </body>

</html>
