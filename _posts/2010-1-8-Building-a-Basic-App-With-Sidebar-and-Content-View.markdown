---
layout: post
title: Building a Basic App With a Sidebar and Content View
tags: [cappuccino, objective-j, CPOutlineView, atlas, sidebar, CPNotification, CPNotificationCenter]
---

In the [last post][last post] I showed you how to build a basic sidebar using `CPOutlineView` and all its data source methods. In this post I am going to continue that idea and show you how to update a content view based on the user's selection in the sidebar. You can see a [demo][demo] of the final application to get the idea. All the source code created for this post can be found [here][SidebarChangingContentView].

<!-- more -->

***Quick Note:** I am using [Atlas][] in this post to layout my basic view and make some connections. If you are not part of the Atlas beta, or do not yet have Atlas, the following ideas should still extend to your application.*

[last post]: /2009/12/10/Building-a-Sidebar-With-CPOutlineView.html
[demo]: /code/SidebarChangingContentView/
[SidebarChangingContentView]: http://github.com/chandlerkent/sample-projects/tree/master/SidebarChangingContentView/
[Atlas]: http://www.280atlas.com/

## Setup the Interface

In Atlas, create a new Cib-based project. Then open Resources > MainMenu.cib to begin putting together the view. We are going to create a basic application with a sidebar on the left and a content view on the right. I like to use a Vertical Split View for this. Go ahead and drag a Vertical Split View into your window. Using the Size tab, make the Split View take up the entire window and resize with the window (selecting all the resizing arrows should do the trick). Also, in the "Split View Size" section, select the resizing arrow for the right view. The right view will be our content view, and this arrow tells the right view to resize horizontally as the window resizes. This is the behavior we want.

Next, we want to create our outline view in the left view of the Split View. Unfortunately, `CPOutlineView` isn't supported by Atlas yet, so we need to do this programmatically. However, we can save ourselves some work by creating the `CPScrollView` in Atlas that the Outline View will need. Drag out a Scroll View and put it in the left view of the Split View. Again using the Size tab, make the Scroll View take up the entire left view and resize as it resizes (select all the resizing arrows). Also, in the Attributes tab with the Scroll View selected, uncheck "Shows Horizontal Scroller" and check "Autohides Scrollers". These do exactly what they sound like they do.

Click "Test" in the toolbar to test your interface. Make sure to resize both the window and the split view to see if your resizing flags are set up correctly.

## Setup the Sidebar

I showed you how to build a sidebar in my [previos post][last post]. I'm not going to repeat that here. However, I want to highlight some different techniques that I am using.

Last time I just used `CPString`s as my items in the sidebar. However, you can use whatever object you like. For this demo, I created a `SidebarColorItem` object to wrap all the details of my sidebar items--basically just a name, which the Outline View will display, and a color that will be the background color of the content view when the item is selected. The only thing you need to change from the [previous post][last post]'s code is the

    - (id)outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
    
of your data source. Instead of just returning `item`, you will want to return `[item name]` (the string that will be displayed in the outline view).

Also, I wanted my Outline View to show all of its top-level items as expanded when it is first loaded. I used the following method for that:

{% codeblock lang:objc %}
- (void)expandAllItems
{
	 var allItems = [items allKeys];
	 for (var i = 0; i < [allItems count]; i++)
	 {
		 [outlineView expandItem:[allItems objectAtIndex:i]];
	 }
}
{% endcodeblock %}

Finally, since I am using Atlas, I want Atlas to instantiate my `SidebarController` for me. To do that, go back to MainMenu.cib, drag a "Custom Object" into the object section (the area along the bottom of the window). With the new object selected, change its class in the Class tab to `SidebarController`. Also, connect the outlet `sidebarScrollView` of the SidebarController to the Scroll View in the left view.

This won't work on its own because our project doesn't know where that file is coming from. So in the `AppController`, `@import` the class file.

I kind of breezed over most of the implementation details of the `SidebarController`, so you may want to take a look at the full [SidebarController][] and [SidebarColorItem][] source.

[SidebarController]: http://github.com/chandlerkent/sample-projects/blob/master/SidebarChangingContentView/SidebarController.j
[SidebarColorItem]: http://github.com/chandlerkent/sample-projects/blob/master/SidebarChangingContentView/SidebarColorItem.j

## Create the Content View Controller

Now it is time to create the `ContentViewController`. For this demo, all it will do is change its background color based on the selection in the sidebar. You can probably imagine a more complex application that will swap out the content view instead. But this should help you get the idea.

The `ContentViewController` will have an outlet which references the right view of the Split View. This is the view whose background color will be changed.

In the `- (void)awakeFromCib` method (which will be called when our object is instantiated from MainMenu.cib), all we need to do is register our object to receive notifications when the Outline View's selection changed, specifically we want to know about the `CPOutlineViewSelectionDidChangeNotification` notification. This is done like:

{% codeblock lang:objc %}
[[CPNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(outlineViewSelectionDidChange:)
	 name:CPOutlineViewSelectionDidChangeNotification
	 object:nil];
{% endcodeblock %}
            
If you pass it a non-`nil` object, your selector will only be called when the notification is posted from that specific object. Also, you can specify whatever selector you want, but in this case I called it `- (void)outlineViewSelectionDidChange:`. This method will be called with the `CPNotification` object that was posted by the `CPNotificationCenter`. The implementation of this method may look like:

{% codeblock lang:objc %}
- (void)outlineViewSelectionDidChange:(CPNotification)notification
{
	 var outlineView = [notification object];
	 var selectedRow = [[outlineView selectedRowIndexes] firstIndex];
	 var item = [outlineView itemAtRow:selectedRow];

	 if ([item color])
	 {
	   [contentView setBackgroundColor:[item color]];
	 }
	 else
	 {
	   [contentView setBackgroundColor:[CPColor clearColor]];
	 }
}
{% endcodeblock %}
    
In the method you will notice that you can get the outline view through the method `[notification object]`. Then, you get the selected row of the outline view and finally the selected item. In your application you can do what you like with this item; I just change the background color of the content view.

Now go back in MainMenu.cib, drag out a new "Custom Object" and set its class to be `ContentViewController`. Now connect the `contentView` outlet to the right view of the Split View. Also, don't forget to `@import` the class file in your `AppController`.

## Putting it All Together

As a quick recap, you have:

* Used Atlas to setup a simple interface with a sidebar and a content view, wrapped with a split view
* Created a `SidebarController` that is in charge of creating and managing the items in an outline view
* Also created a small `SidebarColorItem` for the items in the sidebar
* Finally, created a `ContentViewController` that responds to the `CPOutlineViewSelectionDidChangeNotification` sent by the outline view

Now when you load the final application you should be able to select items from the sidebar and see the background color of the content view change. [Here][demo] is the demo of my finished application.

As you can see, it is relatively easy to create a simple application with a sidebar and a content view. While this example is fairly contrived, I'm sure you can envision how you can extend it for your own applications.

As always, the full source code for this application is available at [my GitHub account][sample-projects]: [here][SidebarChangingContentView]. If you have any questions, please post them in the comments section.

Stay tuned for my next post on how to style your Outline View to be a little less bland!

[sample-projects]: http://www.github.com/chandlerkent/sample-projects/