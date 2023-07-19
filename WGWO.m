function [BestPos,Convergence_curve]=WGWO(SearchAgents_no,MaxFEs,lb,ub,dim,fobj)
empty_individual.Positions=[];
empty_individual.fitness=[];
pop=repmat(empty_individual,SearchAgents_no,1);
it=1;
Convergence_curve=[];
FEs=0;
X=initialization(SearchAgents_no,dim,ub,lb);
for i=1:SearchAgents_no
    pop(i).Positions=X(i,:);
end
for i=1:SearchAgents_no
    Flag4ub=pop(i).Positions>ub;
    Flag4lb=pop(i).Positions<lb;
    pop(i).Positions=(pop(i).Positions.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
    if FEs<MaxFEs
        FEs=FEs+1;
        pop(i).fitness=fobj(pop(i).Positions);
    else
        break;
    end
end
[~, SortOrder]=sort([pop.fitness]);
pop=pop(SortOrder);
while  FEs < MaxFEs
    a=2-FEs*((2)/MaxFEs);
    for i=1:SearchAgents_no
        for j=1:dim   
            r1=rand();
            r2=rand();
            A1=2*a*r1-a;
            C1=2*r2;
            D_alpha=abs(C1*pop(1).Positions(j)-pop(i).Positions(j));
            X1=pop(1).Positions(j)-A1*D_alpha;
            r1=rand();
            r2=rand();
            A2=2*a*r1-a;
            C2=2*r2;
            D_beta=abs(C2*pop(2).Positions(j)-pop(i).Positions(j));
            X2=pop(2).Positions(j)-A2*D_beta;
            r1=rand();
            r2=rand();
            A3=2*a*r1-a;
            C3=2*r2;
            D_delta=abs(C3*pop(3).Positions(j)-pop(i).Positions(j));
            X3=pop(3).Positions(j)-A3*D_delta;
            newpop(i).Positions(j)=(X1+X2+X3)/3;
        end
        Flag4ub=newpop(i).Positions>ub;
        Flag4lb=newpop(i).Positions<lb;
        newpop(i).Positions=(newpop(i).Positions.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
        if FEs<MaxFEs
            FEs=FEs+1;
            newpop(i).fitness=fobj(newpop(i).Positions);
            if newpop(i).fitness<pop(i).fitness
                pop(i)=newpop(i);
            end
        else
            break;
        end
    end
    [~, SortOrder]=sort([pop.fitness]);
    pop=pop(SortOrder);
    Bestsolution=pop(1);
    BestScore=Bestsolution.fitness;
    BestPos=Bestsolution.Positions;
    
    %% CM
%     The detailed code will be made public after the paper is published.
    %% CM end
    [~, SortOrder]=sort([pop.fitness]);
    pop=pop(SortOrder);
    Bestsolution=pop(1);
    BestScore=Bestsolution.fitness;
    BestPos=Bestsolution.Positions;
    Convergence_curve(it)=BestScore;
    it=it+1;
end
end



