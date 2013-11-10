---
layout: post
title: 'Announcing: compiln'
description: A Node.js asset compiler with choice.
author: Ian Lollar
tags: [code, nodejs, open-source, lib, compiln]
---

Like preprocessors?

Using Node.js?

Want a compiler with choice?

For your consideration: [compiln](https://github.com/redhotvengeance/compiln).

<!--more-->

## What is compiln?

compiln is a plugin-based asset compiler for Node.js. It'll handle compiling any preprocessed assets so you don't have to worry about it.

compiln is built to work as middleware for [Connect](http://www.senchalabs.org/connect/)/[express](http://expressjs.com/). When a request is made for an asset written in a meta-language (like [CoffeeScript](http://coffeescript.org/) or [Stylus](http://learnboost.github.com/stylus/)), compiln will ensure that the given asset is compiled and ready to be served.

## Why should I use it?

compiln uses a plugin-based architecture to allow YOU to choose your preprocessor stack, not me.

All compilation is done through plugins - compiln itself just provides the platform and utilities to allow plugins to get the job done.

With the release of compiln comes several initial plugins:

- [compiln-coffeescript](https://github.com/redhotvengeance/compiln-coffeescript) - compiln plugin to compile [CoffeeScript](https://github.com/jashkenas/coffee-script).
- [compiln-stylus](https://github.com/redhotvengeance/compiln-stylus) - compiln plugin to compile [Stylus](https://github.com/LearnBoost/stylus).
- [compiln-browserify](https://github.com/redhotvengeance/compiln-browserify) - compiln plugin to utilize [browserify](https://github.com/substack/node-browserify).

If your particular stack uses something not on this list, then you can easily [write a plugin](https://github.com/redhotvengeance/compiln#plugins) to get it integrated.

## How do I get started?

Let's say we're building an app on express, using [Jade](http://jade-lang.com/) for our markup templates, CoffeeScript for our scripts, and Stylus for our styles. Our directory structure would probably look something like this:

```
my-awesome-app
  - app
    - markup
    - scripts
    - styles
  - public
  - app.js
```

Our Jade templates would live in "markup", our CoffeeScript files in "scripts", and our Stylus files in "styles". "public" is the root of our application (where our assets should compile into), and "app.js" is our express app.

First, let's install compiln and the plugins we want to use:

```bash
npm install compiln
npm install compiln-coffeescript
npm install compiln-stylus
```

Typically, compiln will be used as middleware. To integrate it into our express app, we first need to require it:

```js
var compiln = require('compiln');
var compiln_coffeescript = require('compiln-coffeescript');
var compiln_stylus = require('compiln-stylus');
```

Next, we need to tell compiln what plugins to use. Think of compiln plugins as middleware for compiln. To inject the middleware, use the "use" method of compiln:

```js
compiln.use(compiln_coffeescript, "/app", "/public");
compiln.use(compiln_stylus, "/app", "/public");
```

The "use" method accepts four total parameters:

1. The plugin. (Required)
2. The path of the root source folder for that asset type. (Optional)
3. The path of the root destination folder for that asset type to be compiled to. (Optional)
4. An object of options for the plugin. (Optional)

(Notice that we only specified "/app" as the root source folders, not "/app/scripts" or "/app/styles". This is so our assets will render into a mirrored directory structure in "public", i.e.
"/app/scripts/main.coffee" will render into "/public/scripts/main.js".)

Next, we need to add the compiln middleware to our express app. Typically, you'll want to place the compiln middleware towards the bottom of the middleware chain, especially after the "static" middleware:

```js
app.set('views', __dirname + '/app/markup');
app.set('view engine', 'jade');
app.set('view options', {layout: false});
app.use(express.methodOverride());
app.use(express.bodyParser());
app.use(express.static(__dirname + '/public'));
app.use(compiln.compile({"buildOnStart":false, "buildOnRequest":true, "version":false}));
```

The "compile" method is the middleware to pass to express. It accepts an object as a parameter. That object can have three settings:

1. buildOnStart - Compile assets when the server starts (defaults to "true")
2. buildOnRequest - Compile an asset every time it is requested (defaults to "false")
3. version - Version/fingerprint asset filename when compiled (defaults to "true")

Now simply reference a file where you would expect it to be. For instance, let's say you made a Stylus file called "styles.styl" and put it in the appropriate source folder:

```
my-awesome-app
  - app
    - styles
      - styles.styl
```

To reference it in your Jade template, just add a normal link tag:

```jade
link(href="/styles/style.css", rel="stylesheet")
```

compiln will take care of the rest!

## Does compiln include asset versioning support?

You bet!

The "version" setting toggles whether the compiled files will be versioned (or "fingerprinted"). If "version" is set to true, the compiled filenames will have a unique identifier appended to them:

```
main.1234567890abcdefghijklmnopqrstuv.js
```

This identifier is an MD5 hash, and its generation is based off of file contents. If you were to recompile the exact same file, it would have the exact same version number. This allows you to set the client-side caching of your assets to a very-long/never expiry date. If the file contents change, the client will be requesting a different filename.

When assets are compiled, a "manifest.json" file is saved to the root directory. This JSON file maps the source files to their versioned filenames. compiln includes a helper method to retrieve the versioned filename of an asset. This is especially useful if you are using a templating language that allows for function calls, like Jade. To inject the versioned filename, simply use the "versionedFile" method:

```jade
link(href="#{versionedFile('/styles/style.css')}", rel="stylesheet")
```

This will render HTML something like:

```html
<link href="/styles/style.1234567890abcdefghijklmnopqrstuv.css" rel="stylesheet">
```

## When should I use "buildOnStart" and "buildOnRequest"?

"buildOnStart" and "buildOnRequest" are typically defined by the environment. In a development environment, turning on "buildOnRequest" is very useful. "buildOnRequest" will recompile an asset every time it is requested, so you can rapidly make source file changes and see the results on refresh.

"buildOnRequest" is **not** recommended for a production environment, since it will slow down delivery times and put an unnecessary load on the server. In production, use "buildOnStart" to compile all assets upon app initialization. Those assets will then be quickly served by your static middleware (or a reverse-proxy like nginx, if you prefer).

To utilize "buildOnStart", you must define the files to be compiled. This is done in an optional JSON file in the root, called "compiln.json":

```json
{
  "sources": [
    "/scripts/main.js"
    "/styles/main.styl"
  ]
}
```

You can also define plugins and settings in compiln.json:

```json
{
  "buildOnStart": true,
  "buildOnRequest": false,
  "version": true,
  "use": [
    {
      "plugin": "compiln-coffeescript",
      "source": "/app",
      "destination": "/public"
    },
    {
      "plugin": "compiln-stylus",
      "source": "/app",
      "destination": "/public"
    }
  ],
  "sources": [
    "/scripts/main.js"
    "/styles/main.styl"
  ]
}
```

Defining compiln settings this way eliminates the need to specify plugins and settings when initializing the compiln middleware. If you do still specify plugins and settings in the middleware, the middleware settings will override the compiln.json settings. This allows for you to define different middleware settings depending on your app/server environment.

## What if I want to precompile my assets? Can I do that?

Yep.

compiln includes a CLI to allow you to compile your assets outside of your app altogether. Doing so eliminates the need to use compiln as middleware. Keep in mind that if you are versioning your files and want to use the "versionedFile" helper method, you'll still need to utilize the compiln middleware. Otherwise, you'll have to hardcode the versioned filenames.

To use the CLI, install compiln globally:

```bash
npm install -g compiln
```

A compiln.json is required in order to compile via the CLI. Once you've defined your settings, plugins, and source files in compiln.json, simply execute the "build" command:

```bash
compiln build
```

By default, compiln will version the files. If you'd like to not utilize versioning, pass the "--bare" flag:

```bash
compiln -b build
```

## So how do I write a plugin?

compiln plugins require three methods to be defined. These methods should be made available by adding them to "module.exports":

* "module.exports.detect" - Should return an array of extensions. These are the extensions that the source files possess. The extensions **should not** include the dot:

```js
module.exports.detect = function()
{
  return ["coffee"];
};
```

* "module.exports.ext" - Should return a string of the destination extension (the extension the source file will compile into). This **should not** include the dot:

```js
module.exports.ext = function()
{
  return "js";
};
```

* "module.exports.compile" - Accepts two parameters: "file" and "options". "file" is the source file path. "options" will contain any options passed when the plugin is passed to compiln. This method should load the source file (via "fs.readFileSync") and return the compiled data:

```js
module.exports.compile = function(file, options)
{
  return coffeescript.compile(fs.readFileSync(file, "utf8"));
};
```

That's it - about as simple as it can get.

If you choose to write a new compiln plugin, I suggest looking at some existing plugins to get started. Try to follow the established plugin naming convention as well: "compiln" + "-" + the name of the utility or preprocessor.

The compiln [wiki](https://github.com/redhotvengeance/compiln/wiki) keeps a list of available plugins. If you contribute a plugin, add it to the list so others can find it too.

## I'm still not convinced. Can I look at the source code?

Sure. Knock yourself out:

[https://github.com/redhotvengeance/compiln](https://github.com/redhotvengeance/compiln)

Enjoy.

**- rhv**
