import dd.autoref as _bdd

def runbdd(pyvar,pyformula,pyassignment):
    bdd = _bdd.BDD()
    eval(pyvar)
    eval(pyformula)
    assignment = eval(pyassignment)
    if not assignment:
        return 0
    else:
        return assignment