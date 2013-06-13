# Generator-reveal

A Yeoman generator for Reveal.js.

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

And the slide filename will be added to your `slides/list.json` file.

```json
["index.md", "slide-title.md"]
```

## License
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
