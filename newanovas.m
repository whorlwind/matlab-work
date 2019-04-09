goodsize=size(good,2);
badsize=size(bad,2);
a=1;


for z=[good]
    
        trainpercent=.30;
        micformants=Database.(subjects{z}).index.exp(:,3);
        trainnumber=round(size(micformants,1)*trainpercent);
        repercent=.7;
        basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,:);
        micbase=basehead(:,3);
        basem=mean(micbase);
        micformants=micformants-basem;
        micbase=micbase-basem;
        micrecov=Database.(subjects{z}).index.recov(:,3);
        recovnumber=round(size(micrecov,1)*repercent);
        recovstart=micrecov(1:recovnumber)-basem;
        micstart=micformants(1:trainnumber);
        micend=micformants(end-trainnumber+1:end);
        micstartm=mean(micstart);
        micendm=mean(micend);
        recovstartm=mean(recovstart);
        goodzz(a,:)=[micstartm,micendm,recovstartm];
        a=a+1;
        
        
end
a=1;
for z=bad
        micformants=Database.(subjects{z}).index.exp(:,3);
        trainnumber=round(size(micformants,1)*trainpercent);
        basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,:);
        micbase=basehead(:,3);
        basem=mean(micbase);
        micformants=micformants-basem;
        micbase=micbase-basem;
        micrecov=Database.(subjects{z}).index.recov(:,3);
        recovnumber=round(size(micrecov,1)*repercent);
        recovstart=micrecov(1:recovnumber)-basem;
        micstart=micformants(1:trainnumber);
        micend=micformants(end-trainnumber+1:end);
        micstartm=mean(micstart);
        micendm=mean(micend);
        recovstartm=mean(recovstart);
        badzz(a,:)=[micstartm,micendm,recovstartm];
        a=a+1;
end

allzz=[goodzz;badzz];
%xx=[zeros(goodsize,1),ones(goodsize,1).*1,ones(goodsize,1).*3];
xx=[goodzz(:,1),ones(goodsize,1).*1,ones(goodsize,1).*4];
xx=[xx;goodzz(:,2),ones(goodsize,1).*1,ones(goodsize,1).*5];
xx=[xx;goodzz(:,3),ones(goodsize,1).*1,ones(goodsize,1).*6];
%xx=[xx;zeros(badsize,1),ones(badsize,1).*2,ones(badsize,1).*3];
xx=[xx;badzz(:,1),ones(badsize,1).*2,ones(badsize,1).*4];
xx=[xx;badzz(:,2),ones(badsize,1).*2,ones(badsize,1).*5];
xx=[xx;badzz(:,3),ones(badsize,1).*2,ones(badsize,1).*6];

yy=[zeros(goodsize+badsize,1),ones(goodsize+badsize,1).*1,ones(goodsize+badsize,1).*3];
yy=[yy;allzz(:,1),ones(goodsize+badsize,1).*1,ones(goodsize+badsize,1).*4];
yy=[yy;allzz(:,2),ones(goodsize+badsize,1).*1,ones(goodsize+badsize,1).*5];
yy=[yy;allzz(:,3),ones(goodsize+badsize,1).*1,ones(goodsize+badsize,1).*6];










novas=zeros(3);
a=1;
for z= [good,bad]
        trainpercent=.3;
        micformants=Database.(subjects{z}).index.exp(:,3);
        trainnumber=round(size(micformants,1)*trainpercent);
        basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,:);
        micbase=basehead(:,3);
        ts=micformants(1:trainnumber);
        
        te=micformants(end-trainnumber+1:end);
        %ab=[micbase,(1.*ones(size(micbase,1),1));ts,(2.*ones(size(ts,1),1)); te,(3.*ones(size(te,1),1))];
        ab=[micbase,(1.*ones(size(micbase,1),1));ts,(2.*ones(size(ts,1),1)); te,(3.*ones(size(te,1),1))];
        [x,x,e]=anova1(ab(:,1),ab(:,2),'off');
        j=multcompare(e,'alpha',.01,'display','off');
        if not(j(1,3)<0<j(1,5)) novas(a,2)=j(1,4);
        end
        if not(j(2,3)<0<j(2,5)) novas(a,3)=j(2,4);
        end
        if not(j(3,3)<0<j(3,5)) novas(a,4)=j(3,4);
        end
        
        novas(a,6)=z;
        a=a+1;
end
novas(1:goodsize,1)=1;
novas(goodsize+1:goodsize+badsize,1)=-2;
novas(goodsize+badsize+1:goodsize+badsize+othersize,1)=-1;
