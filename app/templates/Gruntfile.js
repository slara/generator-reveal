// Generated on <%= (new Date).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
'use strict';
var moment = require('moment');

var LIVERELOAD_PORT = 35729;
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
  return connect.static(require('path').resolve(dir));
};

module.exports = function (grunt) {
  // load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.initConfig({
    watch: {
      options: {
        nospawn: true,
        livereload: LIVERELOAD_PORT
      },
      livereload: {
        files: [
          'index.html',
          'slides/*.md'
        ],
        tasks: ['build']
      }
    },
    connect: {
      options: {
        port: 9000,
        // change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      },
      livereload: {
        options: {
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.')
            ];
          }
        }
      }
    },
    open: {
      server: {
        path: 'http://localhost:<%%= connect.options.port %>'
      }
    }
  });

  grunt.registerTask('server', ['build', 'connect:livereload', 'open', 'watch']);

  grunt.registerTask('build', 'Build your blog.', function () {
    var words = [];
    var slides = [];

    var ignoredWords = [
      'the', 'couldn\'t', 'you\'re', 'you\'ve', 'just', 'something', 'some',
      'thing', 'um', 'ahh', 'ah', 'uh', 'if', 'out', 'at', 'no', 'with', 'had',
      'got', 'have', 'for', 'it\'s', 'that', 'that\'s', 'from', 'in', 'a', 'of',
      'them', 'you', 'his', 'her', 'their', 'there', 'how', 'what', 'why',
      'who', 'when', 'i', 'went', 'to', 'they', 'you\'ll', 'welcome', 'are'
    ];

    var unslug = function (slug) {
      return slug.replace(/(-(\w))/g, function () { return ' ' + arguments[2].toUpperCase(); });
    };

    grunt.file.recurse('slides', function (post, root, sub, fileName) {
      if (fileName === 'index.md') {
        return;
      }

      var wordMap = {};

      slides.push(fileName.replace('.md', ''));
      words.push('id:' + fileName.replace('.md', ''));

      post = grunt.file.read(post)
        .toLowerCase()
        .trim()
        .replace(/\s+/gm, ' ');

      post.split(' ').forEach(function (word) {
        if (word.length > 5 && ignoredWords.indexOf(word) === -1) {
          if (wordMap[word]) {
            wordMap[word].count++;
          } else {
            wordMap[word] = {
              name: word,
              count: 1
            };
          }
        }
      });

      wordMap = grunt.util._.chain(wordMap).sortBy('count').reverse().value();

      var postWords = [];

      while (postWords.length < 10) {
        postWords.push(wordMap[postWords.length] && wordMap[postWords.length].name || '');
      }

      words.push(postWords);
    });

    words = grunt.util._.chain(words).flatten().reject(function (word) { return !word; }).value();

    grunt.file.write('wordmap.json', JSON.stringify(words));
    grunt.file.write('slides/index.md', function () {
      var file = '# ' + grunt.file.readJSON('config.json').name + '\n';
      var lastDate;

      slides.reverse().forEach(function (post) {
        var postDate = post.replace(/((\d*-\d*-\d*).*)/, '$2');
        var title = post.replace(postDate, '').replace(/\s+/g, ' ').trim();

        if (lastDate !== postDate) {
          file += '\n### ' + moment(postDate).format('dddd, MMMM Do, YYYY');
        }

        file += '\n#### [' + postDate + ' -' + unslug(title) + '](#' + postDate + title + ')';

        lastDate = postDate;
      });

      return file.trim();
    }());
  });
};
