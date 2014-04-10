---
layout: post
title: How I Set Up
description: Getting Homebrew, Git, rbenv, Ruby, and Node.js set up fast.
author: Ian Lollar
tags: [cli, ruby, rbenv, osx, nodejs, git]
---

Every once in awhile, I find myself on a new machine. Perhaps via a job, or perhaps via my credit card. Last week, I found myself breaking the seal on a new Macbook Pro Retina (which, by the way, is an absolutely *kick-ass* piece of drool-worthy computer-goodness).

So it's time to set up a new box. Where to start?

If you're anything like me, you like consistency. (Well, if you're like me, you *need* consistency because of some deep, OCD-level craziness.) That means I have want a simple and straightforward way to cleanly set up my working environment.

What I work with changes all of the time, but right now, it includes Git, Ruby, and Node.js. So let's see what it takes to get that environment up and running.

<!--more-->

## Xcode and Command Line Tools

This article is assuming you're on Mac OS X (version 10.8.2, to be specific). A precursor to getting pretty much **anything** working on OS X is to install Xcode. Well, Xcode and its CLI friends.

First, Xcode. Pretty easy - bust open the Mac App Store, search "Xcode", and hit "Install". What's that? You're lazy like me? [Here's a link.](https://itunes.apple.com/us/app/xcode/id497799835)

![Xcode Install](https://s3.amazonaws.com/redhotvengeance/how-i-set-up/howisetup_xcode.jpg)

So...Xcode is kinda big. And installs slow. I suggest getting a chai. I'll wait...

...back? Installed? Excellent! Moving on...

Xcode is actually a means to an end - what we really want are Xcode's Command Line Tools. Why? Because they include compilers that our future installers will need.

Fire up Xcode, and open its Preferences. Head to the "Downloads" tab - see "Command Line Tools?" Install that sucka.

![Xcode Install CLI](https://s3.amazonaws.com/redhotvengeance/how-i-set-up/howisetup_xcode_cli.jpg)

All done? On to the real shit.

## Homebrew

Like I said - I like package managers. If languages get them, why not your system? Enter [Homebrew](http://mxcl.github.com/homebrew/). Homebrew is the self-proclaimed "missing package manager for OS X". In a nutshell, it makes it easy to install all your tools, libs, and languages.

Homebrew itself also happens to be rather easy to install. Fire up the Terminal, and execute:

```bash
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
```

Now sit back and watch all of those glorious lines of automated code fly by.

Once Homebrew finishes installing, you'll want to check that your system is configured properly to use it:

```bash
brew doctor
```

If all is well, you should see: "Your system is raring to brew."

You may have a couple of issues to solve. One common fix is to alter your PATH to have '/usr/local/bin/' occur before '/usr/bin'. Add the following line to your ".bash_profile" (if one doesn't exist yet, create it in your home directory):

```bash
export PATH="/usr/local/bin:$PATH"
```

## Git

Now that you're raring to brew, let's start with Git. And not just the Git core, but also some handy extras:

```bash
brew install git bash-completion
```

Watch as Homebrew handles all of that unpleasant *installing* and *building* for you. Ah, sweet automation.

Once Git is installed, we need to add some lines to our .bash_profile to enable that bash-completion:

```bash
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
```

Now you can tab to complete Git commands - handy!

## Ruby

Time to get our Ruby on.

If you've been paying attention, you'll notice that we've already used Ruby once. Remember when we installed Homebrew? The command that started with "ruby"? So, wait...is Ruby already installed?

Yes...and no. OS X does come with Ruby installed, but it is quite an old version - 1.8.7, to be exact. Meanwhile, Ruby is at 1.9.3, and a lot has changed in all those sub-point versions.

Here's the thing, though. Ruby comes installed in OS X because OS X expects it to be there, so we don't really want to touch the system Ruby. How do we upgrade and manage multiple versions of Ruby at the same time?

You guessed it - another package manager. There are actually two popular candidates for this job - [RVM](https://rvm.io/) and [rbenv](https://github.com/sstephenson/rbenv). I'm not going to break down the differences between the two in this article - a simple [Google](http://bit.ly/TrImyr) will bring you plenty of info. For the purposes of this walkthrough, I'm going to assume you want to use rbenv. Why? Because *I* use rbenv, and that's reason enough.

First we need to install rbenv - back to Homebrew! (It *is* handy, isn't it?)

```bash
brew install rbenv
```

Once that is done, bust open that .bash_profile and add the following to it:

```bash
eval "$(rbenv init -)"
```

Now, rbenv expects you to manually build your own versions of Ruby, which, if you ask me, is a pain in the ass. So let's grab a rbenv plugin to help us out with that:

```bash
brew install ruby-build
```

Next, let's grab the latest version of Ruby:

```bash
rbenv install 1.9.3-p194 --verbose
```

(I like to tag on the --verbose flag so I can see the download and install progress - it helps me know nothing has gone wrong.)

Once our fresh and shiny version of Ruby is built, we need to tell rbenv that we want to use it:

```bash
rbenv global 1.9.3-p194
```

Restart Terminal and check your Ruby version:

```bash
ruby -v
```

Is it 1.9.3p194? Good! Moving on…

## Gems

Now would be a good time to install your favorite gems. Like what, you ask? How about rails?

```bash
gem install rails
```

Something to be aware of is the way rbenv operates is by building shims for the versions of Ruby and their gems. So when you install a new gem, you need to tell rbenv to rebuild those shims:

```bash
rbenv rehash
```

Now you should be ready to ride the rails.

(If rails complains about needing be installed with sudo, try restarting your Terminal. It is better to **not** install gems with sudo.)

## Node.js

So how about some Node.js? This is an easy one.

Head to http://nodejs.org/ and click "Install". Follow the installer instructions.

![Install Node.js](https://s3.amazonaws.com/redhotvengeance/how-i-set-up/howisetup_node.jpg)

Boom. Noded. Proceed to install some node packages, like CoffeeScript:

```bash
npm install -g coffee-script
```

## Wrapping Up

So there you go - now you've got Xcode, Homebrew, Git, rbenv, Ruby, and Node.js ready to roll on your system.

Fast, simple, clean - now you can get to work (sorry about that.)

**- rhv**
