function [data,B]=testSpeed(num)
ballR=0.001;
fs.randSeed(1);%build random model
B=obj_Box;%build a box object
B.name='TestSpeed';
B.GPUstatus='auto';
B.ballR=ballR;
B.isClump=0;
B.distriRate=0.2;
B.sampleW=ballR*num*2;
B.sampleL=ballR*num*2;
B.sampleH=ballR*num*2;
B.setType('none');
tic
B.buildInitialModel();%B.show();
modelingT=toc;
B.setUIoutput();
d=B.d;
[status,data]=d.mo.setGPU('auto');

data.modelingSpeed=d.mNum/modelingT;
data.aNum=d.aNum;
data.mNum=d.mNum;
end