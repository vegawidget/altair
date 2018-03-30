HTMLWidgets.widget({

  name: "vegalite",

  type: "output",

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {
        //var spec = "https://raw.githubusercontent.com/vega/vega/master/docs/examples/bar-chart.vg.json";
        vegaEmbed(el, x).then(function(result) {
          // access view as result.view
        }).catch(console.error);
      },

      resize: function(width, height) {

      }

    };
  }
});
