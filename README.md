# Reveal.js generator [![Build Status](https://travis-ci.org/slara/generator-reveal.png?branch=master)](https://travis-ci.org/slara/generator-reveal) [![Coverage Status](https://coveralls.io/repos/slara/generator-reveal/badge.png)](https://coveralls.io/r/slara/generator-reveal) [![NPM version](https://badge.fury.io/js/generator-reveal.png)](http://badge.fury.io/js/generator-reveal)
 [![Dependency Status](https://david-dm.org/slara/generator-reveal.png)](https://david-dm.org/slara/generator-reveal) [![devDependency Status](https://david-dm.org/slara/generator-reveal/dev-status.png)](https://david-dm.org/slara/generator-reveal#info=devDependencies) [![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/)

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
grunt server
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

## Customisation

To change the options of the whole presentation, such as the theme used,
transition effect etc. consult the
[Reveal.js documentation](https://github.com/hakimel/reveal.js#readme).
An important difference, though, is that you should not edit the `index.html`
file directly as it gets overwritten as you add presentation content
whenever a new grunt build is triggered.
You should instead edit the `templates/_index.html` file, which is used as a
template for the automatically generated `index.html`.

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
