+++
title = "Two generals problem"
author = ["Bernardo Hummes Flores"]
lastmod = 2022-11-29T15:51:39+01:00
tags = ["phd", "distributed_computing"]
draft = false
+++

This second problem shows how in some cases failures in communication is enough for making it impossible to reach a decision. The enunciation of the problem is as follows.

> Two army division, one commanded by general ALice and one by general Bob, are camped on two hilltops overlooking a valley, The enemy is camped in the valley. If both divisions attack simultaneously, they will win, but if only one division attacks by itself, it will be defeated. As a result, neither general will attack without a guarantee that the other will attack at the same time. In particular, **neither general will attack without communication from the other**.
>
> At the time the divisions are deployed on hilltops, **the generals had not agreed on whether or when to attack**. Now Alice decides to schedule an attack. **The generals can communicate only by messengers**. Normally it takes a messenger exactly one hour to get from one encampment to the other. However, it is possible that he will get lost in the dark or, worse yet, be capture by the enemy. Fortunately, **on this particular night all the messenger happen to arrive safely**. How long will it take Alice and Bob to coordinate their attack?

We are interested in arriving in a common decision for both agents, so that either the attack and the decision to stay put are shared.
However, one can see that no number of messages will be enough for this to be agreed upon, as the resulting scenario after a message is received or lost is the same for those who sent it.
Another confirmation will be required and this process will never end.
The delay is not considered here, as this problem is impossible even without taking this into consideration.
It is possible to see in image <fig:complex_generals> the possible states.

<a id="figure--fig:complex-generals"></a>

{{< figure src="/ox-hugo/complex_two_generals.png" caption="<span class=\"figure-number\">Figure 1: </span>The evolving states after each general sends a message, credit to <&herlihyDistributedComputingCombinatorial2014>." >}}

At first, we can see that Bob, without any messages received, consider equally the possibility of Alice having sent either the command to attack at dawn or to attack at noon.
Once a message is received, Alice will see as equally possible the case where Bob received the message or it has not.
This same pattern will repeat forever, and we can say that topologically it will always have one connected component.
The impossibility appears when we compare with what are the desired configurations, with three different scenarios where they either both attack at dawn, at noon or not at all, seen in figure <fig:solvability_generals>.
Topologically this constitutes three disconnected components, which is impossible to map functionally from the previous space.
This will be further explained in colorless tasks and general tasks, where the precise requirements for solvability are exposed.

<a id="figure--fig:solvability-generals"></a>

{{< figure src="/ox-hugo/solvability_generals.png" caption="<span class=\"figure-number\">Figure 2: </span>The impossible mapping for the generals communication, credit to <&herlihyDistributedComputingCombinatorial2014>." >}}
