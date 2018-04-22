HTMLWidgets.widget({

  name: "vegalite",

  type: "output",

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        var chart_spec = JSON.parse(x.chart_spec);
        var tooltip_options = x.tooltip_options;
        var embed_options = x.embed_options;

        vegaEmbed(el, chart_spec, opt = embed_options).then(function(result) {
          // access view as result.view
          vegaTooltip.vegaLite(result.view, chart_spec, tooltip_options);

          // idea: post-facto setting of the width and height style of the
          // enclosing element
          //
          // el.setAttribute("foo", "bar");
          // console.log(el);

        }).catch(console.error);
      },

      resize: function(width, height) {

      }

    };
  }
});
