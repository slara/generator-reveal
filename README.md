# Generator-reveal

A Yeoman generator for the Awesome Reveal.js presentation framework.
http://lab.hakim.se/reveal-js/#/

---

## Usage

Install `generator-reveal`:
```
npm install -g generator-reveal
```

Make a new directory, and `cd` into it:
```
mkdir my-new-project && cd $_
```

Run `yo reveal`:
```
yo reveal
```

After all files are created you can view your slides with `grunt`

```bash
grunt server
```

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
