HTMLWidgets.widget({
  name: "ShinyIGV",
  type: "output",
  renderValue: function(el, data) {
  options = {
            reference: data.ref,
            tracks: data.tracks
        };
        browser = igv.createBrowser(el, options);
        igv.browser.search(data.search);
  }
});
