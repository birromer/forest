+++
title = "Muddy children problem"
lastmod = 2022-12-04T15:53:44+01:00
tags = ["phd", "distributed computing"]
categories = ["distributed computing"]
draft = true
author = "Bernardo Hummes"
link-citations = true
+++

<div class="ox-hugo-toc toc">

<div class="heading">Table of Contents</div>

- [Notes](#notes)

</div>
<!--endtoc-->


date created
: <span class="timestamp-wrapper"><span class="timestamp">&lt;2022-12-02 Fri&gt;</span></span>

tags
:

related
:


## Notes {#notes}

This initial problem instantiates how knowledge evolves via communication of agents that begin without knowing their own states. One possible enunciation is as follows:

> A group of children is playing in the garden, and some of them end up with mud on their foreheads. Each child can see the other children's foreheads but not his or her own. At noon, their teacher summons the children and says: "At least one of you has a muddy forehead. You are not allowed to communicate with one another about it in any manner. But whenever you become certain that you are dirty, you must announce it to everybody, exactly on the hour." The children resume playing normally, and nobody mentions the state of anyone's forehead. There are six muddy children, and at 6:00 they all announce themselves. How does this work?

This is an idealized problem that shows how information can be gained from each round and that the announcement of existing at least one children with mud in their forehead allows this to happen. If we reduce this problem to only 3 children, it get easier to see how the problem is solved if at least a single one is muddy in the following steps:

1.  The professor announces that there is at least one muddy children, removing the option of everyone being clean.
2.  Everyone knows each other's foreheads, which means that each person can either:
    1.  See no other muddy forehead, which means that they are the muddy one and announce in the next communication round;
    2.  See one or two other muddy foreheads, which does not give enough information about themselves.
3.  Having seen one or two muddy foreheads they can:
    1.  If they saw only one other muddy, they know they must be the second and announce in the next round;
    2.  If they saw two, they don't have enough information and wait.
4.  Having seen two children with mud and two rounds with no announcements, they all announce that they have a muddy forehead.

This is equivalently represented in the following simplicial complex, where each solid triangle has a possible configuration of the three children, each with one color, and considering that they don't know their own state. This representation consists of each vertex representing a possible state of the children, muddy or not. Each state is connected with edges to all others that could be true (it is indistinguishable) while they are true. The following image shows all possible scenarios.

<a id="figure--fig.muddy-complex"></a>

{{< figure src="/ox-hugo/complex_muddy.png" caption="<span class=\"figure-number\">Figure 1: </span>Evolution of the complex through the rounds of (lack of) communication, credit from <&herlihyDistributedComputingCombinatorial2014>." >}}

The triangle on top represents all three children are clean, while each individual vertex of this triangle represents each children being clean.
The facets represent global states (in this case triangles), in the form \\(111\\) or \\(01\bot\\), where \\(0\\) and \\(1\\) represent muddy or not, and \\(\bot\\) the lack of information
This shows how each vertex has meaning even without context.
From this one must note that each vertex connects exactly two triangles, which are the two possible scenarios where this children is the only one that changes between muddy or not. These connections, when interpreted as possible worlds, show that for children A with no knowledge about itself, the world where children B sees no mud in the other ones, children C sees no mud on the other ones, children B sees mud in A but not in C, and children C sees mud in A but not in B are equivalent.

As the announcement in step 1 happens, the top triangle is removed and the top vertices are "exposed", left without ambiguity. This means that, in this case, a children will have enough information to announce it, as in step 2.a. This process repeats in the case of no announcements, leaving the possibilities of \\(\bot01, 0\bot1, 01\bot, \bot10, 1\bot0, 10\bot\\). If some of this scenarios is fulfilled, then there will be no more lack of information and they announce, as in step 3.1; In step 4 we see them simply having the option of being all muddy.



<style>.csl-entry{text-indent: -1.5em; margin-left: 1.5em;}</style><div class="csl-bib-body">
</div>
