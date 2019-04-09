%directory='c:\Users\zephyr\Desktop\sazzad\'; %Directory that database file is located in
directory='/Users/sml/Desktop/chris/'; %Directory that database file is located in
datafile=[directory,'ParticipantData3.mat'];
% bad=[1,12,16,4,26,3,9,21]; %without quicklearners
% good=[20,24,28,25,22,8,2,29];
% bad=[1,12,16,4,15,26,19,3,9,21]; %without quicklearners
% good=[20,24,28,25,11,22,8,30,2,29];

% good=[2,3,8,10,20,22,24,25,28,29];
% bad=[1,4,9,11,13,15,16,21,26,30];
% jkl=[4,21,11,13,24,10,3,23,17,12,8,20,16,14,2,9,19]
load(datafile);
subjects=fieldnames(Database);

Database.EC.index.recov(:,6)=Database.EC.index.recov(:,6)-5;
Database.KL.index.recov(:,6)=Database.KL.index.recov(:,6)-5;
Database.JP.index.recov(:,6)=Database.JP.index.recov(:,6)-1;
Database.FM.index.recov(:,6)=Database.FM.index.recov(:,6)-6;
b=1;
baseblocks=[1:6];
trainblocks=[7:21];
recovblocks=[22:26];
allblocks=[1:26];

DBsubjectxblock=nan(26,1);
DBsubjectxblockfb=nan(26,1);
a=1;
for z=good
    allbase=Database.(subjects{z}).index.base;
    alltrain=Database.(subjects{z}).index.exp;
    allrecover=Database.(subjects{z}).index.recov;
    allbasehead=allbase(allbase(:,8)==4,:);
    allsounds=[allbasehead;alltrain;allrecover];
    %dbchoice=DB2.(subjects{z}).mnormsnds;
    DBsoundxblock=nan(26,12);
    DBsoundxblockfb=nan(26,12);
    basemean=mean(allbasehead(:,3));
    
    for i = allblocks
        blocksounds=[allsounds(allsounds(:,6)==i,1)]';
        b=1;
        for j=blocksounds
           
                DBsoundxblock(i,b)=allsounds(allsounds(:,1)==j,3);
                DBsoundxblockfb(i,b)=allsounds(allsounds(:,1)==j,10);
                       b=b+1;
        end
    end
    for i=allblocks
        DBsubjectxblock(i,a)=nanmean([DBsoundxblock(i,:)-basemean]);
        DBsubjectxblockfb(i,a)=nanmean([DBsoundxblockfb(i,:)-basemean]);
    end
    a=a+1;
end
base=DBsubjectxblock(baseblocks,1:4)';
basef=DBsubjectxblockfb(baseblocks,1:4)';
train=[DBsubjectxblock(trainblocks,:)]';
trainf=[DBsubjectxblockfb(trainblocks,:)]';
recov=[DBsubjectxblock(recovblocks,:)]';
figure;
hold on;
Patchplot(2,basef,'r',trainf,'r');
Patchplot(3,base,'b',train,'b',recov,'b');

% 
% figure
% hold on
% errorbar(baseblocks,nanmean(DBsubjectxblock(baseblocks,:),2),std(DBsubjectxblock(baseblocks,:),0,2)./sqrt(10),'bo')
% errorbar(trainblocks,nanmean(DBsubjectxblock(trainblocks,:),2),std(DBsubjectxblock(trainblocks,:),0,2)./sqrt(10),'go')
% errorbar(recovblocks,nanmean(DBsubjectxblock(recovblocks,:),2),std(DBsubjectxblock(recovblocks,:),0,2)./sqrt(10),'ro')
