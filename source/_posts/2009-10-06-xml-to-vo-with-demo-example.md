---
title: 'XML to VO &#8211; as easy as apple pie!? (demo included)'
author: Aron
layout: post
date: 2009-10-06 00:00:00 +0100
comments: true
permalink: /xml-to-vo-with-demo-example/
categories:
  - Flash
tags:
  - ActionScript
  - Flex
  - soap
  - value object
  - vo
  - wsdl
  - XML
  - XMLDecoder
  - XMLSchema
---
![xml to vo debug dialog][1]

I&#8217;m currently working with SOAP web services. While making adjustments to the classes of the [wsdl Flex Builder class generator][2] I discovered, that there is an easy way to decode / parse XML to VOs ([value objects][3]). The XMLDecoder inside the [rpc package][4] does the trick. I&#8217;m still confused why there are not more resources on the web regarding this topic but If you want to digg deeper, I strongly recommend reading these blog posts by [Dominic De Lorenzo][5]:

[Flex 3, XML Schemas &#038; automatic mapping of AS classes to XSD element definitions (Part 1)][6]  
[Flex 3, XML Schemas &#038; automatic mapping of AS classes to XSD element definitions (Part 2)][7]

I&#8217;m not an XML pro and some things in his example I&#8217;m still not getting (namespaces in XML, yes well&#8230;). Also, his example is in Flex and I just wanted to have a basic example on how this could be useful for my work.

<!--more-->

<span style="font-size:16px; font-weight:bold">Example / Demo</span>

You have to tell the XMLDecoder what XML node is assigend to which VO type. &#8220;Schema&#8221; is the magic word &#8211; so before feeding the actual XML data to the XMLDecoder the SchemaManager needs to know what the XML structure looks like. After that, you just have to map the schema types to your custom VOs.

You can take a look at the VO classes here:  
[FieldVo][8]  
[GroupVo][9]

And this&#8217;s the actual example implementation &#8230;

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">private var schemaXML:XML = 

&lt;xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"&gt;

  &lt;xsd:element name="root" &gt;
    &lt;xsd:complexType &gt;
      &lt;xsd:sequence &gt;
        &lt;xsd:element minOccurs="0" maxOccurs="unbounded" name="group" type="group"/&gt;
      &lt;/xsd:sequence&gt;
    &lt;/xsd:complexType&gt;
  &lt;/xsd:element&gt;
  
  &lt;xsd:complexType name="group"&gt;
     &lt;xsd:sequence&gt;
      &lt;xsd:element name="id" type="xsd:string" /&gt;
      &lt;xsd:element name="field" type="field" minOccurs="0" maxOccurs="unbounded"/&gt;
      &lt;xsd:element name="group" type="group" minOccurs="0" maxOccurs="unbounded"/&gt;
    &lt;/xsd:sequence&gt;
  &lt;/xsd:complexType&gt;
  
  &lt;xsd:complexType name="field"&gt;
     &lt;xsd:sequence&gt;
      &lt;xsd:element name="id" type="xsd:string" /&gt;
      &lt;xsd:element name="index" type="xsd:int" /&gt;
      &lt;xsd:element name="label" type="xsd:string" /&gt;
      &lt;xsd:element name="visible" type="xsd:boolean" /&gt;
    &lt;/xsd:sequence&gt;
  &lt;/xsd:complexType&gt;	
  
&lt;/xsd:schema&gt;;

private var dataXML:XML = 

&lt;root&gt;
  &lt;group&gt;
    &lt;id&gt;group01&lt;/id&gt;
    &lt;field&gt;
      &lt;id&gt;field01&lt;/id&gt;
      &lt;index&gt;1&lt;/index&gt;
      &lt;label&gt;test field 01&lt;/label&gt;
      &lt;visible&gt;1&lt;/visible&gt;
    &lt;/field&gt;
    &lt;field&gt;
      &lt;id&gt;field02&lt;/id&gt;
      &lt;index&gt;2&lt;/index&gt;
      &lt;label&gt;test field 02&lt;/label&gt;
      &lt;visible&gt;0&lt;/visible&gt;
    &lt;/field&gt;
    &lt;field&gt;
      &lt;id&gt;field03&lt;/id&gt;
      &lt;index&gt;3&lt;/index&gt;
      &lt;label&gt;test field 03&lt;/label&gt;
      &lt;visible&gt;1&lt;/visible&gt;
    &lt;/field&gt;
    &lt;group&gt;
      &lt;id&gt;group0101&lt;/id&gt;
      &lt;field&gt;
        &lt;id&gt;field04&lt;/id&gt;
        &lt;index&gt;4&lt;/index&gt;
        &lt;label&gt;test field 04&lt;/label&gt;
        &lt;visible&gt;1&lt;/visible&gt;
      &lt;/field&gt;      
      &lt;field&gt;
        &lt;id&gt;field05&lt;/id&gt;
        &lt;index&gt;5&lt;/index&gt;
        &lt;label&gt;test field 05&lt;/label&gt;
        &lt;visible&gt;0&lt;/visible&gt;
      &lt;/field&gt;      
    &lt;/group&gt;
  &lt;/group&gt;
  &lt;group&gt;
    &lt;id&gt;group02&lt;/id&gt;
    &lt;field&gt;
      &lt;id&gt;field06&lt;/id&gt;
      &lt;index&gt;6&lt;/index&gt;
      &lt;label&gt;test field 06&lt;/label&gt;
      &lt;visible&gt;1&lt;/visible&gt;
    &lt;/field&gt;         
  &lt;/group&gt;
&lt;/root&gt;;
		
var schema:Schema = new Schema(schemaXML);

var schemaManager:SchemaManager = new SchemaManager();
schemaManager.addSchema(schema);

var schemaTypeRegistry:SchemaTypeRegistry = SchemaTypeRegistry.getInstance();
schemaTypeRegistry.registerClass(new QName(schema.targetNamespace.uri, "group"), GroupVo);
schemaTypeRegistry.registerClass(new QName(schema.targetNamespace.uri, "field"), FieldVo);

var qName:QName = new QName(schema.targetNamespace.uri, "root");

var xmlDecoder:XMLDecoder = new XMLDecoder();
xmlDecoder.schemaManager = schemaManager;
  
var result:* = xmlDecoder.decode(dataXML, qName);
trace(result);
</pre>

You might want to set a breakpoint at the trace statement so you can click through the result object step by step.

Please contribute!  
Did you ever work with the XMLDecoder? Do you think, that this might improve your workflow? Just tell us. 

 [1]: /images/img/xml-to-vo-debug.gif
 [2]: http://www.flexlive.net/?p=79
 [3]: http://en.wikipedia.org/wiki/Data_transfer_object
 [4]: http://opensource.adobe.com/svn/opensource/flex/sdk/trunk/frameworks/projects/rpc/src/mx/
 [5]: http://blog.misprintt.net/
 [6]: http://blog.misprintt.net/?p=181
 [7]: http://blog.misprintt.net/?p=192
 [8]: /examples/xml-to-vo/FieldVo.as
 [9]: /examples/xml-to-vo/GroupVo.as