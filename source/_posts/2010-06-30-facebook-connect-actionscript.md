---
title: Facebook Connect ActionScript 3 ImageViewer Example
author: Phil
layout: post
date: 2010-06-30 00:00:00 +0100
comments: true
permalink: /facebook-connect-actionscript/
categories:
  - Flash
tags:
  - ActionScript
  - AS3
  - facebook
  - facebook connect
  - Flash
  - JavaScript
---
<a href="http://apdevblog.com/examples/fbconnect/" target="_blank"><img class="alignnone size-full wp-image-897" title="apdev_imageviewer" src="/images/2010/06/apdev_imageviewer.jpg" alt="" width="500" height="439" /></a>

I finally had the time to write something about the <a href="http://code.google.com/p/facebook-actionscript-api/" target="_blank">facebook-actionscript-api</a> we used in one of our last projects. It&#8217;s a very interesting API when you want to add Facebook support (user management) to your site/project. There are different things you can do with this API: i.e. access user information, post on the user&#8217;s wall, get user&#8217;s photos and much much more.

<!--more-->

For the litte demo application I decided to use the feature to access the user&#8217;s photos to create an <a href="http://apdevblog.com/examples/fbconnect/" target="_blank">ImageViewer</a> in pure ActionScript. It&#8217;s just a small example of what you can do with the <a href="http://code.google.com/p/facebook-actionscript-api/" target="_blank">facebook-actionscript-api</a> but I think it&#8217;s a good starting point for someone who hadn&#8217;t had the chance to take a look at this whole Facebook Connect stuff.

Facebook introduced a new API some weeks ago &#8211; the Graph API &#8211; but the <a href="http://code.google.com/p/facebook-actionscript-api/" target="_blank">facebook-actionscript-api</a> is still based on the &#8220;Old REST API&#8221;. You can find a in-depth documentation of the old API here: <a href="http://developers.facebook.com/docs/reference/rest/" target="_blank">http://developers.facebook.com/docs/reference/rest/</a>

Here are the methods we called to get all the info we needed for the ImageViewer demo:

*   **users.getInfo**  
    Returns a wide array of user-specific information for each user identifier passed, limited by the view of the current user.
*   **photos.get**  
    Returns all visible photos according to the filters specified.
*   **photos.getAlbums**  
    Returns metadata about all of the photo albums uploaded by the specified user.

But you don&#8217;t have to worry about the exact name or URL of the methods because the <a href="http://code.google.com/p/facebook-actionscript-api/" target="_blank">facebook-actionscript-api</a> provides Call-classes for every method there is (i.e. <a href="http://code.google.com/p/facebook-actionscript-api/source/browse/trunk/source/actionscript/com/facebook/commands/photos/GetAlbums.as" target="_blank">GetAlbums.as</a>).

Before you can send out any calls you have to get a Facebook session and of course log into your Facebook account. Session and login are handled via Facebook&#8217;s own JavaScript library (<a href="http://static.ak.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" target="_blank">http://static.ak.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php</a>).  
Here&#8217;s the JS part in our index.html:

<pre class="brush: jscript; title: ; wrap-lines: false; notranslate" title="">// ...
&lt;script type="text/javascript"&gt;

	function fbLogin(api_key)
	{
		FB.init(api_key, 'xd_receiver.htm', {"ifUserConnected":permissions});

		FB.ensureInit(function()
		{
			FB.Connect.get_status().waitUntilReady(function(status)
			{
				switch (status)
				{
					case FB.ConnectState.connected:
						loggedIn = true;
						break;

					case FB.ConnectState.appNotAuthorized:
					case FB.ConnectState.userNotLoggedIn:
						FB.Connect.requireSession();
						loggedIn = false;
						break;
				}
			});
		});
	}

	function permissions()
	{
		FB.Connect.showPermissionDialog('user_photos', onLoginHandler);
	}

	function onLoginHandler()
	{
		var session = FB.Facebook.apiClient.get_session();
		flashcontent.onLogin(session);
	}

&lt;/script&gt;
// ...
</pre>

We use the ExternalInterface to call the fbLogin() function from our ActionScript class passing the API_KEY as a parameter.

<pre>To get your own API key to meddle with, you have to have a Facebook account
and install the Developers application here: 
<a href="http://www.facebook.com/developers/" target="_blank">http://www.facebook.com/developers/</a>
You can create your own app after you've installed the developer stuff.</pre>

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// ...
ExternalInterface.call("fbLogin", FacebookConnectTest.API_KEY);
// ...
</pre>

Here is where the &#8220;Facebook magic&#8221; happens &#8230; the fbLogin() function connects to the Facebook page and checks the login status of the user. It either logs you in straightaway or displays the &#8220;connect screen&#8221; in an iFrame.

<img class="alignnone size-full wp-image-912" title="connect_screen" src="/images/2010/06/connect_screen.jpg" alt="" width="500" height="228" />

After confirming the connection the login form pops up in a new window.

<img class="alignnone size-full wp-image-913" title="facebook_login" src="/images/2010/06/facebook_login.jpg" alt="" width="500" height="264" />

After logging in, the user has to allow the application to access the information it needs (see permissions() function). Because we just want to display the user&#8217;s photos, we only need to get the &#8220;user_photos&#8221; permission.  
First allow access to the general user info.

