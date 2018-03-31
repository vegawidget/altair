HTMLWidgets.widget({

  name: "vegalite",

  type: "output",

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        var spec = JSON.parse(x);

        vegaEmbed(el, spec).then(function(result) {
          // access view as result.view
        }).catch(console.error);
      },

      resize: function(width, height) {

      }

    };
  }
});
