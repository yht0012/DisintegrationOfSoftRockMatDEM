%wide grading
clear;
fs.chooseGPU();
seedId=1;
rangeNum=2;%级配数，取1至4，取1算得快，4的话，粒径比40，时间长
isShock=0;%whether run the second step user_BoxCompactionShock2
fs.randSeed(seedId);%change it to get a different model

%------------------set the grain size and box size------------------
grainDensity=2630;%density of the grains
moNum='auto';%divided into 'moNum' size groups (childModel),0~10
rate='auto';%automatical balance rate in B.gravitySediment
isCement=0;%whether elements will be cemented when contacting
is2D=0;%build 3D model when is2D=0
hRate=1;% box is bigger a bit, 1.0~1.2
friction=0.35;%0.1~0.35
hRate=hRate+isCement*0.2-is2D*0.1+friction*0.02;
%hRate varies with isCement, is2D and friction
isUniformGRate=1;%1采用自然堆积，0则用快速堆积

if is2D==1
    totalM=250e-3;%total mass of the sample
    sampleW=0.20;sampleL=0;%width and length of the model, height will be determined by totalM
else
    totalM=20;%total mass of the sample
    sampleW=0.20;sampleL=0.20;%width and length of the model, height will be determined by totalM
end
%minmum diameter, maximum diameter, and mass rate

grainSizeDistribution=[1,5,34.98*4/9;5,10,34.98*5/9;10,20,27.06;20,40,4.5]*1e-3;
grainSizeDistribution=grainSizeDistribution(end-rangeNum+1:end,:);
%determine the grain radius (grainR) according to the above data
grainR=mfs.getGradationDiameter(grainSizeDistribution,totalM/grainDensity,-1)/2;
mfs.gradingCurve(grainR*2);

%determine the box size
SET=mfs.getBoxSample(grainR,sampleW,sampleL,hRate);
SET.moNum=moNum;%divided into 'moNum' size groups
%------------------end set the grain size and box size------------------

%--------------initializing Box model------------
B=obj_Box;%build a box object
B.name='BoxCompactionShock';
B.GPUstatus='auto';
B.setType('topPlaten');
B.PexpandRate=2;
B.uniformGRate=isUniformGRate;
B.buildInitialModel(SET);%B.show();
B.setUIoutput();
d=B.d;

matTxt2=[5e6,0.1,5e3,50e3,0.8,1650];%load a un-trained material file
Mats{1,1}=material('soil1',matTxt2,B.ballR);
Mats{1,1}.Id=1;
Mats{1,1}.setGrainDensity(grainDensity);

d.Mats=Mats;
d.groupMat2Model();
d.breakGroup();

if B.sampleL==0
    B.convert2D(B.ballR);%change ball properties to 2D
end

if friction>0
    d.mo.setShear('on');
    d.aMUp(:)=friction;
    d.mo.aMUp(:)=friction;
end
d.showB=1;
%--------------end initializing Box model------------
B.resetStatusBeforeDrop=1;
B.gravitySediment(rate,isCement);%element will be cemented when ture

d.balance('Standard');
d.status.dispEnergy();%display the energy of the model
d.setData();
pZ=min(d.mo.aZ(d.GROUP.topPlaten))-B.ballR*5;
porosity=mfs.getPorosity(B,pZ);
%d.showFilter('Group',{'sample'});
d.figureNumber=1;
d.show();
porosities(seedId,rangeNum+1)=porosity;
B.TAG.porosities=porosities;
%------------return and save result--------------
B.TAG.hRate=hRate;
B.TAG.friction=friction;
B.TAG.seedId=seedId;
B.TAG.rangeNum=rangeNum;
d.status.dispEnergy();%display the energy of the model
d.mo.setGPU('off');
d.clearData(1);%clear dependent data
d.recordCalHour('Step1Finish');
save(['TempModel/' B.name '1.mat'],'B','d','-v7.3');
save(['TempModel/' B.name '-Seed' num2str(B.TAG.seedId) '-rangeNum' num2str(B.TAG.rangeNum) '-friction' num2str(B.TAG.friction) '-1R' num2str(B.ballR) 'aNum' num2str(d.aNum) '.mat'],'-v7.3');
d.calculateData();%because data is clear, it will be re-calculated

if isShock==1
    user_BoxCompactionShock2
end