<img class="alignnone size-full wp-image-915" title="fb_basic_info" src="/images/2010/06/fb_basic_info.jpg" alt="" width="500" height="318" />

And then allow us to grab your photos. This again happens in an iFrame overlay in the same window our app is running.

<img class="alignnone size-full wp-image-916" title="access_photos" src="/images/2010/06/access_photos.jpg" alt="" width="500" height="284" />

After settings all relevant permissions the onLoginHandler() JS-function is called. This function collects the creates session data and passes it to our flash-application (using an ExternalInterface-Callback).

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// ...

ExternalInterface.addCallback("onLogin", onLogin);

// ...

/**
 * JS callback - called when user logged into facebook account.
 */
private function onLogin(session:Object):void
{
	if(session == null)
	{
		return;
	}

	_session = session;

	// save session data in shared object for later use ...
	var my_so:SharedObject = SharedObject.getLocal(FacebookConnectTest.SO_NAME);
	my_so.data.session = session;

	// start a WebSession with the session secret and key passed in from Javascript
	var webSession:WebSession = new WebSession(FacebookConnectTest.API_KEY, session.secret, session.session_key);
	_facebook.startSession(webSession);

	webSession.addEventListener(FacebookEvent.CONNECT, onSessionConnect);
	webSession.addEventListener(FacebookEvent.ERROR, onSessionError);
	webSession.verifySession();
}
</pre>

We just take the supplied data and create a WebSession object and afterwards verify the session.  
In addition we are saving the session in a shared object so we can access it at a later time when the user returns to our application &#8211; if the session is still valid, we log the user in.

If the sessions is valid, the onSessionConnect() handler is called and we submit the first API call to retrieve the user&#8217;s first- and lastname.

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// ...
var call:FacebookCall = _facebook.post(new GetInfo([_session.uid], ['first_name', 'last_name']));
call.addEventListener(FacebookEvent.COMPLETE, handleGetInfoResponse);
// ...
</pre>

The <a href="http://code.google.com/p/facebook-actionscript-api/" target="_blank">facebook-actionscript-api</a> handles the results automatically and converts the returned XML into value objects we can use within our result handler:

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// ...
var infoData:GetInfoData = event.data as GetInfoData;
if(infoData != null)
{
	if(infoData.userCollection == null || infoData.userCollection.getItemAt(0) == null)
	{
		return;
	}

	var firstName:String = infoData.userCollection.getItemAt(0).first_name;
	var lastName:String = infoData.userCollection.getItemAt(0).last_name;

	_loginTxt.htmlText = "Hello " + firstName + " " + lastName + "! &lt;a href='event:logout'&gt;Logout&lt;/a&gt;";

	// ...
}
// ...
</pre>

Because the API is meant to be used with Flex we have to get used to the extra level of &#8220;collections&#8221; that are added to the data (i.e. infoData.userCollection). But we can access the ArrayCollection kinda like a normal Array &#8211; just use getItemAt(index:int) instead of the [].

Now we want to get the user&#8217;s photo albums &#8211; so create another call and submit it:

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// get albums
var call:FacebookCall = _facebook.post(new GetAlbums(_session.uid));
call.addEventListener(FacebookEvent.COMPLETE, handleGetAlbumsResponse);
// ...
</pre>

The result handler should look familiar:

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// ...
private function handleGetAlbumsResponse(event:FacebookEvent):void
{
	var albumsResponseData:GetAlbumsData = event.data as GetAlbumsData;
	if(albumsResponseData != null)
	{
		var tempCovers:Array = [];

		for(var i:int = 0; i &lt; albumsResponseData.albumCollection.length; i++)
		{
			var album:AlbumData = albumsResponseData.albumCollection.getItemAt(i) as AlbumData;
			if(album != null)
			{
				_albums.push(album);
				tempCovers.push(album.cover_pid);
			}
		}

		// ...
	}
}
// ...
</pre>

By now you should be comfortable working with the returned results &#8230;

If you want to know how the others call look like, download the sourcecode and open the FacebookConnectTest class.

To display the album thumbnails we used the TileList flash component &#8211; here is a good article how the component works: <a href="http://www.adobe.com/devnet/flash/quickstart/tilelist_component_as3/" target="_blank">http://www.adobe.com/devnet/flash/quickstart/tilelist_component_as3/</a>

If you still have questions, don&#8217;t hesitate to ask.

You can download the sourcecode here: [http://apdevblog.com/examples/fbconnect/source.zip ][1]  
You can find the online demo here: <a href="http://apdevblog.com/examples/fbconnect/" target="_blank">http://apdevblog.com/examples/fbconnect/ </a>

Don&#8217;t forget to download the SWC from Google code: <a href="http://code.google.com/p/facebook-actionscript-api/downloads/list" target="_blank">http://code.google.com/p/facebook-actionscript-api/downloads/list</a> (it isn&#8217;t included in our sources).

The ImageViewer code is by no means bug-free but &#8211; as i said before &#8211; should give you a good insight of the API. I put everything into one class &#8230; but don&#8217;t worry, I also added some short comments so hopefully you won&#8217;t get lost :)

Cheers  
Phil 

 [1]: http://apdevblog.com/examples/fbconnect/source.zip