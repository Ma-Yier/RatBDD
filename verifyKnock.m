function [XX,var_x] = verifyKnock(input_model,input_x,id_biomass,id_target,TMGR,min_bound)
%UNTITLED6 此处显示有关此函数的摘要
% 
global grexist;
global nReas;
XX=0;

model=input_model;
var_x=input_x;
var_x(abs(var_x)<0.0000001)=0;
if size(var_x,1)>nReas
    var_x=var_x+[grexist;1];
else
    var_x=var_x+grexist;
model.lb(var_x==0)=0;
model.ub(var_x==0)=0;
model.lb(id_biomass)=0;

% Cplex
[X,FVAL,EXITFLAG]=cplexlp(-model.c,[],[],model.S,model.b,model.lb,model.ub);

% Gurobi
%OPTIONS.Display='off';
%[X,FVAL,EXITFLAG]=LINPROG(-model.c,[],[],model.S,model.b,model.lb,model.ub,OPTIONS);

if EXITFLAG==1 && (-1)*FVAL>TMGR*min_bound
   XX=X(id_target);
   return;
end

% end funtion
end

