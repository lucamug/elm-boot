// This script start the Elm app and 
// create interact with some of the
// ports.

// Normalizing Elm global variable
// because, depending on the location of
// the main script, it could be:
//
//   * Elm.Main.init()
//   * Elm.Counter.init()
//   * Elm.Examples.Counter.init()
//   * etc.
var ElmNormalized;
if (Elm[Object.keys(Elm)[0]].init) {
  ElmNormalized = Elm[Object.keys(Elm)[0]];
} else {
  ElmNormalized = Elm[Object.keys(Elm)[0]][Object.keys(Elm[Object.keys(Elm)[0]])[0]];
}

// Getting the Local Storage
var storageName = 'elm-todo-save';
var storedState = localStorage.getItem(storageName);
var startingState = storedState ? JSON.parse(storedState) : null;

// Initialize your Elm program
var app = ElmNormalized.init({
  node: document.getElementById('app'),
  flags: {
    
    env: env, // `env` is coming from  index.template.html
    locationHref: location.href,
    innerWidth: window.innerWidth,
    startingState: startingState,
    navigationModality: "NavigationByPath"
  },
});

if (app.ports) {
  if (app.ports.setStorage) {
    app.ports.setStorage.subscribe(function (state) {
      localStorage.setItem(storageName, JSON.stringify(state));
    });
  }

  if (app.ports.onUrlChange) {
    // Inform app of browser navigation (the BACK and FORWARD buttons)
    window.addEventListener('popstate', function () {
      app.ports.onUrlChange.send(location.href);
    });
  }

  if (app.ports.pushUrl) {
    // Change the URL upon request, inform app of the change.
    app.ports.pushUrl.subscribe(function (url) {
      history.pushState({}, '', url);
      app.ports.onUrlChange.send(location.href);
    });
  }

  if (app.ports.changeMeta) {
    // Updates HTML elements
    app.ports.changeMeta.subscribe((args) => {
      var element = document.querySelector(args.querySelector);
      if (element) {
        element[args.fieldName] = args.content;
      }
    });
  }
}
