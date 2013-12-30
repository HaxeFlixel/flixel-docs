```
title: AS3 and Haxe Comparison
```

This document aims to give developers familiar with Actionscript 3 a quickstart to Haxe. For more Haxe specific documentation please refer to the main Haxe.org website:

- [Haxe Syntax](http://haxe.org/ref/syntax)
- [Haxe Language Reference](http://haxe.org/ref)

#### Additional Features

In addition to most of the features of Actionscript 3, Haxe includes support for:

* [enums](http://haxe.org/ref/enums)
* [type parameters](http://haxe.org/ref/type_params)
* [structures](http://haxe.org/ref/type_advanced)
* [custom iterators](http://haxe.org/ref/iterators)
* [conditional compilation](http://haxe.org/ref/conditionals)
* [inlining](http://haxe.org/ref/inline)
* and more!

----

###Haxe & AS3 common syntax comparison

This guide is based off from [OpenFL's guide](http://www.openfl.org/developer/documentation/actionscript-developers/).

###Basic Types

<div>
<div class="sideBySide spacer-right">
AS3

<pre class="highlighted">
Boolean
int
Number
Object
void
Array
Vector.&lt;String&gt;
</pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
Bool
Int
Float
Dynamic
Void
Array&lt;Dynamic&gt;
Array&lt;String&gt;
</pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Package Declarations</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
package com.example.myapplication {

}
</pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
package com.example.myapplication;
</pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Defining a Class</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
public class MyClass {

   public function MyClass () {


   }

}
</pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
class MyClass {

   public function new () {


   }

}
</pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Loops</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
for (var i:uint = 0; i &lt; 100; i++) {

}

for each (var value:String in items) {

}

for (var propertyName:String in object) {

}
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
for (i in 0...100) {

}

for (value in items) {

}

var fields = Reflect.fields (object);
for (propertyName in fields) {

}
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Switch Statements</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
switch (value) {

   case 1:
      trace ("Equal to 1");
      break;

   default:
      trace ("Not equal to 1");
      break;

}
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
switch (value) {

   case 1:
      trace ("Equal to 1");

   default:
      trace ("Not equal to 1");

}
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Type Inference</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
var hi = "Hello World";

// type is Object
// fails to compile in strict mode
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
var hi = "Hello World";

// type is String
// even works for code completion
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Type Casting</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
var car:Car = vehicle as Car;

var toString:String = String (10);
var toNumber:Number = Number ("10");
var toInteger:int = int (10.1);
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
var car:Car = cast vehicle;

// or for a safe cast:

var car = cast (vehicle, Car);

var toString = Std.string (10);
var toNumber = Std.parseFloat ("10");
var toInteger = Std.int (10.1);
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Type Details</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
if (vehicle is Car) {

}

import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

name = getQualifiedClassName (vehicle);
type = Class (getDefinitionByName (name);
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
if (Std.is (vehicle, Car)) {

}

type = Type.getClass (vehicle);
name = Type.getClassName (type);
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Checking for Null</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
if (object == null) {

}

if (!object) {

}
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
if (object == null) {

}
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Hash Tables</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
var table:Object = new Object ();
table["key"] = 100;

trace (table.hasOwnProperty ("key"));

for (var key:Object in table) {

   trace (key + " = " + table[key]);

}

delete table["key"];
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
var table = new Hash&lt;Int&gt; ();
table.set ("key", 100);

trace (table.exists ("key"));

for (key in table.keys ()) {

trace (key + " = " + table.get (key));

}

table.remove ("key");
</pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Rest Parameters</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
function test (...params):void {

}

test (1, 2, 3);
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
function test (params:Array&lt;Dynamic&gt;) {

}

Reflect.makeVarArgs (test) (1, 2, 3);
</pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Reflection</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
var foo = object["foo"];

bar.apply (this, [ "hi" ]);
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
var foo = Reflect.field (object, "foo");

Reflect.callMethod (this, bar, [ "hi" ]);
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Function Types</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
function hello (msg:String):void {

}

var type:Function = hello;
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
function hello (msg:String):Void {

}

var type:String-&gt;Void = hello;

// can also use Dynamic
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Getters and Setters</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
function get x ():Number {

   return _x;

}

function set x (value:Number):void {

   _x = value;

}
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
public var x (getX, setX):Float;

function getX ():Float {

   return _x;

}

function setX (value:Float):Float {

   return _x = value;

}
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>

<hr />
<h3>Read-Only Properties</h3>

<div>
<div class="sideBySide spacer-right">
<h4>AS3</h4>

<pre class="highlighted">
function get x ():Float {

   return _x;

}
        </pre>
</div>

<div class="sideBySide">
<h4>Haxe</h4>

<pre class="highlighted">
public var x (default, null):Float;

// null allows private access
// never would restrict all access
        </pre>
</div>

<div class="clear">&nbsp;</div>
</div>
