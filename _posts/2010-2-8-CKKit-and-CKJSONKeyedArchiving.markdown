---
layout: post
published: false
title: CKKit and CKJSONKeyedArchiving
tags: [cappuccino, objective-j, CKKit, CKJSONKeyedArchiving, archiving, unarchiving, serialization]
---

When I relaunched my blog it was goal to write at least one post per week. Since my last post was about a month ago, I obviously have not met that goal. Unfortunately, a lot of other things have got in my way these last few weeks (mostly school), but I will continue to attempt to meet that goal, even if it means smaller posts.

<!-- more -->

I would like to continue to talk about Cappuccino, but stray from my last posts mostly about `CPOutlineView` and talk a little about [CKKit][] and a new project I just pushed. CKKit is a collection of classes I have created that I think are general enough that other Cappuccino developers might find them useful. As of this writing, there are only two projects in there, and only one that I think is worth talking about.

[CKKit]: http://www.github.com/chandlerkent/CKKit

## CKJSONKeyedArchiving

During the development of my current project, one of the team's goals was to iterate rapidly and continually move forward. In order to do that, we got a backend setup rather quickly and did the very minimum to get data into a database. At that time we set up [CouchDB][] for our database and used Cappuccino's keyed archiving and unarchiving to store objects in the database. This worked great for a long time, but it became evident that it would not support all the features that the application required. Most importantly, we needed to be able to do some searching on the data in Couch. Since Cappuccino's archiving just archives the objects into a string--which nobody outside of Cappuccino can easily read--it would be impossible to search the archives of the objects. The team came up with a couple of alternate solutions, like creating meta-documents in Couch that would be plaintext that could easily be searched and link back to the original documents. We did not think this was a very elegant solution.

[CouchDB]: http://couchdb.apache.org/

So instead, I wrote a simple archiver/unarchiver that would produce plain JSON objects. The JSON could be stored natively in Couch and could be easily searched because the object data was not hidden in a garbled string. The JSON also takes up less disk space in Couch (this fact surprised me and I can only assume it is because Couch is optimized to store JSON).

## How It Works

My initial goal was to create an exact port of the `CP`-counterparts. But due to time and some other requirements, that was not possible. For those reasons, the current implementation is very naive and does not come close to all the features that a full archiver/unarchiver needs. Some of the current limitations are:

* No support for a delegate. In Cocoa (really not sure about Cappuccino), there are a lot of nifty things you can do with the delegate methods. See [Apple's Documentation][Archive Programming Guide] for more information.
* No support for complex object relationships. My application has only linear relationships (from parent to child), so I had no need to support any of the more complex relationships.
* Object may be encoded more than once. This is mostly related to the above. The implementation just archives objects as it sees them, so this is not supported currently (Apple's docs. say that an object should only be archived once).
* No support for conditional archiving.
* Does not implement trivial encode/decode methods. I only implemented the ones that were needed (like `encodeInt:forKey:`), but I know they are not all in there.
* More that I don't even know about.

[Archive Programming Guide]: http://developer.apple.com/mac/library/documentation/cocoa/Conceptual/Archiving/Archiving.html

As you can see, there is a *lot* that is not currently supported/implemented. But it has worked for my application for a few months now, so I think it may be useful for other applications as well.

## Design Decisions

Native JSON, arrays, dictionaries, etc.

## How Its Used

How OSL uses it (ActiveRecord, Couch, etc.)

## Wrap Up