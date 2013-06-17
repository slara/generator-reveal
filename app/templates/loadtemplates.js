// Modified from markdown.js from Hakim to handle external html files

(function () {
    var querySlidingHtml = function() {
        var sections = document.querySelectorAll('[data-html]'),
            section;

        for (var j = 0, jlen = sections.length; j < jlen; j++) {
            section = sections[j];

            if ( section.getAttribute('data-html').length ) {

                var xhr = new XMLHttpRequest(),
                    url = section.getAttribute('data-html');

                xhr.onreadystatechange = function () {
                    if( xhr.readyState === 4 ) {
                        if( xhr.status >= 200 && xhr.status < 300 ) {
                            section.outerHTML = xhr.responseText;
                        } else {
                            section.outerHTML = '<section data-state="alert">ERROR: The attempt to fetch ' + url + ' failed with the HTTP status ' + xhr.status +
                                '. Check your browser\'s JavaScript console for more details.</p></section>';
                        }
                    }
                };

                xhr.open('GET', url, false);
                try {
                    xhr.send();
                } catch (e) {
                    alert('Failed to get file' + url + '.' + e);
                }
            };
        }
    };

    querySlidingHtml();
})();