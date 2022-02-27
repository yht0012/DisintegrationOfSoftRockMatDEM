%note: this code is used to test the speeds of CPU and GPU computing with different element numbers. In MatDEM, 1GB memory supports ~100 thousands elements, when GPULevel=3, the number will reduce to ~50 thousands elements; when GPULevel=4, the use of memory will reduce (recommended). When testNum=10, element number is 100 thousands.
clear
startT=now;
%--------setting of the speed test
GPULevel=4;%=1,2,3,4 when it is 3, neighbor searching speed will increase, but using double memory
testNum=10;%=9,10,11,12,13,14, test number of the elementNum array
elementNum=[100,200,500,1e3,2e3,5e3,10e3,20e3,50e3,100e3,200e3,500e3,1e6,2e6,3e7];%element number array, 15 in total
%--------end setting of the speed test

Num=elementNum.^(1/3);
balanceCommand='ContactModel.basicContact(obj);';%use basic normal contact model
%balanceCommand='ContactModel.simpleContact(obj);';%use simple contact model

searchNum=5;
GA=gpuArray(1);%open GPU
CPUspeeds=[];
GPUspeeds=[];
modelingSpeeds=[];
CPUSearchSpeeds=[];
GPUSearchSpeeds=[];
mNums=[];
for i=1:testNum
[data,B]=mfs.testSpeed(Num(i),balanceCommand);
%data=f.run('fun/testSpeed.m',Num(i));
CPUspeeds=[CPUspeeds;data.CPUspeed];
GPUspeeds=[GPUspeeds;data.GPUspeed];
modelingSpeeds=[modelingSpeeds;data.modelingSpeed];
mNums=[mNums;data.mNum];

d=B.d;
%-----------------test neighbor searching in CPU
d.mo.setGPU('off');
tic
for j=1:searchNum
    d.mo.setNearbyBall();
end
totalTime=toc;
CPUSearchSpeed=d.mNum*searchNum/totalTime;
CPUSearchSpeeds=[CPUSearchSpeeds;CPUSearchSpeed];

%-----------------test neighbor searching in GPU
d.mo.setGPU('on');
d.mo.GPULevel=GPULevel;
tic
for j=1:searchNum
d.mo.nBall=[];
    d.mo.setNearbyBall();
end
totalTime=toc;
GPUSearchSpeed=d.mNum*searchNum/totalTime;
GPUSearchSpeeds=[GPUSearchSpeeds;GPUSearchSpeed];
end
allData=[mNums,CPUspeeds,GPUspeeds,modelingSpeeds];
calMinute=(now-startT)*24*60;

figure('Position',[10,10,1200,600]);%set the size of the figure
subplot(1,2,1);
plot(mNums,CPUspeeds,'-sb');
hold all
plot(mNums,GPUspeeds,'-ok');
xlabel('Active model element number (mNum)');
ylabel('Element motion per second');
title('Speed of CPU and GPU');
legend('CPU speed','GPU speed');
subplot(1,2,2);
plot(mNums,CPUSearchSpeeds,'-sb');
hold all;
plot(mNums,GPUSearchSpeeds,'-ok');
xlabel('Active model element number (mNum)');
ylabel('Search of element per second');
title('Speed of neighbor searching');
legend('CPU speed','GPU speed');
msgbox(['Calculation time: ' num2str(calMinute) ' minutes']);