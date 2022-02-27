clear;
fs.randSeed(2);%build random model
B=obj_Box;%build a box object
B.name='step';
B.GPUstatus='off';
B.ballR=1;
B.isClump=0;
B.distriRate=0.8;
B.sampleW=120;
B.sampleL=0;
B.sampleH=120;
B.type='topPlaten';
B.setType();
B.buildInitialModel();%B.show();
B.setUIoutput();
d=B.d;%d.breakGroup('sample');d.breakGroup('lefPlaten');
B.gravitySediment();
B.compactSample(2);%input is compaction time
d.clearData(1);%clear dependent data
d.recordCalHour('Step1Finish');
save(['TempModel/' B.name '1.mat'],'B','d');
save(['TempModel/' B.name '1R' num2str(B.ballR) '-distri' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
d.calculateData();
    d.show('aR');