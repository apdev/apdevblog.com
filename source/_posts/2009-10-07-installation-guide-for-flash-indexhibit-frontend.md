---
title: Installation guide for Flash Indexhibit frontend
author: Phil
layout: post
date: 2009-10-07 00:00:00 +0100
comments: true
permalink: /installation-guide-for-flash-indexhibit-frontend/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flash
tags:
  - ActionScript
  - AMF
  - AMFPHP
  - Flash
  - Flash Remoting
  - guide
  - indexhibit
  - install
  - swfaddress
  - swffit
  - swfobject
---
Because some of you asked for an installation guide for the <a href="http://apdevblog.com/flash-frontend-for-indexhibit-cms/" target="_blank">example</a> I posted earlier &#8211; here comes a small how-to so that you can get the demo up and running on your own computer/webserver.

There is more than one way to get this done &#8230;

<!--more-->

1) you can focus on the visual part (flash) and just use our <a href="http://indexhibit.org" target="_blank">Indexhibit</a> installation / <a href="http://apdevblog.com/indexhibit/amf/gateway.php" target="_blank">remoting gateway</a> to get the data into your flash-page

or

2) you want to install everything on your own computer/webserver and create your own flash/indexhibit page.

for 1) just download the <a href="http://apdevblog.com/sources-for-flash-frontend-for-indexhibit-cms/" target="_blank">sources</a> and take a look at the frontend-classes within the *com.apdevblog.examples.indexhibit.view* package. play with them and change the things you need to alter the look of the entire page. don&#8217;t modify the amf-server url and you&#8217;ll get our dummy-posts to be displayed in your page (for testing purposes).

for the rest of you (2) &#8230; here is the short installation guide.

*   requirements: webserver running php (>=4) and mysql
*   <a href="http://indexhibit.org/install/" target="_blank">install Indexhibit</a> in a subdirectory of your webserver (e.g. /ndxz)
*   copy the &#8220;amf&#8221; folder to the root-directory of your webserver (this is the installation of amfphp)
*   then make sure you can access the remote gateway of your amfphp installation by opening the URL in your browser (sth. like http://localhost/amf/gateway.php) &#8211; it should look like our <a href="http://apdevblog.com/indexhibit/amf/gateway.php" target="_blank">gateway</a>.
*   change the values in /amf/includes/dbaccess.php to fit your mysql-user and DB
*   also, you need to change the *SERVER_URL* inside of the Constants-AS3-class (*com.apdevblog.examples.indexhibit.model.Constants*)
*   now you should be able to compile* the swf and grab the data from your server

* we are using the <a href="http://www.adobe.com/cfusion/entitlement/index.cfm?e=flex3sdk" target="_blank">flex 3 sdk</a> to compile the Index.as. But you have to add the &#8220;frame&#8221;-parameter to the compiler arguments:

<pre>-frame two com.apdevblog.examples.indexhibit.Main</pre>

**\*\\*\* Important notice \*\** :)**  
For those of you who are not that much into flash/flex and never used the flex compiler before I am currently working on a FLA-file that will also compile the example (stay tuned).

The example is heavily based on the <a href="http://puremvc.org/" target="_blank">pureMVC framework</a> &#8211; so again, if you&#8217;re not familiar with this framework, you better wait for the easier-to-use FLA-file example coming up this week.

This is it for now &#8211; if there are any questions or suggestions for improvement just post a comment and we&#8217;ll get to it right away.

Cheers 