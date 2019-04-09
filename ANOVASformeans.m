a=1;
xx=[];
yy=[];
basegood=[];
tsgood=[];
tegood=[];
etsgood=[];
etegood=[];
basemin1good=[];
tsmin1good=[];
temin1good=[];
basebad=[];
tsbad=[];
tebad=[];
etsbad=[];
etebad=[];
basemin1bad=[];
tsmin1bad=[];
temin1bad=[];
recovbad=[];
recovgood=[];
recovmin1good=[];
recovmin1bad=[];
for z=good
        trainpercent=.30;
        micformants=Database.(subjects{z}).index.exp(:,3);
        fdbkformants=Database.(subjects{z}).index.exp(:,9);
        trainnumber=round(size(micformants,1)*trainpercent);
        repercent=.75;
        recovnumber=round(size(recovery,2)*repercent);
        micstart=micformants(1:trainnumber);
        micend=micformants(end-trainnumber+1:end);
        fdbkstart=fdbkformants(1:trainnumber);
        fdbkend=fdbkformants(end-trainnumber+1:end);
        basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,:);
        micbase=basehead(:,3);
        fdbkbase=basehead(:,9);
        basem=mean(micbase);
        %micbase=micbase-basem;
        %fdbkbase=fdbkbase-basem;
        %micstart=micstart-basem;
        %fdbkstart=fdbkstart-basem;
        %micend=micend-basem;
        %fdbkend=fdbkend-basem;
        error = micformants-fdbkformants;
        ermicstart=micformants(2:trainnumber+1);
        ermicend=micformants(end-trainnumber+1:end);
        erstart=error(1:trainnumber);
        erend=error(end-trainnumber:end-1);
        
        micrecov=Database.(subjects{z}).index.recov(1:recovnumber,3);
        fdbkrecov=Database.(subjects{z}).index.recov(1:recovnumber,9);
        
        [h,p]=corrcoef(micbase,fdbkbase,'rows','complete');
        basegood(a,1)=[h(1,2)];
        [h,p]=corrcoef(micstart,fdbkstart,'rows','complete');
        tsgood(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend,fdbkend,'rows','complete');
        tegood(a,1)=[h(1,2)];
        [h,p]=corrcoef(ermicstart,fdbkstart,'rows','complete');
        etsgood(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend,fdbkend,'rows','complete');
        etegood(a,1)=[h(1,2)];
        %ntontsgood(a,2)=p(1,2);
        [h,p]=corrcoef(micrecov,fdbkrecov,'rows','complete');
        recovgood(a,1)=[h(1,2)];
        
        [h,p]=corrcoef(micbase(2:end),fdbkbase(1:end-1),'rows','complete');
        basemin1good(a,1)=[h(1,2)];
        [h,p]=corrcoef(micstart(2:end),fdbkstart(1:end-1),'rows','complete');
        tsmin1good(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend(2:end),fdbkend(1:end-1),'rows','complete');
        temin1good(a,1)=[h(1,2)];
        [h,p]=corrcoef(micrecov(2:end),fdbkrecov(1:end-1),'rows','complete');
        recovmin1good(a,1)=[h(1,2)];
        
        %ntontsmin1good(a,2)=p(1,2);
        
        
        
        
        
        a=a+1;
