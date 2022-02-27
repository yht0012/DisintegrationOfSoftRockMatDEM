function newgId= mixGroupId(d)
%MIXGROUPID
gId=d.GROUP.groupId;
uId=unique(gId);
uId2=uId-min(uId)+1;
seed=randperm(length(uId2));

gId2=gId-min(gId)+1;
uIdList=zeros(max(uId),1);
uIdList(uId2)=uId(seed);
newgId=uIdList(gId2);
d.data.groupId=newgId;
end

