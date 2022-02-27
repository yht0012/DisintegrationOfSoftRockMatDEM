function d=setGroupId(d)
d.GROUP.groupId(:)=0;
BNames={'lefB';'rigB';'froB';'bacB';'botB';'topB'};
PNames={'lefPlaten';'rigPlaten';'froPlaten';'bacPlaten';'botPlaten';'topPlaten'};
BPNames=cat(1,BNames,PNames);
fNames=fieldnames(d.GROUP);
gI=0;
for i=1:length(fNames)
    fName=fNames{i};
    if length(fName)<5||~strcmp(fName(1:5),'group')
        if ~mfs.isExist(BPNames,fName)
            gI=gI+1;
            gId=d.GROUP.(fName);
            d.GROUP.groupId(gId)=gI;
        end
    end
end
boGroupId=[d.GROUP.lefB;d.GROUP.rigB;d.GROUP.froB;d.GROUP.bacB;d.GROUP.botB;d.GROUP.topB];
d.GROUP.groupId(boGroupId)=-1;
boGroupId=[d.GROUP.lefPlaten;d.GROUP.rigPlaten;d.GROUP.froPlaten;d.GROUP.bacPlaten;d.GROUP.botPlaten;d.GROUP.topPlaten];
d.GROUP.groupId(boGroupId)=1;
d.setData();
end