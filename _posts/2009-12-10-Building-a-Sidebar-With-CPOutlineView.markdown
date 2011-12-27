---
layout: post
title:  Building a Sidebar With CPOutlineView
categories:   [cappuccino, objective-j, CPOutlineView, CPTableView, atlas]
comments: true
---

This past week I was tasked with converting our `CPCollectionView`-backed sidebar to one using a `CPOutlineView`. The reason for doing this was threefold. First, a collection view could not support all of the project's requirements going forward (at least not easily). Most notably, we wanted to support quick and easy navigation to common items like projects, glossaries, and some community links. Second, an outline view is more Mac-like in that most desktop Mac applications with a sidebar have some sort of outline view. This would move us closer to a Mac desktop experience on the web and lower the learning curve for new users. Finally, we just could.

<!-- more -->

Since the release of [Atlas][], the team has been trying to use Cibs to build our interface as much as possible. But `CPTableView` and its brethren `CPOutlineView` are not yet supported in Atlas. So that means I had to do this in straight code. This isn't a big deal (most of our interface is still built programmatically at this time), but it just means I have to be extra careful with configuring the view.

[Atlas]: http://280atlas.com

## Setting Up the View

Setting up a `CPOutlineView` is not much different from any other `CPView` with two exceptions. The first is since `CPOutlineView` inherits from `CPTableView`, the column of data is actually a `CPTableColumn`. So I had to create a `CPTableColumn` and add it to the `CPOutlineView`, just like in a `CPTableView`. Simple enough. The second pitfall is again related to `CPOutlineView` inheriting from `CPTableView`. In order to correctly support scrolling, the outline view must be the documentView of a `CPScrollView`.

To get the scroll view and outline view to actually look like an outline view, some additional configuration must be done. First, make sure to autohide the scroll view's scrollers. Again, an outline view is just a very specific table view, so it has a header view and a corner view. But in a sidebar, those views don't really make since, so I just set them both to nil. You probably also want to set the background color of the scroll view to look like a sidebar. I used `e0ecfa`, but you may choose any color you wish.

## DataSource

If you are coding along, and you're like me and like to refresh your project to see the effects of your changes, you are probably disappointed at this point. All you should see is a nice blue rectangle. That is because we haven't told the outline view what to display yet. This is what the dataSource is for.

After setting the dataSource on the outline view to some object, we must implement the correct dataSource methods. There are four required methods:

    - (id)outlineView:child:ofItem:
    - (BOOL)outlineView:isItemExpandable:
    - (int)outlineView:numberOfChildrenOfItem:
    - (id)outlineView:objectValueForTableColumn:byItem:

Most of these methods are pretty self explanatory and I'm not going to go into much detail about them here (you can see [`NSOutlineView`'s documentation][nsoutlineview_docs] for more information) . I just want to note a few of the hangups that I had. First, these methods will be called with a `nil` item for the root object in the outline view. Second, if `- (id)outlineView:objectValueForTableColumn:byItem:` doesn't get called, you haven't added your table column to the outline view. Finally, if you mysteriously can't get anything beyond the first level of data to display ([like me][cpoutlineview_discussion]), you haven't actually told the outline view which table column is the outline view's table column. So you need to use `- (void)setOutlineTableColumn:`, passing in your table column.

[nsoutlineview_docs]: http://developer.apple.com/mac/library/documentation/cocoa/Reference/ApplicationKit/Protocols/NSOutlineViewDataSource_Protocol/Reference/Reference.html#//apple_ref/doc/uid/20000457
[cpoutlineview_discussion]: http://groups.google.com/group/objectivej/browse_thread/thread/64b3209423502341

That's basically it. The final piece is to actually back your dataSource with some object or objects. Since I only need two levels of data, I am using a `CPDictionary` where the keys are the top level and the values are arrays of data for the second level.

Here is the finished AppController:

{% gist 251323 %}

I included a bunch of debug statements in the dataSource methods to help understand what exactly is going on. [Check out a demo of this project](/code/OutlineView/).

## What's Next

My next step is to implement `CPOutlineView`'s delegate methods to be able to tell when the selection changes and which item is selected. Also, I want to have all my items expanded at startup like in Atlas, but just haven't gotten around to figuring that out yet.

I hope this post helps you if you are struggling to get a `CPOutlineView` in your interface or if you wanted to create a somewhat Mac-like sidebar. Leave a comment below if you have any questions, comments, or suggestions.