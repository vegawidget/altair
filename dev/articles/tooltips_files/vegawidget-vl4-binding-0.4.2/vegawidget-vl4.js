// Please make sure you edit this file at data-raw/templates/vegawidget.js
//  - then render data-raw/infrastructure.Rmd


// HTMLWidget factory
HTMLWidgets.widget({

  name: "vegawidget-vl4",

  type: "output",

  factory: function(el, width, height) {

    // private stuff
    var view_promise = null;

    var processData = function(data) {

      // if this is a string, construct a function
      if (typeof(data) === "string") {
        // Q: what are the risks of this?
        return(new Function("data_remove", data));
      }

      // if data is boolean return truthy/falsy
      if (typeof(data) === "boolean") {
        if (data === true) {
          return (vega.truthy);
        } else {
          return (vega.falsy);
        }
      }

      // if data is column-based, convert to row-based
      if (typeof(data) === "object" && !Array.isArray(data)) {
        return(HTMLWidgets.dataframeToD3(data));
      }

      // assuming this is already row-based, no-op: return data
      return(data);
    };

    return {

      // x, object to instantitate htmlwidget
      renderValue: function(x) {

        // initialise promise
        view_promise =
          vegaEmbed(el, x.chart_spec, opt = x.embed_options)
            .then(function(result) {
              return result.view;
            });

        // fulfill promise by rendering the visualisation
        view_promise
          .then(function(view) {
            // By specifying the style (width and height) of the
            // enclosing element, we let the "chart" decide the space it
            // will occupy.
            el.setAttribute("style", "width:auto;height:auto;");
            // console.log(el);
          })
          .catch(console.error);
      },

      // need to confront this at some point
      resize: function(width, height) {},

      // public function to get view_promise
      get viewPromise() {
        return view_promise;
      },

      // generic function to call functions, a bit like R's do.call()
      callView: function(fn, params, run) {

        // sets default for run to true if not already false
        if (run !== false) {
          run = run || true;
        }

        // invoke fn
        this.viewPromise.then(function(view) {
          var method = view[fn];
          method.apply(view, params);
          if (run) {
            view.run();
          }
        });
      },

      // Data function
      changeData: function(name, data_insert, data_remove, run) {

        // set default, if not already FALSE
        if (data_remove !== false) {
          data_remove = data_remove || vega.truthy;
        }

        // get data into the "right" form
        data_insert = processData(data_insert);
        data_remove = processData(data_remove);

        //console.log(data_insert);
        //console.log(data_remove);

        // build the changeset
        var changeset = vega.changeset()
                            .insert(data_insert)
                            .remove(data_remove);

        // invoke view.change
        this.callView("change", [name, changeset], run);
      }
    };
  }
});

// Top-level Vegawidget object
var Vegawidget = {

  // Find, return a promise to a Vegawidget
  //
  // @param selector, string css-selector
  //
  // @return a promise to a Vegawidget
  //
  findWidgetPromise: function(selector) {

    return new Promise(function(resolve, reject) {

      // find and test the element in the document
      var vwEl = document.querySelector(selector);

      // element does not exist
      if (vwEl === null) {
        reject(
          console.log(
            "No document element found using selector " +
            "'" + selector + "'" +
            ".")
        );
      }

      // element is not a vegawidget
      if (!vwEl.classList.contains("vegawidget-vl4")) {
        reject(
          console.log(
            "Document element found using selector " +
            "'" + selector + "'" +
            " does not have class 'vegawidget-vl4'."
          )
        );
      }

      // get the HTMLWidget object
      var vwObj = HTMLWidgets.find(selector);

      // if it is "defined", resolve it; if not, wait and try again
     	if (vwObj !== undefined) {
    		resolve(vwObj);
    	} else {
    		setTimeout(function() {
    		  Vegawidget.findWidgetPromise(selector).then(resolve);
    		}, 50);
    	}

    });
  },

  // returns a promise to the Vega view, rather than to the Vegawidget object
  findViewPromise: function(selector) {
    return this.findWidgetPromise(selector).then(function(vwObj) {
      return vwObj.viewPromise;
    });
  }

};

// Shiny message-handlers
if (HTMLWidgets.shinyMode) {

  Shiny.addCustomMessageHandler('callView', function(msg) {

    // `msg` properties:
    // expected: `outputId`, `fn`
    // optional: `params`, `run`

    // get, then operate on the Vegawidget object
    Vegawidget.findWidgetPromise("#" + msg.outputId).then(function(vwObj) {
      vwObj.callView(msg.fn, msg.params, msg.run);
    });

  });

  Shiny.addCustomMessageHandler('changeData', function(msg) {

    // `msg` properties:
    // expected: `outputId`, `data_insert`
    // optional: `data_remove`, `run`

    // get, then operate on the Vegawidget object
    Vegawidget.findWidgetPromise("#" + msg.outputId).then(function(vwObj) {
      vwObj.changeData(msg.name, msg.data_insert, msg.data_remove, msg.run);
    });

  });

  Shiny.addCustomMessageHandler('addSignalListener', function(msg) {

    // note - there seems to be a *lot* of similarity among the
    // listener message-functions. When we move to ES6, I think it
    // could be useful to try to see if we can do this in *one*
    // message-function.

    // `msg` properties
    //   `outputId` - name of the shiny outputId for the vegawidget
    //   `handlerBody` - the body of a function (name, value) that
    //      returns the value you want to bound to `inputId`
    //   `name` - name of the signal to bind

    // convert the handlerBody to a function
    var handler = new Function("name", "value", msg.handlerBody);

    // get, then operate on the view
    Vegawidget.findViewPromise("#" + msg.outputId).then(function(view) {
      view.addSignalListener(msg.name, handler);
    });

  });


  Shiny.addCustomMessageHandler('addDataListener', function(msg) {

    // note - there seems to be a *lot* of similarity among the
    // listener message-functions. When we move to ES6, I think it
    // could be useful to try to see if we can do this in *one*
    // message-function.

    // `msg` properties
    //   `outputId` - name of the shiny outputId for the vegawidget
    //   `handlerBody` - the body of a function (name, value) that
    //      returns the value you want to bound to `inputId`
    //   `name` - name of the signal to bind

    // convert the handlerBody to a function
    var handler = new Function("name", "value", msg.handlerBody);

    // get, then operate on the view
    Vegawidget.findViewPromise("#" + msg.outputId).then(function(view) {
      view.addDataListener(msg.name, handler);
    });

  });

  Shiny.addCustomMessageHandler('addEventListener', function(msg) {

    // note - there seems to be a *lot* of similarity among the
    // listener message-functions. When we move to ES6, I think it
    // could be useful to try to see if we can do this in *one*
    // message-function.

    // `msg` properties
    //   `outputId` - name of the shiny outputId for the vegawidget
    //   `handlerBody` - the body of a function (name, value) that
    //      returns the value you want to bound to `inputId`
    //   `event` - name of the type of event to bind

    // convert the handlerBody to a function
    var handler = new Function("event", "item", msg.handlerBody);

    // get, then operate on the view
    Vegawidget.findViewPromise("#" + msg.outputId).then(function(view) {
      view.addEventListener(msg.event, handler);
    });

  });

  Shiny.addCustomMessageHandler('run', function(msg) {
    // get, then run the view
    Vegawidget.findViewPromise("#" + msg.outputId).then(function(view) {
      view.run();
    });
  });
}
