# Reveal.js generator [![Dependency Status](https://david-dm.org/slara/generator-reveal.png)](https://david-dm.org/slara/generator-reveal) [![devDependency Status](https://david-dm.org/slara/generator-reveal/dev-status.png)](https://david-dm.org/slara/generator-reveal#info=devDependencies)

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

Then, create further slides with `yo reveal:slide more-content`.

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
<section>
    <h2>Slide Title</h2>

    <p>This is a new slide</p>
</section>

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

##### Mardown with (Data-)Attributes

Invoked with `--markdown --attributes`

```bash
yo reveal:slide "Slide Title" --markdown --attributes
```
adds a slide object with an `attr` key to your `slides/list.json` file. Attributes will be passed to `section` element containing the markdown.

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
<section>
    <h2>Slide Title</h2>

    <p>This is a new slide</p>

    <aside class="notes">
        Put your speaker notes here.
        You can see them pressing 's'.
    </aside>
</section>

```
For markdown, just add `--markdown`.

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
