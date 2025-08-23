from sage.all import *
from sage.graphs.independent_sets import IndependentSets
from collections import defaultdict
def independence_polynomial(graph):
    counts = {}
    for indep_set in IndependentSets(graph):
        k = len(indep_set)
        counts[k] = counts.get(k, 0) + 1
    R.<x> = PolynomialRing(QQ)
    poly = sum(c * x^k for k, c in sorted(counts.items()))
    return poly
def a(n):
    all_graphs = list(graphs(n))
    poly_to_graphs = defaultdict(list)
    for G in all_graphs:
        poly = independence_polynomial(G)
        poly_to_graphs[poly].append(G)
    count = 0
    for poly, graph_list in poly_to_graphs.items():
        if len(graph_list) == 1:
            count += 1
    return count
