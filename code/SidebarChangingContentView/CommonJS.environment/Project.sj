@STATIC;1.0;p;15;AppController.jI;21;Foundation/CPObject.ji;19;SidebarController.ji;23;ContentViewController.jc;600;
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow")]);
objj_registerClassPair(_1);
objj_addClassForBundle(_1,objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(_1,[new objj_method(sel_getUid("theWindow"),function(_3,_4){
with(_3){
return theWindow;
}
}),new objj_method(sel_getUid("setTheWindow:"),function(_5,_6,_7){
with(_5){
theWindow=_7;
}
}),new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_8,_9,_a){
with(_8){
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_b,_c){
with(_b){
}
})]);
p;23;ContentViewController.jI;21;Foundation/CPObject.jc;1161;
var _1=objj_allocateClassPair(CPObject,"ContentViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("contentView")]);
objj_registerClassPair(_1);
objj_addClassForBundle(_1,objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(_1,[new objj_method(sel_getUid("contentView"),function(_3,_4){
with(_3){
return contentView;
}
}),new objj_method(sel_getUid("setContentView:"),function(_5,_6,_7){
with(_5){
contentView=_7;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_8,_9){
with(_8){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_8,sel_getUid("outlineViewSelectionDidChange:"),CPOutlineViewSelectionDidChangeNotification,nil);
}
}),new objj_method(sel_getUid("outlineViewSelectionDidChange:"),function(_a,_b,_c){
with(_a){
var _d=objj_msgSend(_c,"object");
var _e=objj_msgSend(objj_msgSend(_d,"selectedRowIndexes"),"firstIndex");
var _f=objj_msgSend(_d,"itemAtRow:",_e);
if(objj_msgSend(_f,"color")){
objj_msgSend(contentView,"setBackgroundColor:",objj_msgSend(_f,"color"));
}else{
objj_msgSend(contentView,"setBackgroundColor:",objj_msgSend(CPColor,"clearColor"));
}
}
})]);
p;6;main.jI;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jc;52;
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;18;SidebarColorItem.jI;21;Foundation/CPObject.jc;929;
var _1=objj_allocateClassPair(CPObject,"SidebarColorItem"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("name"),new objj_ivar("color")]);
objj_registerClassPair(_1);
objj_addClassForBundle(_1,objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(_1,[new objj_method(sel_getUid("name"),function(_3,_4){
with(_3){
return name;
}
}),new objj_method(sel_getUid("setName:"),function(_5,_6,_7){
with(_5){
name=_7;
}
}),new objj_method(sel_getUid("color"),function(_8,_9){
with(_8){
return color;
}
}),new objj_method(sel_getUid("setColor:"),function(_a,_b,_c){
with(_a){
color=_c;
}
}),new objj_method(sel_getUid("init"),function(_d,_e){
with(_d){
return objj_msgSend(_d,"initWithName:color:","",nil);
}
}),new objj_method(sel_getUid("initWithName:color:"),function(_f,_10,_11,_12){
with(_f){
if(_f=objj_msgSendSuper({receiver:_f,super_class:objj_getClass("CPObject")},"init")){
name=_11;
color=_12;
}
return _f;
}
})]);
p;19;SidebarController.jI;21;Foundation/CPObject.jI;22;AppKit/CPOutlineView.ji;18;SidebarColorItem.jc;3364;
var _1=objj_allocateClassPair(CPObject,"SidebarController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("sidebarScrollView"),new objj_ivar("outlineView"),new objj_ivar("items")]);
objj_registerClassPair(_1);
objj_addClassForBundle(_1,objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(_1,[new objj_method(sel_getUid("sidebarScrollView"),function(_3,_4){
with(_3){
return sidebarScrollView;
}
}),new objj_method(sel_getUid("setSidebarScrollView:"),function(_5,_6,_7){
with(_5){
sidebarScrollView=_7;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_8,_9){
with(_8){
items=objj_msgSend(_8,"defaultSidebarItems");
var _a=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","column");
objj_msgSend(_a,"setWidth:",400);
outlineView=objj_msgSend(objj_msgSend(CPOutlineView,"alloc"),"initWithFrame:",objj_msgSend(objj_msgSend(sidebarScrollView,"contentView"),"bounds"));
objj_msgSend(outlineView,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSend(outlineView,"setHeaderView:",nil);
objj_msgSend(outlineView,"setCornerView:",nil);
objj_msgSend(outlineView,"addTableColumn:",_a);
objj_msgSend(outlineView,"setOutlineTableColumn:",_a);
objj_msgSend(outlineView,"setDataSource:",_8);
objj_msgSend(sidebarScrollView,"setDocumentView:",outlineView);
objj_msgSend(_8,"expandAllItems");
}
}),new objj_method(sel_getUid("expandAllItems"),function(_b,_c){
with(_b){
var _d=objj_msgSend(items,"allKeys");
for(var i=0;i<objj_msgSend(_d,"count");i++){
objj_msgSend(outlineView,"expandItem:",objj_msgSend(_d,"objectAtIndex:",i));
}
}
}),new objj_method(sel_getUid("defaultSidebarItems"),function(_e,_f){
with(_e){
var _10=objj_msgSend(objj_msgSend(SidebarColorItem,"alloc"),"initWithName:color:","Red",objj_msgSend(CPColor,"redColor"));
var _11=objj_msgSend(objj_msgSend(SidebarColorItem,"alloc"),"initWithName:color:","Blue",objj_msgSend(CPColor,"blueColor"));
var _12=objj_msgSend(objj_msgSend(SidebarColorItem,"alloc"),"initWithName:color:","Green",objj_msgSend(CPColor,"greenColor"));
var _13=objj_msgSend(objj_msgSend(SidebarColorItem,"alloc"),"initWithName:color:","Colors",nil);
return objj_msgSend(CPDictionary,"dictionaryWithObjectsAndKeys:",[_10,_12,_11],_13);
}
})]);
var _1=objj_getClass("SidebarController");
if(!_1){
objj_exception_throw(new objj_exception(OBJJClassNotFoundException,"*** Could not find definition for class \"SidebarController\""));
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("outlineView:child:ofItem:"),function(_14,_15,_16,_17,_18){
with(_14){
if(_18===nil){
var _19=objj_msgSend(items,"allKeys");
return objj_msgSend(_19,"objectAtIndex:",_17);
}else{
var _1a=objj_msgSend(items,"objectForKey:",_18);
return objj_msgSend(_1a,"objectAtIndex:",_17);
}
}
}),new objj_method(sel_getUid("outlineView:isItemExpandable:"),function(_1b,_1c,_1d,_1e){
with(_1b){
var _1f=objj_msgSend(items,"objectForKey:",_1e);
return (objj_msgSend(_1f,"count")>0);
}
}),new objj_method(sel_getUid("outlineView:numberOfChildrenOfItem:"),function(_20,_21,_22,_23){
with(_20){
if(_23===nil){
return objj_msgSend(items,"count");
}else{
var _24=objj_msgSend(items,"objectForKey:",_23);
return objj_msgSend(_24,"count");
}
}
}),new objj_method(sel_getUid("outlineView:objectValueForTableColumn:byItem:"),function(_25,_26,_27,_28,_29){
with(_25){
return objj_msgSend(_29,"name");
}
})]);
e;