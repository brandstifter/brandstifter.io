---
title: "Metric Steiner Tree"
date: 2018-12-08
modified: 2018-12-23
slug: "metric-steiner-tree"
tags: ["steiner tree", "euler cycle", "hamiltonian path", "2-approximation", "measure theory"]
categories: ["approximation", "graph theory"]
header_image: "posts/metric-steiner-tree/img/constellation.png"
---


The Metric Steiner Tree
=======================

## Motivation

A Steiner Tree is an optimization algorithm for finding a subtree spanning so called terminal vertices.
Terminal vertices are the nodes in a network which must spanned by the MST.
This problems arise in railway networks, telecommunication networks and VSLI chip design.

This article describes an 2-approximation algorithm for the Metric Steiner Tree Problem.
Note that 2-approximation guarantees a solution $2 \cdot OPT$ on worst case situations.
If you look for the best approximation, the best known algorithm is a $ 96/95 $-approximation.

## Introduction

The Steiner Tree Problem (STP) is a graph $G = (V,E)$.
$V$ is splitted into two sets $R$ of required terminal vertices and $S$ of optional Steiner vertices.
A subgraph of $G$ is a feasible solution if it spans all vertices of $R$.
The objective is to minimize the cost. 

The Metric Steiner Tree Problem (MSTP) is a specialization of the vanilla Steiner Tree $X = R \cup S$ along with a non-negative distance function $d : X \times X \mapsto \mathbb{R}_{\geq 0}$ for edges.
A metric have two properties: 
$$
\begin{align}
    \forall x,y \in X &: d(x,y) = d(y,x) \nonumber \newline
    \forall x,y,z \in X &: d(x,y) \leq d(x,z) + d(z,y)  \nonumber
\end{align}
$$

This gives an undirected graph $G = (V,E)$ with non-negative edge costs. 

Problem: Find a minimal cost tree $T$, which contains all terminal vertives, and possibly some of the optional points, such that the cost $C$ with metric $d$
$$
\begin{align}
	C_d (T) := \sum\_{(u,v) \in E} d(u, v) \nonumber
\end{align}
$$
of the tree is minimized. 


### Non-optimal spanning trees

Let $G$ be a $K_4$ graph.
![](img/k4-mst.pdf)

Find a Minimal Spanning Tree (MST) with Kruskal on the terminal vertices.
The algorithm come up with this solution:
![](img/k4-mst-kruskal.pdf)

But this is not optimal!
The STP would generate a better MST for that example, since ST can also consider the option Steiner vertices in the calculation.
Next we look for a simple and easy to implement approximation for the STP.

## Towards an approximation

In this section we show that the approximation bound for MSTP is not greater than for STP.

Define $G’ = (V, E’$) from $G$ as follows: $G’$ is a complete graph and $e’_{ij}$ is the length of the shortets path in $G$ for vertices $i$ to $j$.

The Steiner Tree algorithm would came up with this graph $G'$
![](img/k4-mst-Gprime.pdf)

The paths in $G'$ cannot be longer than $G$, therefore
$$
\begin{align}
    OPT(G’) \leq OPT(G)
\end{align}
$$

Note that the graph is still connected.

Now we assume to have a heuristic $H$ for $G’$. 
We get a solution for $G$ by replacing each edge of the MST in $G$ with its corresponding shortest path in $G'$. 
Resolve cycles by removing appropriate edges.
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

Thus, each approximation algorithm for the general STP with bound $\alpha$ gives an algorithm with bound $\alpha$ for the specific MSTP.
Why the bound is 2 is illustrated in the next section.

## An approximation algorithm

Consider a Steiner Tree with optimal cost $OPT$ for $G’$. 

Find a MST on the termial vertices.

![](img/mst.pdf) 

To ensure an even degree of all vertices, we double each edge.
A graph with even degree have an eulerian cycle.
The cost of the eulerian cycle equals $2 \cdot OPT$ by edge double. 

![](img/double-the-edges.pdf) 

Construct a hamiltonian cycle by short cutting steiner vertices previously visited. 
![](img/mst-st.pdf)
If the question was how to extend a railway network in a cheap manner for peripheral stations, this is an answer.

To get a hamiltonian path remove one edge of the cycle.
We have found an MST on the terminal vertices.
A hamiltonian path does not increase the cost, because of the triangle inequality and removing edges. 
The resulting MST on the terminal vertices cost $\leq 2 \cdot OPT$ and the bound is tight.

Looking back on $K_4$ we have to calculate the solution from $G'$ back to the original $G$ instance.  
![](img/k4-mst-2-approx.pdf)

By including the optional Steiner vertice we have found a better MST compared to the Kruskal algorithm. 

Special thanks to Prof. Hans Kellerer (University of Graz) for teaching.
