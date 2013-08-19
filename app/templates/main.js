'use strict';
var appendSlides = function (data) {
  var slides = data;
  var mdtemplate = $('#slide-template-markdown').html();
  var htmltemplate = $('#slide-template').html();
  var verticaltemplate = $('#vertical-template').html();
  var mdtempl = Handlebars.compile(mdtemplate);
  var htmltempl = Handlebars.compile(htmltemplate);
  var verticaltempl = Handlebars.compile(verticaltemplate);
  slides.forEach(function (slide, index) {
    var templ;
    if (Object.prototype.toString.call(slide) === '[object Array]') {
      var verticalindex = 'vertical-' + index;
      $('.slides').append(verticaltempl({'ident': verticalindex}));

      slide.forEach(function (slide) {
        if (slide.indexOf('.html') !== -1) {
          templ = htmltempl;
        } else if (slide.indexOf('.md') !== -1) {
          templ = mdtempl;
        }
        $('.vertical-' + index).append(templ({'file': slide}));
      });

    } else {
      if (slide.indexOf('.html') !== -1) {
        templ = htmltempl;
      } else if (slide.indexOf('.md') !== -1) {
        templ = mdtempl;
      }
      $('.slides').append(templ({'file': slide}));
    }
  });
};