end
a=1;
for z=bad
        micformants=Database.(subjects{z}).index.exp(:,3);
        fdbkformants=Database.(subjects{z}).index.exp(:,9);
        trainnumber=round(size(micformants,1)*trainpercent);
        
        recovnumber=round(size(recovery,2)*repercent);
        micstart=micformants(1:trainnumber);
        micend=micformants(end-trainnumber+1:end);
        fdbkstart=fdbkformants(1:trainnumber);
        fdbkend=fdbkformants(end-trainnumber+1:end);
        basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,:);
        micrecov=Database.(subjects{z}).index.recov(1:recovnumber,3);
        fdbkrecov=Database.(subjects{z}).index.recov(1:recovnumber,9)  ;      
        micbase=basehead(:,3);
        fdbkbase=basehead(:,9);
        basem=mean(micbase);
        %micbase=micbase-basem;
        %fdbkbase=fdbkbase-basem;
        %micstart=micstart-basem;
        %fdbkstart=fdbkstart-basem;
        %micend=micend-basem;
        %fdbkend=fdbkend-basem;
        error = micformants-fdbkformants;
        ermicstart=micformants(2:trainnumber+1);
        ermicend=micformants(end-trainnumber+1:end);
        erstart=error(1:trainnumber);
        erend=error(end-trainnumber:end-1);
        
        
        [h,p]=corrcoef(micbase,fdbkbase,'rows','complete');
        basebad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micstart,fdbkstart,'rows','complete');
        tsbad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend,fdbkend,'rows','complete');
        tebad(a,1)=[h(1,2)];
        [h,p]=corrcoef(ermicstart,fdbkstart,'rows','complete');
        etsbad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend,fdbkend,'rows','complete');
        etebad(a,1)=[h(1,2)];
        %ntontsbad(a,2)=p(1,2);
        [h,p]=corrcoef(micrecov,fdbkrecov,'rows','complete');
        recovbad(a,1)=[h(1,2)];
        
        
        [h,p]=corrcoef(micbase(2:end),fdbkbase(1:end-1),'rows','complete');
        basemin1bad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micstart(2:end),fdbkstart(1:end-1),'rows','complete');
        tsmin1bad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micend(2:end),fdbkend(1:end-1),'rows','complete');
        temin1bad(a,1)=[h(1,2)];
        [h,p]=corrcoef(micrecov(2:end),fdbkrecov(1:end-1),'rows','complete');
        recovmin1bad(a,1)=[h(1,2)];
        %ntontsmin1bad(a,2)=p(1,2);
        
        
        
        
        
        a=a+1;
end



xx=[tsbad,ones(badsize,1),3*ones(badsize,1);tsgood,(ones(goodsize,1)*2),3*ones(goodsize,1)];
xx=[xx;tebad,ones(badsize,1),(ones(badsize,1)*4);tegood,(ones(goodsize,1)*2),(ones(goodsize,1)*4)];
xx=[xx;basebad,ones(badsize,1),(ones(badsize,1)*5);basegood,(ones(goodsize,1)*2),(ones(goodsize,1)*5)];
xx=[xx;recovbad,ones(badsize,1),(ones(badsize,1)*6);recovgood,(ones(goodsize,1)*2),(ones(goodsize,1)*6)];

yy=[tsmin1bad,ones(badsize,1),3*ones(badsize,1);tsmin1good,(ones(goodsize,1)*2),3*ones(goodsize,1)];
yy=[yy;temin1bad,ones(badsize,1),(ones(badsize,1)*4);temin1good,(ones(goodsize,1)*2),(ones(goodsize,1)*4)];
yy=[yy;basemin1bad,ones(badsize,1),(ones(badsize,1)*5);basemin1good,(ones(goodsize,1)*2),(ones(goodsize,1)*5)];
yy=[yy;recovmin1bad,ones(badsize,1),(ones(badsize,1)*6);recovmin1good,(ones(goodsize,1)*2),(ones(goodsize,1)*6)];




nanmeanbad=[nanmean(basemin1bad),nanmean(tsmin1bad),nanmean(temin1bad),nanmean(recovmin1bad)];
stderbad=[std(basemin1bad)/sqrt(15),std(tsmin1bad)/sqrt(15),std(temin1bad)/sqrt(15),std(recovmin1bad)/sqrt(15)];

nanmeangood=[nanmean(basemin1good),nanmean(tsmin1good),nanmean(temin1good),nanmean(recovmin1good)];
stdergood=[std(basemin1good)/sqrt(16),std(tsmin1good)/sqrt(16),std(temin1good)/sqrt(16),std(recovmin1good)/sqrt(16)];

figure;
hold on;
errorbar(nanmeanbad,stderbad,'.k');
errorbar(nanmeangood,stdergood,'.c');
