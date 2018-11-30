// Please make sure you edit this file at data-raw/templates/vegawidget.js
//  - then render data-raw/infrastructure.Rmd

HTMLWidgets.widget({

  name: "vegawidget",

  type: "output",

  factory: function(el, width, height) {

    var vega_promise = null;

    return {

      renderValue: function(x) {

        // initialise promise
        vega_promise = vegaEmbed(el, x.chart_spec, opt = x.embed_options);

        // fulfill promise by rendering the visualisation
        vega_promise
          .then(function(result) {
            // By removing the style (width and height) of the
            // enclosing element, we let the "chart" decide the space it
            // will occupy.
            el.removeAttribute("style");
          })
          .catch(console.error);

      },

      resize: function(width, height) {

      },

      get vegaPromise() {
        return vega_promise;
      }

    };

  }
});


// Helper function to get view object via the htmlWidgets object
function getVegaPromise(selector){

  // get the htmlWidgetsObj
  var htmlWidgetsObj = HTMLWidgets.find(selector);

  // verify the element (to be determined)

  // return the promise
  return(htmlWidgetsObj.vegaPromise);
}
