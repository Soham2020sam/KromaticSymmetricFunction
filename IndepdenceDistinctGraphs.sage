from sage.all import *
from sage.graphs.independent_sets import IndependentSets

def independence_polynomial(graph):
    counts = {}
    for indep_set in IndependentSets(graph):
        k = len(indep_set)
        counts[k] = counts.get(k, 0) + 1
    R.<x> = PolynomialRing(QQ)
    poly = sum(c * x^k for k, c in sorted(counts.items()))
    return poly

# Set number of vertices
n = 7

# Generate all graphs with n vertices
all_graphs = graphs(n)

# Dictionary: polynomial -> list of graphs with that polynomial
poly_to_graphs = {}

for G in all_graphs:
    poly = independence_polynomial(G)
    if poly not in poly_to_graphs:
        poly_to_graphs[poly] = []
    poly_to_graphs[poly].append(G)

count = 0
# Show only graphs with unique independence polynomials
for poly, graph_list in poly_to_graphs.items():
    if len(graph_list) == 1:
        print(f"Unique polynomial: {poly}")
        show(graph_list[0])
        count += 1

print(count)
