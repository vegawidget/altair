HTMLWidgets.widget({

  name: "vegalite",

  type: "output",

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        var spec = JSON.parse(x);

        var spec_vega = "https://raw.githubusercontent.com/vega/vega/master/docs/examples/bar-chart.vg.json";
        var spec_vega_lite = {
          "$schema": "https://vega.github.io/schema/vega-lite/v2.0.json",
          "description": "A simple bar chart with embedded data.",
          "data": {
            "values": [
              {"a": "A","b": 28}, {"a": "B","b": 55}, {"a": "C","b": 43},
              {"a": "D","b": 91}, {"a": "E","b": 81}, {"a": "F","b": 53},
              {"a": "G","b": 19}, {"a": "H","b": 87}, {"a": "I","b": 52}
            ]
          },
          "mark": "bar",
          "encoding": {
            "x": {"field": "a", "type": "ordinal"},
            "y": {"field": "b", "type": "quantitative"}
          }
        };

        var x_manual = {
          "$schema": "https://vega.github.io/schema/vega-lite/v2.json",
          "config": {
            "view": {
              "height": 300,
              "width": 400
            }
          },
          "data": {
            "values": [
              {
                "PetalLength": 1.4,
                "PetalWidth": 0.2,
                "SepalLength": 5.1,
                "SepalWidth": 3.5,
                "Species": "setosa"
              },
              {
                "PetalLength": 1.4,
                "PetalWidth": 0.2,
                "SepalLength": 4.9,
                "SepalWidth": 3.0,
                "Species": "setosa"
              },
              {
                "PetalLength": 1.3,
                "PetalWidth": 0.2,
                "SepalLength": 4.7,
                "SepalWidth": 3.2,
                "Species": "setosa"
              }
            ]
          },
          "encoding": {
            "color": {
              "field": "Species",
              "type": "nominal"
            },
            "x": {
              "field": "PetalLength",
              "type": "quantitative"
            },
            "y": {
              "field": "PetalWidth",
              "type": "quantitative"
            }
          },
          "mark": "point"
        };

        vegaEmbed(el, spec).then(function(result) {
          // access view as result.view
        }).catch(console.error);
      },

      resize: function(width, height) {

      }

    };
  }
});
