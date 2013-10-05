/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;


describe('reveal generator', function () {
  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('reveal:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates expected files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.jshintrc',
      'index.tpl',
      '.editorconfig',
      'package.json',
      'Gruntfile.coffee',
      'bower.json',
      'config.json',
      'js/loadhtmlslides.js',
      'slides/list.json'
    ];

    helpers.mockPrompt(this.app, {
      'someOption': 'Y'
    });
    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFiles(expected);
      done();
    });
  });

  describe('generated package.json', function () {
    it('should have a version', function (done) {
      helpers.mockPrompt(this.app, {
        'presentationTitle': 'package.json test',
        'packageVersion': '1.2.3'
      });
      this.app.options['skip-install'] = true;
      this.app.run({}, function () {
        helpers.assertFile('package.json', /"version": "1.2.3"/);
        done();
      });
    });
  });
});
