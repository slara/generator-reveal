# Changelog

## [v0.3.4](https://github.com/slara/generator-reveal/compare/v0.3.3...v0.3.4)


## [v0.3.3](https://github.com/slara/generator-reveal/compare/v0.3.1...v0.3.3)
### Changes
 - Library updates.
 - Update version of `reveal.js` in `bower.json` (i.e. `~2.6.1`).

## [v0.3.2](https://github.com/slara/generator-reveal/compare/v0.3.0...v0.3.1)
Same as `v0.3.1` but this time ran `prepublish` script. Compare https://github.com/isaacs/npm/issues/3856.

## [v0.3.1](https://github.com/slara/generator-reveal/compare/v0.3.0...v0.3.1)
### Changes
- Lock down version of `reveal.js` in `bower.json` to specific commit.

### Fixes
- [Typo in markdown slide with notes](https://github.com/slara/generator-reveal/issues/28)

## v0.3.0
### Changes
- Add `grunt dist` task.
- Add optional `sass` support for custom themes.
- Clean up API: HTML slides behave the same as markdown slides:
    * Both may use the `--attributes` option.
    * HTML slides no longer need to contain their own encapsulating `<section>` element.
    * Support `{}`, `{"attr": "some-attr"}`, `{"filename":"some-filename"}` and `{"attr": "some-attr", "filename":"some-filename"}` as valid slide `Objects` in the `slides/list.json` `Array`.
- Use `.yo-rc.json`, i.e. store user input in config.
- Add Changelog :)
- Remove `coffee-script` as a production dependency.

### Fixes
- [Support for vertical slides](https://github.com/slara/generator-reveal/pull/27)

## v0.2.0
### Changes
- Rewritten in Coffee, but keeping API compatibility.
- Add `--attributes` option.
