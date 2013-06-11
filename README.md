# Generator-reveal

A Reveal.js generator for Yeoman.

## Usage

Install `generator-reveal`:
```
npm install generator-reveal
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
Generates a Slide Markdown file. 

Example:
```bash
yo reveal:slide "Slide Title"
```

Produces `slides/slide-title.md`:
```markdown
## Slide Title

This is a new slide
```

After you fill your slide, you need to add 

```html
<section data-markdown="slides/slide-title.md"></section>
```

to your `index.html` file, inside the `slides` div.



## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
