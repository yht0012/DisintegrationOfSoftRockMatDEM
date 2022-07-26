load('TempModel/BoxCompactionShock1.mat');
staticPressure=-10.55e3;%static pressure on sample，上振动板的静压力
shockA=1e-3;%amplitude of the wave，上振动板的振幅
shockF=35;%frequency，上振动板的频率
totalSecond=1;%振动模拟的总时间
totalCircle=10;%loop and saving time
positiveWave=0;%是否保证振动板一直施加压力而不跳起（去掉向上的位移）

visRate=0.01;%rate of viscosity，与含水率相关
cutSample=0;%是否将样品上部切平到一定高度，如25cm
cutHeight=0.25;%height of the sample
isConnect=0;%whether particle connected at beginning
receiverNum=3;%receiver number

d.calculateData();
d.mo.setGPU('off');
B.setUIoutput();
d=B.d;
d.getModel();%d.setModel();%reset the initial status of the model
d.resetStatus();%initialize model status, which records running information
d.setStandarddT();
d.mo.dT=d.mo.dT*4;

d.mo.setGPU('auto');

[realTime,balanceNum]=d.balance('Time');%获得一次标准平衡的实际时间和总平衡次数

if isConnect==1
d.connectGroup();
d.mo.zeroBalance();
d.deleteConnection('boundary');
d.mo.setGPU('auto');
d.balance('Standard',2);
end

standardRate=totalSecond/totalCircle/realTime;%每次循环中的标准平衡次数
totalBalanceNum=standardRate*balanceNum*totalCircle;
totalT=totalBalanceNum*d.mo.dT;%total time of the wave
fs.disp(['total time is: ' num2str(totalT) ' seconds']);

if cutSample==1
    [~,topId]=mfs.splitGroup(d,'sample','aZ',cutHeight);
    d.delElement(topId);
    topLimit=max(d.mo.aZ(d.GROUP.sample)+d.mo.aR(d.GROUP.sample));
    dZ=topLimit-min(d.mo.aZ(d.GROUP.topPlaten)-d.mo.aR(d.GROUP.topPlaten));
    d.moveGroup('topPlaten',0,0,dZ);
end

d.mo.isHeat=1;%calculate heat in the model
d.mo.mVis=d.mo.mVis*visRate;
if B.is2D==1
    shockM=abs(staticPressure*B.ballR*2*B.sampleW/9.8);
else
    shockM=abs(staticPressure*B.sampleL*B.sampleW/9.8);
end

tId=d.GROUP.topPlaten;
shockPlatenFilter=(d.mo.aX(tId)>0)&(d.mo.aX(tId)<B.sampleW)&(d.mo.aY(tId)>0)&(d.mo.aY(tId)<B.sampleL);
shockId=tId(shockPlatenFilter);
d.addGroup('Shocker',shockId);
vM=shockM/length(shockId);
vGZ0=vM*-9.8;
maxAddGZ=-vM*shockA*(2*pi*shockF)^2;
d.mo.mM(shockId)=vM;

%---------------------define the source of the wave

Ts=(0:totalBalanceNum)*d.mo.dT;
Values=vGZ0+maxAddGZ*sin((2*pi)*shockF*Ts);
if positiveWave==1
    Values(Values>0)=0;
end
%plot(Ts,Values);return

waveProp='mGZ';
d.addTimeProp('Shocker',waveProp,Ts,Values);%assign the AZ to elements of LeftLine
d.addRecordProp('Shocker',waveProp);%declare recording mAZ
%---------------------end define the source of the wave

%-------------------define the receiver
centerx=B.sampleW/2;%center position of the receiver
centery=mean(d.mo.aY(d.GROUP.sample));
centerz=mean(d.mo.aZ(d.GROUP.topPlaten))/(receiverNum-1);
R=B.ballR*4;%radius of the receiver
gNames={};
prop1='mAZ';%record the property 1
prop2='aZ';%record the property 2
for i=1:receiverNum
    gName=['Receiver' num2str(i)];
    gNames=[gNames(:);gName];
    f.run('fun/defineSphereGroup.m',d,gName,centerx,centery,centerz*(i-1),R);
    d.addRecordProp(gName,prop1);%declare recording mAZ
    d.addRecordProp(gName,prop2);%declare recording mAZ
end
figure;
subplot(2,1,1);
d.setGroupId();
d.showFilter('Group',gNames,'aR');
subplot(2,1,2);
plot(Ts,Values);xlabel('Ts [second]');ylabel('GZ of the Shocker [N]');title('GZ of the Shocker');
%-------------------end define the receiver

porosities=[];Ts=[];
gpuStatus=d.mo.setGPU('auto');

d.tic(totalCircle);

fName=['data/step/' B.name 'Seed' num2str(B.TAG.seedId) '-rangeNum' num2str(B.TAG.rangeNum) '-friction' num2str(B.TAG.friction) '-1R' num2str(B.ballR) 'aNum' num2str(d.aNum) 'P' num2str(staticPressure) 'A' num2str(shockA) 'F' num2str(shockF) 'loopNum'];
%d.figureNumber=d.show('aR');

d.status.TAG.B=B;
pZ=min(d.mo.aZ(d.GROUP.topPlaten))-B.ballR*5;
porosity=mfs.getPorosity(B,pZ);
d.status.SET.shockPorosities=porosity;%initialize the value
recordCommand='d=obj.dem;B=obj.TAG.B;pZ=min(d.mo.aZ(d.GROUP.topPlaten))-B.ballR*5;porosity=mfs.getPorosity(B,pZ);';
d.status.recordCommand=[recordCommand 'd.status.SET.shockPorosities=[d.status.SET.shockPorosities;porosity];'];

for i=1:totalCircle
    d.mo.setGPU(gpuStatus);
    d.balance('Standard',standardRate);
    
    d.setData();
    %d.showFilter('Group',{'Shocker'});
    %d.data.AZ0=d.mo.mGZ./d.mo.mM;
    d.show('mVZ');
    d.clearData(1);
    save([fName num2str(i) '.mat']);
    d.calculateData();
    d.toc();%show the note of time
end
d.mo.setGPU('off');

%show the curves，显示监测点的振动
curveFigure=figure;
for i=1:receiverNum
    subplot(receiverNum,2,i*2-1);
    d.status.show(['PROPReceiver' num2str(i) '_' prop1]);
    subplot(receiverNum,2,i*2);
    d.status.show(['PROPReceiver' num2str(i) '_' prop2]);
end
%显示振源的信号，以及孔隙率变化
figure;d.status.show(['PROPShocker_' waveProp]);%declare recording mAZ
figure;d.status.show('SETshockPorosities');

d.clearData(1);
d.recordCalHour('BoxCrush3Finish');
save(['TempModel/' B.name '3.mat'],'d','-v7.3');
save(['TempModel/' B.name '3-Seed' num2str(B.TAG.seedId) '-rangeNum' num2str(B.TAG.rangeNum) '-friction' num2str(B.TAG.friction) '-1R' num2str(B.ballR) 'aNum' num2str(d.aNum) 'P' num2str(staticPressure) 'A' num2str(shockA) 'F' num2str(shockF) '.mat'],'-v7.3');
d.calculateData();