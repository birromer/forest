+++
title = "Simplicial complexes"
lastmod = 2022-12-06T10:55:19+01:00
tags = ["combinatoral topology", "distributed computing"]
categories = ["distributed computing"]
draft = true
author = "Bernardo Hummes"
link-citations = true
+++

<div class="ox-hugo-toc toc">

<div class="heading">Table of Contents</div>

- [Notes](#notes)
    - [Definitions](#definitions)
    - [Coloring](#coloring)
    - [Maps](#maps)
    - [Constructions](#constructions)

</div>
<!--endtoc-->



## Notes {#notes}


### Definitions {#definitions}

The representation via graphs is limited to at most one failing process, allowing for more on the analysis of specific cases such as consensus with synchronous communication. In order to study general tasks with models where more than once process can fail, _simplicial complexes_ are useful, as higher order graphs.

<div class="definition">

A **simplicial complex** in the combinatorial view is a pair \\(\cal K = (V,S)\\), where \\(V\\) is a finite set of vertices and \\(S \subseteq \mathcal{P}(V)\\) is a set of simplices, non-empty subsets of \\(V\\), where:

-   For every \\(v \in V, \\{v\\} \in S\\). The sets of singleton vertices are part of the set of simplices
-   \\(S\\) is downward-closed, i.e. for every \\(Y \in S\\) and for every non-empty subset \\(X \subseteq Y, X \in S\\). All of the non-empty subsets of a simplex are part of the set of simplices too, and we say that \\(X\\) is a face of \\(Y\\).

</div>

The dimension of a _simplex_ \\(X\\) is \\(dim(X) = card(X)-1\\), where the cardinality is the number of edges, and the \\(codim(\sigma, A) = dim(A) - dim(\sigma)\\), where facets have codimension 0. The dimension of a _simplicial complex_ \\(\cal K\\) will be the maximal dimension of a simplex of \\(\cal K\\), i.e. \\(dim(\cal K) = \text{max} \\{ \text{dim}(X) | X \in S \\}\\). Vertices \\(v \in V\\) are usually identified as a 0-dimensional simplex \\(\\{v\\} \in S\\). The maximal simplexes are _facets_, where their definition of being strictly contained \\(\Delta  \subset C\\) is only respected w.r.t. the "original" complex. A simplicial complex is _pure_ of dimension \\(n\\) if all facets are of the same dimension \\(n\\). Graphs can be seen as pure 1 dimensional simplicial complexes, with maximal simplexes of dimension 1 (i.e. edges), "glued" together. We can see an example in figure <fig.smp_cpx_ex_1>. Faces can be obtained from excluding a subset of vertices, such as the triangle defined over \\(\\{1,2,3\\}\\) has as its third face \\(\\{1,2,\hat 3\\}\\), seen in figure <fig.smp_cpx_faces>.

<a id="figure--fig.smp-cpx-ex-1"></a>

{{< figure src="/ox-hugo/smp_cpx_ex_1.png" caption="<span class=\"figure-number\">Figure 1: </span>Non pure simplicial complex of dimension 2 (maximal simplex of dimension 2, i.e. triangle)." >}}

<a id="figure--fig.smp-cpx-faces"></a>

{{< figure src="/ox-hugo/smp_cpx_faces.png" caption="<span class=\"figure-number\">Figure 2: </span>3rd face of a triangle." >}}

We can define new complexes from an existing one, such as the l-skeleton of C, also written \\(skel^l( C)\\), with the simplicies of C with dimension at most \\(l\\), e.g. \\(skel^0( C)\\) is the set of vertices. \\(2^{\sigma}\\) is the complex containing \\(\sigma\\) and all of its faces, and usually is the same as \\(\sigma\\). \\(\partial 2^{\sigma}\\) (or \\(\partial \sigma\\)) is the boundary complex of \\(\sigma\\), the set of proper faces (facets), and can also be defined as \\(skel^{n-1} \sigma\\), where \\(n\\) is the dimension of \\(\sigma\\).

It is also possible to give a geometric explanation for simplicial complexes, into its geometric realization \\(|\cal A|\\), where we have simplexes "glued" by the edges. They live in \\(\mathbb{R}^d\\) and the focus is on the occupied a space and related topology. It is possible to generate one abstract simplicial complex from a geometric simplicial complex, but many in the other direction.


### Coloring {#coloring}

Together with the idea of processes in a distributed system, it becomes relevant to identify them in the structures used. This is done via the coloring of vertices, where given a set \\(A\\) of agents, we have:

<div class="definition">

A chromatic simplicial complex is a pair \\(\langle K, \cal X \rangle\\), consisting of a simplicial complex \\(\cal K\\) and a coloring map \\(\mathcal{X}: \mathcal{\cal V}(K) \to A\\), such that for all simplexes \\(X \in \cal K\\), all vertices of \\(X\\) have distinct colors.

</div>

Each color is used to represent a different process/agent/robot in the system. Note that a coloring consists of a labeling, but not the converse, as not all labeling functions respect the fact that vertices sharing an edge should not have the same color.


### Maps {#maps}

In order to express the communication and decision of the processes, the mapping of simplicial complexes via _carrier maps_ and _simplicial maps_ is used.

<div class="definition">

A **simplicial map** is a morphism between two simplicial complexes \\(\mu: \cal A \to \cal B\\), where \\(\mathcal{V}(\cal A)\\) is mapped to \\(\mathcal{V}(\cal B)\\), such that if \\(\\{s\_0,s\_1,...,s\_n\\}\\) is a simplex in \\(\cal A\\), then \\(\\{\mu(s\_0), \mu(s\_1), ..., u(s\_n)\\}\\) will be a simplex in \\(\cal B\\). Vertices are sent to vertices, and simplexes to simplexes.

</div>

The mapping of distinct vertices does not have to lead to distinct vertices, but when that happens the simplicial map is called _rigid_, and the image has the same dimension, i.e. \\(|\sigma| = |\psi(\sigma)|\\). A chromatic simplicial map will always be rigid, and equivalent to a _graph homomorphism_ in dimension 1, where there is no merger of vertices. Simplicial maps are approximations of continuous maps in the same way that simplicial complexes approximate topological spaces.

<div class="definition">

Let \\(\cal A\\) and \\(\cal B\\) be two simplicial complexes, a **carrier map** is a function \\(\Phi : \mathcal{A} \to 2^{\mathcal{B}}\\), where each simplex \\(\sigma \in \cal A\\) is mapped into a subcomplex of \\(\cal B\\), such that monotonicity is respected. That is, for all \\(\sigma, \tau \in \cal A\\), if \\(\sigma \subseteq \tau\\), then \\(\Phi(\sigma) \subseteq \Phi(\tau)\\). This can also be expressed as \\(\Phi(\sigma \cap \tau) \subseteq \Phi(\sigma) \cap \Phi(\tau)\\), meaning that the intersection of the mapping may add information, but will never lose.

</div>

The carrier map \\(\Phi\\) is called _strict_ if no information is added, that it, \\(\Phi(\sigma \cap \tau) = \Phi(\sigma) \cap \Phi(\tau)\\). It is considered _rigid_ if every simplex \\(\sigma \in \cal A\\) and its image \\(\Phi(\sigma)\\) are of the same dimension \\(d\\). A _chromatic carrier map_ will be _rigid_ and preserving colors, i.e. for every \\(\sigma \in \cal A\\), we have that \\(\mathcal{X}(\sigma) = \mathcal{X}(\Phi(\sigma))\\). The image of \\(\Phi(\cal A)\\) will be the union of all subcomplexes of \\(\cal B\\) that are accessed via \\(\Phi(\sigma)\\), with all \\(\sigma \in \cal A\\).

The carrier of \\(\tau\\) (or \\(Car(\tau, \Phi(\sigma))\\)) is the unique simplex \\(\sigma \in \cal A\\) of smallest dimension, such that \\(\tau \in \Phi(\sigma)\\), for each simplex \\(\tau \in \Phi(\cal A)\\). \\(\sigma\\) is the unique smallest simplex of \\(\cal A\\) that maps to the simplex \\(\tau\\) of the subcomplex obtained from \\(\Phi(\cal A)\\). Each \\(\tau\\) has its carrier.


### Constructions {#constructions}

We can construct different simplicial complexes and topological spaces from a given complex.

The _star complex_ \\(Star(\sigma, \cal K)\\) is defined from another complex \\(\cal K\\) and a simplex \\(\sigma\\). It corresponds to all facets of \\(\cal K\\) that contain \\(\sigma\\). Similarly, a topological space open in the complex is defined with the _open star_ \\(Star^O(\sigma, \cal K)\\), composed of the interiors of the simplexes containing \\(\sigma\\). We can define an open covering of \\(|\cal K|\\) with \\(Star^O(v)\_{v \in V(\cal K)}\\), where all vertices of \\(\cal K\\) are considered. If nothing but a simplex \\(\sigma\\)  is specified, the resulting topology will be the intersection of all open stars in its vertices, i.e. \\(St^O(\sigma) = \bigcap\_{v \in V(\sigma)} St^O(v)\\).

From the star operator, we can also define a a _link complex_ from \\(Link(\sigma, \cal K)\\), where the link corresponds to the subcomplex of \\(\cal K\\) with the simplexes in \\(St(\sigma, \cal K)\\) without intersections with \\(\sigma\\).
The _join operator_ \\(\cal A \* \cal B\\) works on two disjoint complexes \\(\cal A\\) and \\(\cal B\\), and provides a new complex with the union of the vertices of each and combines their simplexes.

We can see the mentioned constructions above in image <fig.smp_cpx_construct>.

<a id="figure--fig.smp-cpx-construct"></a>

{{< figure src="/ox-hugo/smp_cpx_construct.png" caption="<span class=\"figure-number\">Figure 1: </span>Star, open star, link and join constructions from the simplicial complexes \\(B\\) and \\(C\\)." >}}



<style>.csl-entry{text-indent: -1.5em; margin-left: 1.5em;}</style><div class="csl-bib-body">
</div>
