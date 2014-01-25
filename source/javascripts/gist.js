var loadJSONP = (function(){
  // Source: https://gist.github.com/132080/110d1b68d7328d7bfe7e36617f7df85679a08968
  var unique = 0;
  return function(url, callback, context) {

    var originalUrl = url;

    var name = "_jsonp_" + unique++;
    if (url.match(/\?/)) url += "&callback="+name;
    else url += "?callback="+name;

    // Create script
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;

    // Setup handler
    window[name] = function(data){
      callback.call((context || window), data, originalUrl);
      document.getElementsByTagName('head')[0].removeChild(script);
      script = null;
      delete window[name];
    };
    
    // Load JSON
    document.getElementsByTagName('head')[0].appendChild(script);
  };
})();

function replaceElement(oldEl, newEl) {
  var parent = oldEl.parentNode;
  parent.innerHTML = '';
  parent.appendChild(newEl);
}

function loadGists() {
  var gists = {},
    els = document.querySelectorAll('a[data-json-url]');

  // Get elements referencing a gist and build a gists hash referencing 
  // the elements that use it
  [].forEach.call(els, function(el) {
    var gist = {},
      jsonUrl = el.getAttribute('data-json-url');

    gist.el = el;
    gist.file = el.getAttribute('data-file');

    gists[jsonUrl] = gists[jsonUrl] || [];
    gists[jsonUrl].push(gist);
  });

  // Load the gists
  for(var key in gists) {
    loadJSONP(key, function(data, url) {
      var gist = gists[url],
        gistMarkupFragment, helperDiv, gistFileEl, gistContainerElement;

      gistMarkupFragment = document.createDocumentFragment();
      // add div since you can't innerHTML on documentFragment
      helperDiv = document.createElement('div');
      helperDiv.innerHTML = data.div;
      gistMarkupFragment.appendChild(helperDiv);

      // get all file div's
      gistFileEl = gistMarkupFragment.querySelectorAll('.gist-file');

      // get div that contains all file divs
      gistContainerElement = gistMarkupFragment.firstChild.firstChild;

      // Iterate elements refering to this gist
      gist.forEach(function(gistData) {
        var file = gistData.file,
          newGistElement;

        if(file) {
          newGistElement = gistContainerElement.cloneNode(false);
          newGistElement.appendChild(gistFileEl.item(data.files.indexOf(file)));

          // override the anchor
          replaceElement(gistData.el, newGistElement);
        }
        else {
          newGistElement = gistContainerElement.cloneNode(true);
          // override the anchor
          replaceElement(gistData.el, newGistElement);
        }
      });
    });
  }
}

loadGists();