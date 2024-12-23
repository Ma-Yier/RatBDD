%------------------------------------------------------------------------------ecoli_core---------------------------------------------------------------------------------------
global grexist;
global nReas;
global pyassignment
nReas=95;
pyassignment="bdd.pick(u)";

load('e_coli_core.mat');
id_biomass=25;
id_carbon=52;
id_oxygen=60;
[model,grexist]=changeBool(e_coli_core);
model.lb(id_biomass)=0.05;
model.lb(id_carbon)=-15;
model.lb(id_oxygen)=-20;
model.ub(id_carbon)=0;
model.ub(id_oxygen)=0;
opt=optimizeCbModel(model);
TMGR=opt.f;
max_loop=1000;
stat=zeros(72,4);
%pyenv(Version="C:\Users\Ma\.conda\envs\bdd\python.exe",ExecutionMode="OutOfProcess");
if count(py.sys.path,pwd) == 0
    insert(py.sys.path,int32(0),pwd);
end

for i=1:72
    if i~=25 && i~=1 && i~=5
        tStart=tic;
        [new_model,id_target,TMPR] = introExchange(model,id_biomass,[id_carbon,id_oxygen],i);
        if TMPR>0
            [x_target,alpha] = RatBDD(new_model,id_biomass,id_target,max_loop,20*TMPR/max_loop);
            stat(i,:)=[x_target,alpha,TMPR,toc(tStart)];
        else
            x_target=0;
            alpha=0;
            stat(i,:)=[x_target,alpha,TMPR,toc(tStart)];
        end
    end
end
%fprintf('success e_coli_core ------------------ \nsuccess:%f \n',numel(find(stat(:,1)>0.001)));
%filename=sprintf('results/e_coli_core_raioGene_1_date_%s',datetime('now','TimeZone','Asia/Tokyo','Format','yyyyMMdd'));
%save(filename);
%------------------------------------------------------------------------------ecoli_core---------------------------------------------------------------------------------------
