---
layout: post
categories:   [jekyll, github, blog]
comments: true
---

I started chandlerkent.com about four years ago as a way to learn how to create a website, including a backend powered by PHP and MySQL. At that time I created really basic blog software. This had many obvious problems, mainly it became impossible for me to maintain and add the features I needed. So the blog became stagnant. But from the experience I gained while building the site, I was able to create and deploy [iPhlickr][], which was also backed by PHP and MySQL. This site has basically been used for iPhlickr since then. About a year ago I deleted the blog altogether as the information was simply out-of-date and the site was an eyesore. I didn't want to associate myself with that work.

[iPhlickr]: http://www.iphlickr.com/

<!-- more -->

This year I decided I wanted to start blogging again. But I wanted to do it in such a way that would be more sustainable for me in the future. This meant it would need to be drop-dead simple for me to update, maintain, and add features. So I started looking into my options. I looked at [WordPress][], but it seemed like a lot of overhead. I've also heard that WordPress had some [security issues](http://daringfireball.net/2009/09/regarding_wordpress_and_security) in the past, as well as being a notorious [CPU hog](http://www.codinghorror.com/blog/archives/001105.html). I wanted a little more control over my content that WordPress also didn't offer. So I kept looking. Google's [Blogger][] seemed to offer more benefits. It was very simple to set-up, offered an API that allowed me to use other tools to blog instead of the crappy web interface, and allowed me to host it on my own domain.

[WordPress]: http://wordpress.org/
[Blogger]: http://www.blogger.com/

I decided to give Blogger a try, and last month I created the first post on the new blog. But I was immediately underwhelmed with what I could do. I wanted more control over my users' experience than what Blogger offered, and the templates provided were downright ugly. So I started to look for another solution. Enter [Jekyll][].

[Jekyll]: http://github.com/mojombo/jekyll

Jekyll gives me a lot of the benefits I was looking for. It is drop-dead simple to use. I can write using [Markdown][], [Textile][], or just HTML if I wanted to. I have complete control over the content, including layout and final HTML markup that will be served to the users. I can easily use source control for my writing like I do for code. And since it just generates static HTML pages, deployment is simple and flexible, and the final product is as fast as the server can deliver simple HTML files. Perfect.

[Markdown]: http://daringfireball.net/projects/markdown/
[Textile]: http://en.wikipedia.org/wiki/Textile_(markup_language)

I spent today setting up and configuring Jekyll. Following the [Jekyll-wiki][] was simple and the documentation is detailed. It took me less than an hour to get a simple blog setup. Next, I threw on some simple CSS (powered by [Sass][]--I never want to write straight CSS again!) for style and layout, added a few features like an [Archive][] page and a [RSS][] feed, and uploaded it to my GoDaddy hosting. It was really a joy.

[Jekyll-wiki]: http://wiki.github.com/mojombo/jekyll
[Sass]: http://sass-lang.com/
[Archive]: /archive.html
[RSS]: /rss.xml

After spending the day with Jekyll, I'm fairly confident I will be using it moving forward. I was surprised with its simplicity and flexibility which work together to allow for a lot of power and control. While I'm not sure when I will next get to work on the site, I do have many features in mind, such as:

* comments (possibly through [Disqus][])
* better archives
* tags
* related posts
* better front-page
* better layout
* easier deployment (eventually through a git push)
* ads?
* and more...

[Disqus]: http://disqus.com/

If you're interested, the source code for this site is up on [GitHub](http://www.github.com/chandlerkent/chandlerkent.com). I look forward to any feedback you have as well as suggestions in ways I can improve the experience of this site.