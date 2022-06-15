import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

probs = np.linspace(0, 1)

def plog(p):
    if p == 0:
        return 0
    else:
        return p * np.log2(p)

capacites = np.array([1 + plog(p) + plog(1 - p) for p in probs])

sns.set_style("ticks")
plt.figure(figsize=(3, 2.25))
plt.plot(probs, capacites)
plt.xlabel("Probabilité d'erreur")
plt.ylabel("Capacité")
sns.despine()
plt.tight_layout()
plt.savefig("../capacite_canal.pdf")





