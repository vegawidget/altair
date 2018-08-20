HTMLWidgets.widget({

  name: "vegawidget",

  type: "output",

  factory: function(el, width, height) {

    var view = null;

    return {

      renderValue: function(x) {

        var chart_spec = x.chart_spec;
        var embed_options = x.embed_options;

        vegaEmbed(el, chart_spec, opt = embed_options).then(function(result) {

          // By removing the style (width and height) of the
          // enclosing element, we let the "chart" decide the space it
          // will occupy.
          //
          el.removeAttribute("style");

          view = result.view;

        }).catch(console.error);

      },

      resize: function(width, height) {

      },

      getView: function() {
        return view;
      }

    };

  }
});


// Helper function to get view object via the htmlWidgets object
function getVegaView(selector){

  // Get the HTMLWidgets object
  var htmlWidgetsObj = HTMLWidgets.find(selector);

  console.log(htmlWidgetsObj);
  var view_obj = null;

  if (typeof(htmlWidgetsObj) !== "undefined"){
    view_obj = htmlWidgetsObj.getView();
  }

  return(view_obj);
}
