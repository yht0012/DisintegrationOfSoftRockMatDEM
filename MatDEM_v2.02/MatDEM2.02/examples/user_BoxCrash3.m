ufs.setTitle('MatDEM��ʯײ������ʵʱģ��');
clear;
load('TempModel/BoxCrash2.mat');
d.calculateData();
d.mo.setGPU('off');
B.setUIoutput();
d=B.d;
d.getModel();%d.setModel();%reset the initial status of the model
d.resetStatus();%initialize model status, which records running information
d.mo.isShear=0;
d.mo.isHeat=1;%calculate heat in the model
visRate=0.0001;
d.mo.mVis=d.mo.mVis*visRate;
discId=d.GROUP.Disc;
d.setStandarddT();
d.mo.dT=d.mo.dT*4;%increase step time to increase computing speed

d.mo.mVZ(discId)=-2000;
d.mo.mVX(discId)=-1000;

d.showB=0;
d.status.legendLocation='West';

%----------set the drawing of result during iterations
setappdata(0,'simpleFigure',1);
setappdata(0,'ballRate',0.01);
showType='StressZZ';
%----------end set the drawing of result during iterations

gpuStatus=d.mo.setGPU('auto');
totalCircle=50;
d.tic(totalCircle);
fName=['data/step/' B.name num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];
save([fName '0.mat']);%return;
for i=1:totalCircle
    d.balance('Standard',0.0005);
    d.figureNumber=d.show(showType);%result will be shown in one figure
    pause(0.05);
end
d.mo.setGPU('off');
d.clearData(1);
d.recordCalHour('BoxCrush3Finish');
save(['TempModel/' B.name '3.mat'],'d');
save(['TempModel/' B.name '3R' num2str(B.ballR) '-' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
d.calculateData();