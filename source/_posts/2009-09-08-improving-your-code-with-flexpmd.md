---
title: Improving your code with FlexPMD
author: Phil
layout: post
date: 2009-09-08 00:00:00 +0100
comments: true
permalink: /improving-your-code-with-flexpmd/
syntaxhighlighter_encoded:
  - 1
categories:
  - Flex
tags:
  - ActionScript
  - Ant
  - code
  - Flex
  - FlexPMD
  - quality control
---
Last week Adobe released a nice tool called <a href="http://opensource.adobe.com/wiki/display/flexpmd/FlexPMD" target="_blank">FlexPMD</a> &#8211; it can help you and your development team to improve the quality of the code you generate by looking for common bad practices like i.e. unused or inefficient code.

To better understand how FlexPMD works and what it exactly does, have a look at <a href="http://opensource.adobe.com/wiki/display/flexpmd/About" target="_blank">&#8220;About FlexPMD&#8221;</a>.

You can use default or custom rulesets to control what FlexPMD is looking for. With the <a href="http://opensource.adobe.com/svn/opensource/flexpmd/bin/flex-pmd-ruleset-creator.html" target="_blank">Custom Ruleset Creator</a> you can &#8211; guess what &#8211; create your own rulesets and check your code against these rules.

There are three ways to use FlexPMD with your projects:

*   from the command line
*   from <a href="http://ant.apache.org/" target="_blank">Ant</a>
*   from <a href="http://maven.apache.org/" target="_blank">Maven</a>

<!--more-->

As we use FDT for all our programming, the easiest way to integrate FlexPMD with our current projects is via Ant. Unfortunately Adobe&#8217;s example is faulty, so I thought I should post a correct build.xml for all of you that are interested in using FlexPMD with Ant.

<pre class="brush: xml; title: ; wrap-lines: false; notranslate" title="">&lt;project name="Flex PMD example" default="flexPmdWithDefaultRuleset" basedir="." &gt;

    &lt;description&gt;Flex PMD example&lt;/description&gt;

    &lt;property name="src.dir" value="${basedir}/classes/" /&gt;
    &lt;property name="bin.dir" value="${basedir}/../bin/" /&gt;
	
    &lt;property name="flexpmd.version" value="1.0.RC3" /&gt;
    &lt;property name="flexpmd.dir" value="${basedir}/../flexpmd" /&gt;

    &lt;!--**************************************************** 
                FlexPMD
        *****************************************************--&gt;

    &lt;taskdef name="flexPmd" 
		classname="com.adobe.ac.pmd.ant.FlexPmdAntTask" 
		classpath="${flexpmd.dir}/flex-pmd-ant-task-${flexpmd.version}.jar"&gt;
        &lt;classpath&gt;
            &lt;pathelement location="${flexpmd.dir}/flex-pmd-ruleset-api-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/flex-pmd-ruleset-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/flex-pmd-core-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/as3-plugin-utils-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/as3-parser-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/pmd-4.2.2.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/commons-lang-2.4.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/flex-pmd-files-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/as3-parser-api-${flexpmd.version}.jar"/&gt;
            &lt;pathelement location="${flexpmd.dir}/plexus-utils-1.0.2.jar"/&gt;
        &lt;/classpath&gt;
    &lt;/taskdef&gt;

    &lt;target name="flexPmdWithCustomRuleset"&gt;
        &lt;flexPmd 
            sourceDirectory="${src.dir}" 
            outputDirectory="${bin.dir}" 
            ruleSet="${flexpmd.dir}/pmd.xml"/&gt;
    &lt;/target&gt;

    &lt;target name="flexPmdWithDefaultRuleset"&gt;
        &lt;flexPmd 
            sourceDirectory="${src.dir}" 
            outputDirectory="${bin.dir}"/&gt;
    &lt;/target&gt;

&lt;/project&gt;
</pre>

The Ant script creates a file containing all the found violations. You can view the file with <a href="http://opensource.adobe.com/svn/opensource/flexpmd/bin/flex-pmd-violations-viewer.html" target="_blank">Adobe&#8217;s online viewer</a>.

You can download all versions of FlexPMD here: <a href="http://opensource.adobe.com/wiki/display/flexpmd/Downloads" target="_blank">FlexPMD @ Open Source Adobe</a>.

So hopefully &#8211; in the future &#8211; we&#8217;ll all write better code :)

Cheers. 