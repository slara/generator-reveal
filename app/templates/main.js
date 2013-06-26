
var append_slides = function (data) {
  var slides = data;
  var md_template = $('#slide-template-markdown').html();
  var html_template = $('#slide-template').html();
  var vertical_template = $('#vertical-template').html();
  var md_templ = Handlebars.compile(md_template);
  var html_templ = Handlebars.compile(html_template);
  var vertical_templ = Handlebars.compile(vertical_template);
  slides.forEach(function (slide, index) {

  if (Object.prototype.toString.call(slide) === '[object Array]') {
      var vertical_ident = 'vertical-' + index;
      console.log(vertical_ident);
      $('.slides').append(vertical_templ({'ident': vertical_ident}))

      slide.forEach(function (slide) {
        if (slide.indexOf('.html') !== -1) {
          var templ = html_templ;
        } else if (slide.indexOf('.md') !== -1) {
          var templ = md_templ;
        }
        $('.vertical-' + index).append(templ({'file': slide}));
      });

    } else {
      if (slide.indexOf('.html') !== -1) {
        var templ = html_templ;
      } else if (slide.indexOf('.md') !== -1) {
        var templ = md_templ;
      }
      $('.slides').append(templ({'file': slide}));
    }
  });
};

