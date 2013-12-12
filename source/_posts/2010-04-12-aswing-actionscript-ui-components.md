---
title: 'AsWing &#8211; ActionScript UI component framework'
author: Aron
layout: post
date: 2010-04-12 00:00:00 +0100
comments: true
permalink: /aswing-actionscript-ui-components/
categories:
  - Flash
  - Flex
tags:
  - ActionScript
  - AS3
  - AsWing
  - Flash
  - Flex
  - UI components
---
<a href="http://www.apdevblog.com/examples/aswing/login-demo.html" target="_blank"><img src="/images/img/login-demo.jpg" alt="AsWing example simple login" /></a>

Keith Peters was right, when he said, that Flash has a [lack of UI component frameworks][1]. The Flex components has a quasi monopoly on that. Besides his [minimal components][2] there is another alternative: AsWing.

Last year [Neue Digitale / Razorfish][3] gave me the chance to dive into [AsWing][4]. The task was to build a form manager that can not only run in Flex projects but also in straight AS3 projects where no flex runtime is available.

<!--more-->

[Click to see AsWing in action][5] (not very sexy, huu? Don&#8217;t worry, of course thats all skinnable :) ) . 

### Where does AsWing come from?

AsWing is a port of the famous Java UI framework Swing, which was first released in 1996. The original port was made to AS2, which is still available. However, with AsWing 2.0 the AS3 version will be complete. AsWing 2.0 is still beta but safe to use.

### How to use AsWing

Here some demo code from the simple login example above:

<pre class="brush: as3; title: ; wrap-lines: false; notranslate" title="">[SWF(backgroundColor="#AAAAAAA", frameRate="30", width="400", height="300")]
public class Main extends MovieClip
{
  private var pwdTextfield : JTextField;
  private var okBtn : JButton;
  private var userTextfield : JTextField;
  private var jf : JFrame;
  private var vp : JViewport;

  public function Main() 
  {
    var sprite:Sprite = new Sprite();
    sprite.x = sprite.y = 30;
    addChild(sprite);
    
    okBtn = new JButton("Ok");
    okBtn.setEnabled(false);
    okBtn.addActionListener(_okPressed);
    
    userTextfield = new JTextField("", 8);
    userTextfield.addEventListener(Event.CHANGE, _onPwdTextfieldChange);
    
    pwdTextfield =  new JTextField("", 8);
    pwdTextfield.setDisplayAsPassword(true);
    pwdTextfield.addEventListener(Event.CHANGE, _onPwdTextfieldChange);
    
    jf = new JFrame(sprite, "Login");
    
    var form:Form = new Form();
    
    form.addRow(new JLabel("Username"), new JSpacer(new IntDimension(8)), userTextfield);
    form.addRow(new JLabel("Password"), new JSpacer(new IntDimension(8)), pwdTextfield);
    form.addRow(null, new JSpacer(new IntDimension(8)), okBtn);
    
    vp = new JViewport(form);
    
    jf.getContentPane().append( vp );
    jf.setSizeWH(300, 160);
    jf.show();
  }

  private function _onPwdTextfieldChange(e:Event) : void 
  {
    okBtn.setEnabled( (userTextfield.getText() != "" && pwdTextfield.getText() != ""));
  }

  private function _okPressed(e:Event) : void 
  {
    var successOutput:String = "Welcome " + userTextfield.getText();
    
    var successLabel:JLabel = new JLabel(successOutput);
    
    vp.removeAll();
    vp.append(successLabel);
  }
}
</pre>

More sophisticated examples on request&#8230;

[The documentation can be found here][6]  
[Here some tutorial you can start with][7]

### How come that I never heard of it?

Well, I guess AsWing had it&#8217;s 15 minutes of fame when the AS2 version came out. Back then, there were not many robust UI frameworks. Obviously that changed with the hole Flex thing. Nowadays the people tend to use the Flex components, since it&#8217;s industry standard.

The Flex components offer a wide range of features. However, we all know that it&#8217;s getting tricky when you want to change basic functionality of them (not sure, if this still applies to Flex 4 Spark components). I&#8217;m not saying that this is all easy with AsWing, but at least you can just click in the source code and hack something in&#8230; ;)

### Pros and Cons

Pros  
- Ported from very robust Java Swing  
- Very fast  
- No Flex framework required (AS3 only)  
- Very flexible once learned

Cons  
- Tough learning curve  
- Small community  
- Future questionable

### Conclusion

Overall it was fun to work with AsWing. It&#8217;s powerful and once learned very flexible. And it&#8217;s fast as hell. The rendering is really fast unlike Flex(3). 

 [1]: http://www.bit-101.com/blog/?p=2323
 [2]: http://www.minimalcomps.com/
 [3]: http://www.neue-digitale.de/
 [4]: http://www.aswing.org/
 [5]: http://demo.aswing.org/showcase/ComSet.swf
 [6]: http://doc.aswing.org/a3/
 [7]: http://www.aswing.org/?page_id=5