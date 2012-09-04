---
layout: post
title: Out of the Ashes...
author: Ian Lollar
tags: [blog, code]
---

**POOF!**

...and the blog becometh.

As with all blogs born (or reborn, or third-born...multi-born?), this is the obligatory, *"Oh hey, check out my blog being launched!"* first post.

The excitement...you can almost taste it. It's palpably palpable.

But how about something actually worth *reading*? Personally, I enjoy learning a bit about the technology stack behind a site. The first post seems as good a post as any to discuss some of the gears and cogs making this blog turn.

But first, some obligatories:
* Yes, this is my new blog.
* No, I won't be migrating any of my previous blog's content.
* Any libs or projects you may be looking for can be found on [my GitHub page](https://github.com/redhotvengeance).

There. Now, let's move on. How this site works...

<!--more-->

## Jekyll

This site is built on [Jekyll](https://github.com/mojombo/jekyll), which is a static site generator. That means that this blog has no CMS, no DB, and no back-end to speak of. Why is that awesome? Well, because all of my content winds up being static, archivable/versionable files that I can deploy pretty much anywhere. Plus, I'm only really serving HTML/CSS/JS, which means the site is lean and fast.

Jekyll is easy to set up. It requires a handful of specific files and a certain directory structure, but once all of that is in place, a simple command line execution will build your static site files, which are then ready for you to deploy.

Jekyll allows you to write your posts/pages in Markdown, which I dig. It also uses Liquid for templates, which makes it easy to inject site and/or post data into your markup.

## Plugins

What's nice about Jekyll is that it is fairly easy to customize.

I'm a fan of preprocessors, like CoffeeScript and Sass. So, naturally, it'd be nice to include compiling those along with building my site. Fairly simple: add a plugin for each in the "_plugins" folder. For example, the CoffeeScript plugin looks like this:

{% codeblock coffeescript_converter.rb lang:ruby %}
module Jekyll
  require 'coffee-script'

  class CoffeeScriptConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /coffee/i
    end

    def output_ext(ext)
      ".js"
    end

    def convert(content)
      begin
        CoffeeScript.compile content
      rescue StandardError => e
        puts e.message
      end
    end
  end
end
{% endcodeblock %}

Now when Jekyll builds, any file with a ".coffee" extension will be ran through this converter, which will compile it into JavaScript.

Another handy use for plugins are Liquid extensions. For instance, I wanted to customize how post dates would appear, so I wrote a small Liquid extension:

{% codeblock data_to_day_month_year.rb lang:ruby %}
module Jekyll
  module DateToDayMonthYearPipeFilter
    def date_to_day_month_year(input)
      input.strftime("%A, %B %d, %Y")
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateToDayMonthYearPipeFilter)
{% endcodeblock %}

Using the extension is simple:

{% codeblock lang:html %}
<time datetime='{{ "{{post.date" }}}}'>{{ "{{post.date | date_to_day_month_year" }}}}</time>
{% endcodeblock %}

The result being:

{% codeblock lang:html %}
<time datetime='2012-09-03 00:00:00 -0700' class='post-date'>Monday, September 03, 2012</time>
{% endcodeblock %}

There are lots of handy open-sourced Jekyll extensions out there for you to use. [Octopress](http://octopress.org/) has made some very nice ones, several of which I'm using for this site.

## Deploying

Typically, Jekyll blogs are precompiled and then pushed up to the server. This can be done via FTP, rsync, or various other methods. I prefer to use Git to deploy. It is clean and simple, and readily done from the command line.

This presents a challenge, however. I prefer to keep compiled files out of my code repositories, so precompiling the Jekyll site is no longer an option, since the compiled site would have to be added to the repository in order for Git to push it. So the Jekyll site needs to be built server-side.

Git hooks to the rescue! Initialize a bare Git repo on your server, and add a post-receive hook:

{% codeblock post-receive lang:bash %}
#!/bin/sh
export GIT_WORK_TREE=<path to Jekyll environment>

git checkout -f
cd $GIT_WORK_TREE
bundle install
jekyll <path to public site folder>
{% endcodeblock %}

(Depending on your server/host, you may need to add extra exports that point at the appropriate gem/lib/bin folders.)

When new code is pushed to the repo, the post-recieve hook will copy the latest version of its contents to the GIT_WORK_TREE path. This is where your Jekyll environment is set up (obviously requires ruby and bundler support). The hook will then install any necessary gems with bundler, and execute the Jekyll build, placing the compiled site files in the public-facing web directory, ready for the world to see. Sweet, sweet automation.

## The Beginning of Things

And so, the new blog is born.

If you'd like to dig more into what makes this blog work, it is available on [GitHub](https://github.com/redhotvengeance/redhotvengeance) (everything but the "_posts" and "assets" folders are open-sourced and free for you to use.)

More words and word-shaped creations to come...

**- rhv**
