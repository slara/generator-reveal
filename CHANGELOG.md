# Changelog

## [v1.0.0](https://github.com/slara/generator-reveal/compare/v0.5.9...v1.0.0)
### Breaking
 - Drop support for node `v0.10` and `v0.12`.
 
### Changes
 - Update yeoman-generator dependency to `v1`.
 - Update all packaged dependencies like `reveal.js`, `grunt`, etc. to the latest version.

## [v0.5.9](https://github.com/slara/generator-reveal/compare/v0.5.8...v0.5.9)
### Changes
 - Update yeoman-generator dependency to `v0.23`.

## [v0.5.8](https://github.com/slara/generator-reveal/compare/v0.5.7...v0.5.8)
### Fixes
 - Update `grunt-sass` dependency in generated `package.json` ([#76](https://github.com/slara/generator-reveal/pull/76)).

## [v0.5.7](https://github.com/slara/generator-reveal/compare/v0.5.6...v0.5.7)
### Fixes
 - Only gitignore `/index.html` in generated directory ([#75](https://github.com/slara/generator-reveal/pull/75)).

## [v0.5.6](https://github.com/slara/generator-reveal/compare/v0.5.5...v0.5.6)
### Changes
 - Update dependencies in generated `bower.json` ([#74](https://github.com/slara/generator-reveal/pull/74)).

## [v0.5.5](https://github.com/slara/generator-reveal/compare/v0.5.4...v0.5.5)
### Changes
 - Update yeoman-generator dependency to `v0.22`.

## [v0.5.4](https://github.com/slara/generator-reveal/compare/v0.5.3...v0.5.4)
### Changes
 - Use `repository` entry of generated package.json file for configuration of `grunt deploy` task ([#73](https://github.com/slara/generator-reveal/pull/73)).

## [v0.5.3](https://github.com/slara/generator-reveal/compare/v0.5.2...v0.5.3)
### Fixes
 - Fix possible slide filename regression ([commit](https://github.com/slara/generator-reveal/commit/04866942811385481dee5fb3913251bd4ffb4dea)).

## [v0.5.2](https://github.com/slara/generator-reveal/compare/v0.5.1...v0.5.2)
### Fixes
 - Enable syntax highlighting by default (#69).

### Changes
 - Update dependencies of generator.

## [v0.5.1](https://github.com/slara/generator-reveal/compare/v0.5.0...v0.5.1)
### Fixes
 - Fix path to font css in theme.scss template.

## [v0.5.0](https://github.com/slara/generator-reveal/compare/v0.4.1...v0.5.0)
### Changes
 - Update dependencies in own `package.json` and generated `package.json`. **Possibly breaking change.**
 - Most importantly update `reveal.js` to `v3` and everything that goes along with it. **Possibly breaking change.**
 - Dropped dependency on `ruby sass` for custom themes. `node-sass` does it now.

## [v0.4.1](https://github.com/slara/generator-reveal/compare/v0.4.0...v0.4.1)
### Changes
 - Bump dependencies.
 - Allow for resource inclusion. Thanks to @atomaka.


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
