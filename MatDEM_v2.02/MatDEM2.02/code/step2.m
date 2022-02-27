clear;
load('TempModel/step1.mat');
B.setUIoutput();
d=B.d;
d.calculateData();
d.mo.setGPU('off');
d.getModel();

C=Tool_Cut(d);
lSurf=load('Mats\Cutstone.txt');
C.addSurf(lSurf);
C.setLayer({'sample'},[1,2]);
gNames={'lefPlaten';'rigPlaten';'botPlaten';'layer1'};
d.makeModelByGroups(gNames);
save;

aR0=d.mo.aR;
FILTER4=(aR0<=0.8628);
d.addGroup('Clay',find(FILTER4));


sX=d.mo.aX(1:d.mNum);sZ=d.mo.aZ(1:d.mNum);
sampleW=B.sampleW;
ballR=min(d.aR);
MaxZId=[];
Dx=ballR*4.5;
CalTimes=floor(sampleW/Dx);
leftX=34;
rightX=38;
leftX2=83;
rightX2=87;  
leftZ=97;
rightZ=100;
printtic=1;
projectname='Mudstone disintegration';
filname=[''];

TopPla_Num=length(d.GROUP.topPlaten);
sX=d.mo.aX(1:d.mNum-TopPla_Num);sZ=d.mo.aZ(1:d.mNum-TopPla_Num);
FILTER1=(leftX<=sX&sX<rightX);
FILTER2=(leftX2<=sX&sX<rightX2);
FILTER3=(leftZ<=sZ&sZ<rightZ);
d.addGroup('surface',[find(FILTER1); find(FILTER2); find(FILTER3)]);

d.setGroupId();
d.show('groupId');

matTxt=load('Mats\WeakRock1.txt');
Mats{1,1}=material('WeakRock1',matTxt,B.ballR);
Mats{1,1}.Id=1;
d.Mats=Mats;
d.groupMat2Model({'sample'},1);

save(['TempModel/' B.name '2.mat'],'B','d');