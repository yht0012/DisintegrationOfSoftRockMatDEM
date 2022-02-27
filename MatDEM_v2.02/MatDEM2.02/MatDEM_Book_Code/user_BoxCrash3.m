clear;
load('TempModel/BoxCrash2.mat');
d.calculateData();
d.mo.setGPU('off');
B.setUIoutput();
d=B.d;
d.getModel();%d.setModel();%reset the initial status of the model
d.status=modelStatus(d);%initialize model status, which records running information

d.mo.isHeat=1;%calculate heat in the model
visRate=0.0001;
d.mo.mVis=d.mo.mVis*visRate;
discId=d.GROUP.Disc;
d.mo.mVZ(discId)=-1000;
d.setStandarddT();
d.mo.dT=d.mo.dT*0.05;

gpuStatus=d.mo.setGPU('auto');

totalCircle=40;
d.tic(totalCircle);
fName=['data/step/' B.name num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];
save([fName '0.mat']);%return;
for i=1:totalCircle
    d.mo.setGPU(gpuStatus);
    d.balance('Standard',0.4);
    d.mo.setGPU('off');
    d.clearData(1);
    save([fName num2str(i) '.mat']);
    d.calculateData();
    d.toc();%show the note of time
end
d.mo.setGPU('off');
d.clearData(1);
d.recordCalHour('BoxCrush3Finish');
save(['TempModel/' B.name '3.mat'],'d');
save(['TempModel/' B.name '3R' num2str(B.ballR) '-' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
d.calculateData();
d.show('aR');