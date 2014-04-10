---
layout: post
title: 'Announcing: Deep Thought'
description: A deployer that does the thinking for you.
author: Ian Lollar
tags: [code, ruby, open-source, lib, deep-thought, deploy, deployer, deployment]
---

Deploy smarter, not harder.

## What is Deep Thought?

Deep Thought is a Sinatra-based app with a big brain. And by "big brain," I mean quite big - [some](http://en.wikipedia.org/wiki/Marvin_the_Paranoid_Android) may describe it as a "brain the size of a planet," though Deep Thought prefers not dabble in such hyperboles. What does Deep Thought do with this huge brain? It manages your deploys.

Deployment workflows are often overly complicated, multi-stepped labyrinths of servers, keys, and scripts, held together with a few scraps of documentation and a bit of luck. Shipping is not unlike closing your eyes and slamming the [Infinite Improbability Drive](http://en.wikipedia.org/wiki/Technology_in_The_Hitchhiker's_Guide_to_the_Galaxy#Infinite_Improbability_Drive) button, though perhaps with less [falling whales](https://www.goodreads.com/quotes/198068-another-thing-that-got-forgotten-was-the-fact-that-against) (unless you're [Twitter](http://www.whatisfailwhale.info/)).

Deep Thought works to open up the deploy process and make it simple and straight-forward. Deep Thought allows you to deploy from anywhere to anywhere, and, in turn, encourages devs to be excited about shipping, rather than reluctant.

<!--more-->

Deep Thought was inspired by GitHub's own Hubot+Heaven workflow. Check out [Zach Holman's talk](http://zachholman.com/talk/unsucking-your-teams-development-environment/) to see the original inspiration.

## Why should I use it?

- Deep Thought is diverse

	- A built-in web interface allows for easy GUI-based deployments, and its responsive nature means means it is mobile-ready for deploying on the go.

	- Deep Thought's API makes it extensible and friendly with other systems and workflows (and Deep Thought *loves* talking to Hubot).

- Deep Thought is secure

	- All web access requires a secure account, all API access requires a token, all passwords are encrypted, and all communications must use HTTPS/SSL.

- Deep Thought is cautious

	- Deep Thought handles your deploys carefully - it does not allow simultaneous deployments, and (if enabled) will ensure that your build is green (via your CI server) before deploying it.

- Deep Thought is adaptable

	- Deep Thought is built on a plugin-based architecture, and is meant to be extended - that means you can easily write your own deployers and CI integrations for Deep Thought to use.

## How do I get started?

The easiest way to get started is to clone [this Gist](https://gist.github.com/redhotvengeance/5746731):

```bash
git clone git://gist.github.com/5746731 deep_thought
```

Deep Thought is largely designed to be deployed to Heroku, though it will work just as well on a custom server or VM. At the very least, Deep Thought will need an environment with Ruby and Git installed and access to a PostgreSQL database.

For details on how to get up and running, head over to [Deep Thought's repo](https://github.com/redhotvengeance/deep_thought/) and have a read-through the [README](https://github.com/redhotvengeance/deep_thought/blob/master/README.md).

## How does Deep Thought work?

Deep Thought wraps around your chosen deploy method/framework, and abstracts the act of deployment into a simple and easy-to-access process.

Deep Thought distills the act of deploying into several key parts:

- **action(s)** - Actions are the tasks being executed. By default, Deep Thought calls "deploy", but specifying an action like "config" could allow you to deploy the project config instead of the codebase.
- **branch** - The Git branch being deployed. Defaults to "master".
- **environment** - The environment being deployed to. Defaults to "development".
- **box** - If your environment(s) have several different servers, you can specify the server you want to deploy to.
- **variable(s)** - These are optional key/value pairs that can be used to supply any additional information or parameters your deployment may need.

These elements combine to create a deployment DSL for Deep Thought, which is something like this:

> **deploy &lt;project&gt;[/&lt;action&gt;...] &lt;branch&gt; to &lt;environment&gt;/&lt;box&gt; [&lt;key&gt;=&lt;value&gt;...]**

There are two main ways of interacting with Deep Thought - via the web interface and via the API.

### Web Interface:

Deep Thought's web interface is a front-end that lets you manage and deploy through the browser. It is responsively designed and mobile-ready. To access it, simply hit the root url or IP your Deep Thought is hosted at.

![Deep Thought login](https://s3.amazonaws.com/redhotvengeance/announcing-deep-thought/announcingdeepthought_login.jpg)

You'll have to authenticate yourself via email/password before having access to any part of Deep Thought. Once logged in, you will be able to setup new projects, add users, manage your account, and, of course, deploy projects.

![Deep Thought deploy project](https://s3.amazonaws.com/redhotvengeance/announcing-deep-thought/announcingdeepthought_deploy.jpg)

In addition to kicking off deployments, you can also see a project's deployment history to check on previous deployments and see if they were successful or not.

### API:

Deep Thought's API is useful for attaching and/or building interfaces to interact with Deep Thought. One of the more common (and awesome) uses for the API is to enable Hubot to talk to Deep Thought.

Once Hubot can communicate with Deep Thought, you can conveniently initiate deploys straight from your chat room, like so:

> **@hubot deploy my-project master to production**

Even better, Deep Thought includes support to, upon deployment completion, send a notification to a specified URL, so Hubot can also let you know if your deploy was successful or not.

Hubot integration is ready to go - just use this [Deep Thought Hubot script](https://github.com/redhotvengeance/hubot-scripts/blob/add-deep-thought/src/scripts/deep-thought.coffee).

## What deployers are available? What CI service integrations?

Deep Thought has a shell script deployer already built in - the shell deployer will execute a specified shell script in the project and pass it the actions, branch, environment, box, and variables via arguments.

All other deployers come as plugins. As of launch, there are three other deployers available: [Capistrano (~2.x.x)](https://github.com/redhotvengeance/deep_thought-capistrano_2), [Capistrano (~3.x.x)](https://github.com/redhotvengeance/deep_thought-capistrano_3), and [Heroku](https://github.com/redhotvengeance/deep_thought-heroku). A [list of available deployers](https://github.com/redhotvengeance/deep_thought/wiki/Deployers) is kept in the [Deep Thought wiki](https://github.com/redhotvengeance/deep_thought/wiki).

As far as CI service integrations, Deep Thought comes with Janky integration built in. To enable it, several env vars must be set:

```bash
CI_SERVICE=janky
CI_SERVICE_ENDPOINT=http://your.janky.url
CI_SERVICE_USERNAME=janky_username
CI_SERVICE_PASSWORD=janky_password
```

As of launch, Janky is the only CI service integration, but more can easily be written. A [list of available CI service integrations](https://github.com/redhotvengeance/deep_thought/wiki/CI-Services) is kept in the [Deep Thought wiki](https://github.com/redhotvengeance/deep_thought/wiki).

## But I don't deploy with X or test with Y!

No problem - write some plugins!

You can read more about writing your own deployers and ci service integrations in the [Deep Thought README]().

If you do write a new badass deployer or cool CI service integration, be sure to add it to the [wiki pages](https://github.com/redhotvengeance/deep_thought/wiki) so the Deep Thought community can benefit from your awesome work!

## I'm still not convinced. Can I look at the source code?

Sure. Knock yourself out:

[https://github.com/redhotvengeance/deep_thought](https://github.com/redhotvengeance/deep_thought)

Find an issue? Report it! Have a fix? Open a pull request!

Enjoy.

**- rhv**
