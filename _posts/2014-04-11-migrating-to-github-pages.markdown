---
layout: post
title: 'Migrating to GitHub Pages'
description: Why did this blog move to GitHub Pages? I'll tell you why!
author: Ian Lollar
tags: [blog, github, pages, host, open-source, collaboration, workflow]
---

I just finished migrating this blog to its new home on [GitHub Pages](https://pages.github.com/).

Why the move? Let me tell you...

<!--more-->

## What is GitHub Pages?

GitHub Pages is [GitHub](https://github.com/)'s version of site hosting. It only serves static sites, but it is uniquely tied to your GitHub repos, meaning the hosting/deployment is directly connected with your GitHub projects.

Oh, and it's free.

## Host after host (after host)

This is a [Jekyll-powered](http://jekyllrb.com/) blog, so the hosting needs are quite simple. And yet, this is actually the second host migration I've made since launching. I initially launched on [WebFaction](https://www.webfaction.com/) - I had been using them for years, and it was the logical choice to plop my new blog down there.

After about a year and a half, I realized that I was using WebFaction less and I was hosting most of my apps and projects on Heroku (among other solutions). Since WebFaction was becoming superfluous, I started fully migrating off of it. Thus, this blog set up camp as a Heroku app, and lived there happily for the better part of half a year.

So why GitHub Pages now?

## Just get over it

I had initially considered publishing to GitHub Pages when I was first developing this site. But I ultimately decided it wasn't right for me because of two reasons: [CoffeeScript](http://coffeescript.org/) and [Sass](http://sass-lang.com/).

See, GitHub Pages is very strict about using custom Jekyll plugins, and I was using quite a few, most notably CoffeeScript and Sass compilers. Despite being a very simple site, I was adamant about using CoffeeScript and Sass, and GitHub Pages was thrown out of the window as a result.

I was an idiot.

Don't get me wrong, opinions and preferences are great, wonderful, and necessary things. But sometimes, you just need to *get over it*. I was letting misplaced convictions remove a better and **free** option, purely because was being whiny and didn't like raw CSS. Get over it, Ian.

So [I](https://github.com/redhotvengeance/redhotvengeance.com/commit/51d4a30847079ec3243ed5c7484593032e19272f) [did](https://github.com/redhotvengeance/redhotvengeance.com/commit/bb297ea6ece0df2462ecf7fbf0736ebf21667759).

## The flows

In every hosted solution for this blog, I've deployed via a Git push (even on WebFaction, which I [set up manually](/2012/09/03/out-of-the-ashes/)). Deploying via Git is awesome, but what if you just want to do a quick change? Or you're on a mobile device and you can't set up a local Git repo?

That's where GitHub Pages has a (somewhat) secret weapon. Since your site is a hosted version of your GitHub repo, you can use the [GitHub Flow in the browser](https://github.com/blog/1557-github-flow-in-the-browser) to make changes completely in a web browser. Now I can fix a typo from my phone, or even draft an entire post using GitHub's fancy markdown editor.

## Open for fixes

I like open-source collaboration. I've said it. A lot.

And while this blog source has been [open-source](https://github.com/redhotvengeance/redhotvengeance.com) from the beginning, [Phil Haack migrating his blog to GitHub Pages](http://haacked.com/archive/2013/12/02/dr-jekyll-and-mr-haack/) made me realize I wasn't playing up the "collaboration" angle. As Phil said:

> Let me know if you find any issues. Or better yet, click that edit button and send me a pull request!

This blog is not only stored at https://github.com/redhotvengeance/redhotvengeance.com, but also (ostensibly) served from there. So if you find a bug or (better yet!) typo, feel free to open a pull request to fix it up! You've got the nice GitHub browser flow to makes things super easy for you, and as thanks I'll send you some sort of animal-related gif (disclaimer: may not be animal-related).

**- rhv**
