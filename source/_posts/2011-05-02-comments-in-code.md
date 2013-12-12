---
title: 'Don&#8217;t comment your code!'
author: Aron
layout: post
date: 2011-05-02 00:00:00 +0100
comments: true
permalink: /comments-in-code/
categories:
  - Misc
tags:
  - book
  - clean code
  - coding
  - coding style
  - comments
  - programming
---
![][1]  
<a style="font-size: 10px;" href="http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/389723#389723" target="_blank">stackoverflow.com</a>

&#8230; unless you know what you do.

<!--more-->

### The problem

Since I started programming I have always been fighting with &#8220;strange&#8221; code comments. Everyone told me I had to document my code. Also I wanted to be a good citizen and make it as easy as possible for my co-workers to understand my code. On the other hand there was always so little time. And writing good comments takes time. Also I understood that when the codes changes I also have to update the comments (even more time consuming). Plus I was not sure what to comment. Every line? Every method? Or a summary of the class in the header?

When I got better at coding I noticed that no one is writing comments. At least not many. However I found out that comments can be very useful when there is a codeline that needs clarification. So I still felt guilty for not commenting my code.

<a href="http://www.amazon.de/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/" target="_blank"><img style="float: left; margin-right: 8px; margin-bottom: 10px;" src="/images/img/clean-code.jpg" alt="" width="140" height="186" /></a> Last year I got my hands on <a href="http://www.amazon.de/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/" target="_blank">Clean Code</a> by <a href="http://twitter.com/unclebobmartin" target="_blank">Robert C. Martin</a>. **Dear programmers out there, you need to read this book**.

The chapter on Code Comments made me totally change my mind about writing comments and feeling guilty for not writing them. Bottom line: The code itself is the best comment, only write comments when it&#8217;s really needed, don&#8217;t leave commented code lines.

<h3 style="clear: both;">
  Example 1 &#8211; Annoying
</h3>

Recently I came into a project with some other programmers. I found the following comment styles (different coding styles aside, that is another story). Which do you find best?

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">public class AbstractModuleMediator extends Mediator implements IMediator {
	/* public variables and consts */

	/* protected and private variables and consts */

	private static const log : Logger = LogContext.getLogger(AbstractModuleMediator);

	/* public functions */

	/**
	 * Constructor for the AbstractModuleMediator class
	 */
	public function AbstractModuleMediator(name : String, viewComponent : IModule) {
		super(name, viewComponent);
	}
}
</pre>

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">public class SomeModule extends AbstractInteractionModule {
	private static const log : Logger = LogContext.getLogger(SomeModule);

	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	// VARIABLES
	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	private var _vo : SomeVo;

	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	// CONSTRUCTOR
	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	public function SomeModule() : void {

	};

	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	// PUBLIC FUNCTIONS
	// ✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖✖
	override public function create() : void {
	}
}
</pre>

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">public class SomeMediator extends AbstractModuleMediator implements IMediator {

	// _____________________________________________________________________________________________________________
	// C O N S T A N T
	// =============================================================================================================

	public static const NAME : String = "SomeMediator/";

	private static const log : Logger = LogContext.getLogger(SomeMediator);

	// _____________________________________________________________________________________________________________
	// V A R I A B L E S
	// =============================================================================================================

	// _____________________________________________________________________________________________________________
	// I N I T I A L I Z E
	// =============================================================================================================

	public function SomeMediator(name : String, module : IModule) {
		super(name, module);
		log.debug("VideoPlayerMediator()");
	}

	// _____________________________________________________________________________________________________________
	// P R I V A T E - F U N C T I O N S
	// =============================================================================================================
}
</pre>

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">public class SomeMediator extends AbstractModuleMediator
{
	public static const NAME:String = "SomeMediator/";

	private static const log:Logger = LogContext.getLogger(SomeMediator);

	public function SomeMediator(viewComponent : IModule)
	{
		super(NAME, viewComponent);
	}

	override public function onRegister() : void
	{
	}
}
</pre>

So what&#8217;s the best commented code? It&#8217;s #4. Why? Think about when you first enter a class to make some adjustments. You need to understand the code. You need to *read* the code. Everything thats distracts you from *reading code* is useless and should be avoided.

We all know (at least we should) the order of static field, public field, private field, constructor, public methods, private methods. No need to repeat that.

### Example 2 &#8211; Bad

The other thing Martin points out is the danger of uncommented code lines. This one is harder to achieve since it needs you to make a quick code review on all edited classes before you commit something. Take this example:

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">facade.registerProxy(new ChannelProxy());
facade.registerProxy(new SoundProxy());
//facade.registerProxy(new SoundAssetProxy());
facade.registerProxy(new SubtitleStateProxy());

facade.registerProxy(new SocialShareProxy());

facade.registerProxy(new TrackProxy());
</pre>

I had a ticket where I needed to fix a sound issue. I came across this command and the uncommented line left nothing but questions for me. Is this work in progress? Or a permanent removal? Does this Proxy even exist any longer? And most importantly: Does this has something to do with my issue?

Of course someone just forgot to remove this line/comment. However, it cost me some minutes to figure that out.

### Example 3 &#8211; EVIL

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">/**
 * Always returns true.
 */
public boolean isAvailable() {
    return false;
}
</pre>

Do I need to say more? This &#8211; of course &#8211; is the worst thing that can happen with code comments. The code changes but the comment stays the same. When you change a commented line/function/method and you can &#8211; for whatever reason &#8211; not change the comment, *delete the comment*.

### Conclusion

As you see from the examples it&#8217;s way harder to write good comments then no comments at all. So instead of making it all worse just don&#8217;t do it. If you consider yourself as someone who writes exceptable code, that should explain enough for you and your co-workers.

### Thats all folks. Oh wait&#8230;

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">//
// Dear maintainer:
//
// Once you are done trying to 'optimize' this routine,
// and have realized what a terrible mistake that was,
// please increment the following counter as a warning
// to the next guy:
//
// total_hours_wasted_here = 39
//
</pre>

[source][2]

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">stop(); // Hammertime!
</pre>

[source][3]

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">// I dedicate all this code, all my work, to my wife, Darlene, who will
// have to support me and our three children and the dog once it gets
// released into the public.
</pre>

[source][4] 

 [1]: /images/img/worst-comment.gif
 [2]: http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/482129#482129
 [3]: http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/186309#186309
 [4]: http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered/186967#186967