function [pyvar,pyformula] = buildBDD(model,dels)
    nrxn=size(model.rxns,1);
    ngen=size(model.genes,1);
    var="'"+model.genes{1}+"'";
    for i=2:ngen
        var=var+", '"+model.genes{i}+"'";
    end
    pyvar="bdd.declare("+var+")";
    if dels(1)==1
        formula="("+model.grs{1}+")";
    elseif dels(1)==0
        formula="! ("+model.grs{1}+")";
    end
    for j=2:nrxn
        if isempty(model.grs{j})
            continue;
        end
        if dels(1)==1
            formula=formula+" & ("+model.grs{j}+")";
        elseif dels(1)==0
            formula=formula+" & ! ("+model.grs{j}+")";
        end
    end
    pyformula="u = bdd.add_expr(r'"+formula+"')";
end

%{
import dd.autoref as _bdd
bdd = _bdd.BDD()
bdd.declare('x', 'y', 'z')
u = bdd.add_expr()
assignment = bdd.pick(u)
%}