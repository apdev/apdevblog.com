function loadGists() {
  var els = $('a[data-json-url]'), gists = {}, code = [], stylesheets = [];
  // Get elements referencing a gist and build a gists hash referencing the elements that use it
  els.each(function(idx, rawEl) {
    var el = $(rawEl), gist = el.attr('data-json-url');
    rawEl.gist = gist;
    rawEl.file = el.attr('data-file');
    gists[gist] = gists[gist] || { targets: [] };
    gists[gist].targets.push(el);
  });
  // Load the gists
  $.each(gists, function(name, data) {
    $.getJSON(name + '?callback=?', function(data) {
      var gist = gists[name];

      var gistMarkupFragment = document.createDocumentFragment();
      // add div since you can't innerHTML on a documentFragment
      var div = document.createElement("div");
      div.innerHTML = data.div;
      gistMarkupFragment.appendChild(div);

      // get all file div's
      var gistFileEl = gistMarkupFragment.querySelectorAll(".gist-file");

      // get div that contains all file divs
      var gistContainerElement = gistMarkupFragment.children.item(0).children.item(0);
      gistContainerElement.innerHTML = "";

      // Iterate elements refering to this gist
      $(gist.targets).each(function(idx, target) {
        var file = target.get(0).file;
        if(file) {
          var o = gistContainerElement.cloneNode();
          // TODO find matching file element
          o.appendChild(gistFileEl.item(0));

          // override the anchor
          var targetParent = target[0].parentNode;
          targetParent.innerHTML = "";
          targetParent.appendChild(o);
        }
        else {
          target.replaceWith(data.div);
        }
      });
    });
  });
}

loadGists();