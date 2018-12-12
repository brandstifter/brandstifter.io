---
title: "Metric Steiner Tree"
date: 2018-12-08
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
This problems arise in telecommunication networks and VSLI chip design.

This article describes an 2-approximation algorithm for the Metric Steiner Tree Problem.


## Introduction

The Steiner Tree Problem (STP) is a graph $G = (V, E)$.
$V$ is splitted into two sets $R$ required terminal vertices and $S$ optional Steiner vertices.
A subgraph of $G$ is a feasible solution if it spans all vertices of $T$.
The objective is to minimize the cost. 

The Metric Steiner Tree Problem (MSTP) is a specialization of the vanilla Steiner Tree $X = T \cup S$ along with a non-negative distance function $d : X \times X \mapsto \mathbb{R}_{\geq 0}$ for edges.
A metric have two properties: 
$$
\begin{align}
    \forall x, y \in X &: d(x, y) = d(y, x) \nonumber \newline
    \forall x, y, z \in X &: d(x, y) \leq d(x, z) + d(z, y)  \nonumber
\end{align}
$$

This gives an undirected graph $G = (V, E)$ with non-negative edge costs. 

Problem: Find a minimal cost tree $T_m$, which contains all terminal vertives, and possibly some of the optional points, such that the cost
$$
\begin{align}
	C_d (T_m) := \sum\_{(u,v) \in E} d(u, v) \nonumber
\end{align}
$$
of the tree is minimized. 


### Non-optimal spanning trees
Possibility: Find a Minimal Spanning Tree (MST) on the terminal vertices,

![](img/k4-mst.pdf) 

but this is not optimal!
Next we look for an approximation for the MSTP.

## Towards an approximation

In this section we show that the approximation bound for MSTP is not greater than for STP.

Define $G’ = (V, E’$) from $G$ as follows: $G’$ is a complete graph and $e’_{ij}$ is the length of the shortets path in G for vertices $i$ to $j$.
The paths in $G'$ cannot be longer than $G$, therefore
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

Thus, each approximation algorithm for the STP with bound $\alpha$ gives an algorithm with bound $\alpha$ for the MSTP.

## An approximation algorithm

Consider a Steiner Tree with optimal cost $OPT$ for $G’$. 

Find a MST on the termial vertices.

![](img/mst.pdf) 

To ensure an even degree of all vertices, we double each edge.
A graph with even degree have an eulerian cycle.
The cost of an eulerian cycle equals $2 \cdot OPT$ by edge double. 

![](img/double-the-edges.pdf) 

Construct a hamiltonian cycle by short cutting steiner vertices previously visited. 

![](img/mst-st.pdf)

To get a hamiltonian path remove one edge of the cycle.
We have found an MST on the terminal vertices.


A hamiltonian path does not increase the cost, because of the triangle inequality and removing edges. 
The resulting MST on the terminal vertices cost $\leq 2 \cdot OPT$ and the bound is tight.

Special thanks to Hans Kellerer (University of Graz) for teaching.
