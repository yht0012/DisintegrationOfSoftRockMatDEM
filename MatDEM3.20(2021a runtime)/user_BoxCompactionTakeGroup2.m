%set the material of the model
clear
load('TempModel/BoxCompactionShock1.mat');
B.setUIoutput();%set the output
d=B.d;
d.calculateData();%calculate data
d.mo.setGPU('off');%close the GPU calculation
d.getModel();%get xyz from d.mo
%---------------delele elements on the top
hLimit=0.170;
sId=d.GROUP.sample;
allZ=d.mo.aZ(sId);
zFilter=allZ<hLimit;
d.addGroup('grains',sId(zFilter));
grainObj=d.group2Obj('grains');

expandRate=3;%
Rrate=0.8;%ratio of element diameter to distance
grainObj=mfs.grain2Clump2D(grainObj,expandRate,Rrate);

figure('Position',[50,50,800,600]);
subplot(1,2,1);
d.showData('aR');
colorbar off;
subplot(1,2,2);
fs.showObj(grainObj);
view(0,0);
d.showFrame0();

save(['TempModel/' B.name '2.mat'],'grainObj');
save(['TempModel/' B.name '2R' num2str(B.ballR) '-distri' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
d.calculateData();