function [model1,grexist] = changeBool(model)
    model1=model;
    ngrs=size(model.grRules,1);
    model1.grs=cell(ngrs,1);
    grexist=zeros(ngrs,1);
    for i=1:ngrs
       gr=model.grRules{i,1};
       if isempty(gr)
           grexist(i,1)=1;
       end
       gr=replace(gr,"and","&");
       gr=replace(gr,"or","|");
       model1.grs{i,1}=gr;
    end
end
