---
title: "Metric Steiner Tree"
date: 2018-12-08
slug: "metric-steiner-tree"
tags: ["graph theory", "steiner tree", "2-approximation",]
categories: ["approximation"]
header_image: "posts/metric-steiner-tree/img/constellation.png"
---


The Metric Steiner Tree
=======================

## Motivation

A Steiner Tree is an optimization algorithm for finding asubtree spanning so called terminal vertices.
Terminal vertices are the nodes in a network which must spanned by the MST.
This problems arise in telecommunication networks, VSLI chip design.

This article describes an approximation algorithm for the Metric Steiner Tree Problem


## Introduction

The Steiner Tree Problem (STP) is a graph $G = (V, E)$ along with terminals $R \subset V$.
$V$ is splitted into two sets $R$ required terminal vertices and $S$ optional Steiner vertices.
A subgraph of $G$ is a feasible solution if it spans all vertices of $T$.
The objective is to minimize the cost. 

The Metric Steiner Tree Problem (MSTP) is a specialization of the vanilla Steiner Tree $X = R \cup S$ along with a non-negative distance function $d : X \times X \mapsto \mathbb{R}_{\geq 0}$ for edges.
A metric have two properties: 
$$
\begin{align}
    \forall x, y \in X &: d(x, y) = d(y, x) \nonumber \newline
    \forall x, y, z \in X &: d(x, y) \leq d(x, z) + d(z, y)  \nonumber
\end{align}
$$

This gives an undirected graph $G = (V, E)$ with non-negative edge costs. 

Problem: Find a minimal cost tree $T$, which contains all terminal vertives, and possibly some of the optional points, such that the cost
$$
\begin{align}
	C_d (T) := \sum\_{(u,v) \in E} d(u, v) \nonumber
\end{align}
$$
of the tree is minimized. 


### Non-optimal spanning trees
Possibility: Find a Minimal Spanning Tree (MST) on the terminal vertices,

![](img/k4-mst.pdf) 

but this is not optimal!


## Towards an approximation

In this section we show that the approximation bound for MSTP is not greater than for STP.

Define $G’ = (V, E’$) from $G$ as follows: $G’$ is a complete graph and $e’_{ij}$ is the length of the shortets path in G for vertices $i$ to $j$.

$$
\begin{align}
    OPT(G’) \leq OPT(G)
\end{align}
$$

Assume we have a heuristic $H$ for $G’$. 
We get a solution for $G$ by replacing each edge of the MST in $G$ with its corresponding shortest path in $G$. Resolve cycles by removing appropriate edges. Hence
$$
\begin{align}
    C^H(G) \leq C^H(G’)
\end{align}
$$
and therefore by (1) and (2)
$$
\begin{align}
    \frac{C^H(G’)}{OPT(G’)} \leq \alpha  \implies  \frac{C^H(G)}{OPT(G)} \leq \alpha
\end{align}
$$

Thus, each approximation algorithm for the MSTP with bound $\alpha$ gives an algorithm with bound α for the General Steiner Tree.

## An approximation algorithm

We analyse the worst-case behaviour on the complete graph $G’$. 
Consider a Steiner Tree with optimal cost $OPT$ for $G’$. 

Find a MST on the termial vertices.

![](img/mst.pdf) 

Double each edge

![](imng/double-the-edges.pdf) 

Construct a hamiltonian cycle by short cutting steiner vertices previously visited. 
Get an hamiltonian path by removing one ??? the edges. 

![](img/mst-st.pdf)

We have fo:weund an MST on the terminal vertices.

Each vertex has even degree. 
In general eulerian cycles exists $\Longleftrightarrow$ each vertex has even degree. 
Therefore an eulearian cycle exists. 

Eulerian cycle: Total cost equals $2 \cdot OPT$ by edge double. 
A hamiltonian path does not increase the cost, because of the triangle inequality and removing edges. 
The resulting MST on the terminal vertices cost $\leq 2 \cdot OPT$ and the bound is tight.
