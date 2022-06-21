import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import sys

output = sys.argv[1]


def plog(p):
    if p == 0:
        return 0
    else:
        return p * np.log2(p)

def w(y, x, p):
    if y == x:
        return 1 - p
    else:
        return p

def bad_prob(y1, y2, u1, p):
    return 0.5 * sum(w(y2, u2, p) * w(y1, (u1 + u2) % 2, p) for u2 in [0, 1])

def bad_cap(p):
    total = 0
    for y1 in [0, 1]:
        for y2 in [0, 1]:
            for u1 in [0, 1]:
                prob_y_u = bad_prob(y1, y2, u1, p)
                prob_y_0 = bad_prob(y1, y2, 0, p)
                prob_y_1 = bad_prob(y1, y2, 1, p)
                if prob_y_u > 0:
                    total += 0.5 * prob_y_u * np.log2(2 * prob_y_u / (prob_y_0 + prob_y_1))
    return total

def good_prob(y1, y2, u1, u2, p):
    return w(y2, u2, p) * w(y1, (u1 + u2) % 2, p)

def good_cap(p, u1=0):
    total = 0
    for y1 in [0, 1]:
        for y2 in [0, 1]:
            for u2 in [0, 1]:
                prob_y_u = good_prob(y1, y2, u1, u2, p)
                prob_y_0 = good_prob(y1, y2, u1, 0, p)
                prob_y_1 = good_prob(y1, y2, u1, 1, p)
                if prob_y_u > 0:
                    total += 0.5 * prob_y_u * np.log2(2 * prob_y_u / (prob_y_0 + prob_y_1))
    return total

def default_cap(p):
    return 1 + plog(p) + plog(1 - p)


probs = np.linspace(0, 1, 10000)

sns.set_style("ticks")

plt.figure(figsize=(4, 2.75))
plt.plot(probs, [default_cap(p) for p in probs], label="Canal initial")
plt.plot(probs, [bad_cap(p) for p in probs], label="Mauvais canal", linestyle="--")
plt.plot(probs, [good_cap(p) for p in probs], label="Bon canal", linestyle="-.")
plt.xlabel("Probabilité d'erreur")
plt.ylabel("Capacité")
plt.legend(frameon=False)
sns.despine()
plt.tight_layout()
plt.savefig(output)





