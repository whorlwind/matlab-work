    difference=nan(31,1);
    shifted=nan(31,1);
    for z=[good,bad]
    basehead=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==4,3);
    mhead=nanmean(basehead);
    basehid=Database.(subjects{z}).index.base(Database.(subjects{z}).index.base(:,8)==2,3);
    mhid=nanmean(basehid);
    difference(z,1)=mhead-mhid;
    shifted(z,1)=nanmean(Database.(subjects{z}).index.exp(:,3))-nanmean(Database.(subjects{z}).index.exp(:,10));
    end
    