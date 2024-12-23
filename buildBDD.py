import dd.autoref as _bdd
from pathlib import Path
from cobra.io import read_sbml_model
import logging
import time

mini_fbc2_path = "e_coli_core.xml"
model = read_sbml_model(mini_fbc2_path)

num_reactions = len(model.reactions)
num_genes = len(model.genes)
bdd = _bdd.BDD()
for i in range(num_genes):
    bdd.add_var(model.genes[i].id)

grRules = []
for j in range(num_reactions):
    if model.reactions[j].gene_reaction_rule == "":
        continue
    grRule = model.reactions[j].gene_reaction_rule
    grRules.append("(" + grRule.replace('and', '&').replace('or', '|') + ")")

ultraFormula = " & ".join(grRules)
print(ultraFormula)

s = time.time()
u = bdd.add_expr(ultraFormula)
bdd.pick(u)
e = time.time()
print(f"{e-s} seconds")

print("sd")