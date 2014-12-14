# Changelog

## [v0.4.0](https://github.com/slara/generator-reveal/compare/v0.3.10...v0.4.0)
### Fixes
 - Fix path to fonts for dist and deploy tasks. Thanks to @mischah.

### Changes
 - Remove `grunt server` task. Use `grunt serve` instead.
 - Library updates. **Possibly breaking change.**
 - Update `npm` and `node` engine requirements. **Possibly breaking change.**

## [v0.3.10](https://github.com/slara/generator-reveal/compare/v0.3.9...v0.3.10)
### Changes
 - Add Highlight.js support using reveal-highlight-themes. Thanks to @nwinkler.
 - Add Reveal theme selection on generator prompt. Thanks to @tristola.
 - Library updates.

## [v0.3.9](https://github.com/slara/generator-reveal/compare/v0.3.8...v0.3.9)
### Changes
 - Library updates.

## [v0.3.8](https://github.com/slara/generator-reveal/compare/v0.3.7...v0.3.8)
### Fixes
 - Fix font path in `Theme.scss`

## [v0.3.7](https://github.com/slara/generator-reveal/compare/v0.3.6...v0.3.7)
### Fixes
 - Fix whitespace issue in `_Gruntfile` template. Thanks to @daformat.

## [v0.3.6](https://github.com/slara/generator-reveal/compare/v0.3.5...v0.3.6)
### Changes
 - Add documentation for `grunt deploy` task

## [v0.3.5](https://github.com/slara/generator-reveal/compare/v0.3.4...v0.3.5)
### Changes
 - Add `grunt deploy` task

### Fixes
 - [Add pdf print fix from `reveal.js`](https://github.com/slara/generator-reveal/pull/40)
 - [Mark xhr.status=0 as successful](https://github.com/slara/generator-reveal/pull/36)

## [v0.3.4](https://github.com/slara/generator-reveal/compare/v0.3.3...v0.3.4)
### Changes
 - Library updates.

### Fixes
 - [Import path of search.js plugin](https://github.com/slara/generator-reveal/pull/34).


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
