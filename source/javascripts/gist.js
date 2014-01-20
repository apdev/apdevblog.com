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
      gist.data = data;
      gist.files = $(gist.data.div).find('.gist-file');
      gist.outer = $(gist.data.div).first().html('');
      // Iterate elements refering to this gist
      $(gist.targets).each(function(idx, target) {
        var file = target.get(0).file;
        if(file) {
          var o = gist.outer.clone();
          var c = '<div class="gist-file">' + $(gist.files.get(gist.data.files.indexOf(file))).html() + '</div>';
          o.html(c);
          target.replaceWith(o);
        }
        else {
          target.replaceWith(gist.data.div);
        }
      });
    });
  });
}

loadGists();