# Reveal.js generator [![Build Status](https://travis-ci.org/slara/generator-reveal.svg?branch=master)](https://travis-ci.org/slara/generator-reveal) [![Coverage Status](https://img.shields.io/coveralls/slara/generator-reveal.svg)](https://coveralls.io/r/slara/generator-reveal?branch=master) [![NPM version](https://badge.fury.io/js/generator-reveal.svg)](http://badge.fury.io/js/generator-reveal)
 [![Dependency Status](https://david-dm.org/slara/generator-reveal.svg)](https://david-dm.org/slara/generator-reveal) [![devDependency Status](https://david-dm.org/slara/generator-reveal/dev-status.svg)](https://david-dm.org/slara/generator-reveal#info=devDependencies)

A [Yeoman](http://yeoman.io) generator for the awesome [Reveal.js](http://lab.hakim.se/reveal-js/) presentation framework.

## Usage

Install:  `npm install -g generator-reveal`

Make a new directory, and `cd` into it:
```
mkdir my-new-project && cd $_
```

Run `yo reveal` and start building your presentation.

After all files are created you can view your slides with `grunt`:

```bash
grunt serve
```

Then, create further slides with `yo reveal:slide more-content`. See below for available [options](#options). When you want to export your presentation to some static HTML server, you can type `grunt dist` to have all your relevant files saved to the `dist` directory.

## Generators

Available generators:

* [reveal:slide](#slide)

### Slide
Generates a Slide file.

Example:
```bash
yo reveal:slide "Slide Title"
```

Produces `slides/slide-title.html`:

```html
<h2>Slide Title</h2>

<p>This is a new slide</p>
```

And the slide filename will be added to your `slides/list.json` file.

```json
[
    "index.md",
    "slide-title.html"
]
```

#### Vertical Slides

In order to add vertical slides, you can nest an array inside `slides/list.json`

```json
[
    "index.md",
    [
        "vertical-html.html",
        "vertical-markdown.md"
    ],
    [
        "vertical-html-2.html",
        "vertical-markdown-2.md"
    ],
    "the-end.md"
]
```

#### Simple (Image) Slides

Sometimes you just want a slide with a background image. That's okay, a slide object does not need a filename.

```json
[
    "index.md",
    {
        "attr": {
            "data-background": "http://example.com/image.png"
        }
    }
]
```

#### Options

##### Markdown

Invoked with `--markdown`

```bash
yo reveal:slide "Slide Title" --markdown
```

Produces `slides/slide-title.md`


```markdown
## Slide Title

This is a new slide
```

##### Attributes

Invoked with `--attributes`

```bash
yo reveal:slide "Slide Title" --attributes
```

adds a slide `Object` with an `attr` key to your `slides/list.json` file. Attributes will be passed to `section` element containing the slide.

```json
[
    "index.md",
    {
        "filename": "slide-title.md",
        "attr": {
            "data-background": "#ff0000"
        }
    }
]
```

```html
<section data-markdown="slides/slide-title.md" data-background="#ff0000"></section>
```

##### Speaker Notes

Invoked with `--notes`

```bash
yo reveal:slide "Slide Title" --notes
```

Produces `slides/slide-title.html`:

```html
<h2>Slide Title</h2>

<p>This is a new slide</p>

<aside class="notes">
    Put your speaker notes here.
    You can see them pressing 's'.
</aside>
```

All three options maybe combined, e.g.

```bash
yo reveal:slide "Markdown Slide With Notes And Section-Attributes" --notes --attributes --markdown
```

## Github Pages Deployment

With the help of [Grunt Build Control](https://github.com/robwierzbowski/grunt-build-control), `generator-reveal` can deploy your presentation to Github Pages easily. All you have to do is

* Set your username and repository name when you call `yo reveal`
* Create and configure your remote Github repository for the presentation
* Push your first commit
* Deploy with `grunt deploy`

If everything goes right, `grunt deploy` will build and push your presentation to a gh-pages git branch. Just give it a couple of minutes, fire up a browser and go to http://username.github.io/repositoryname to see your brand new presentation.



## Customisation

To change the options of the whole presentation, such as the theme used,
transition effect etc. consult the
[Reveal.js documentation](https://github.com/hakimel/reveal.js#readme).
An important difference, though, is that you should not edit the `index.html`
file directly as it gets overwritten as you add presentation content
whenever a new grunt build is triggered.
You should instead edit the `templates/_index.html` file, which is used as a
template for the automatically generated `index.html`.

### Highlight.js Syntax Themes

The generated presentation app includes the [Highlight.js Syntax Themes for Reveal.js](https://github.com/nwinkler/reveal-highlight-themes) as a dependency, allowing you to change the syntax theme.

The available syntax themes can be found in the `bower_components/reveal-highlight-themes` folder. Selecting a new syntax theme can be done by changing the stylesheet reference in the `templates/_index.html` file:

```html
<!-- For syntax highlighting -->
<link rel="stylesheet" href="bower_components/reveal-highlight-themes/styles/monokai_sublime.css" id="highlight-theme">
```

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
