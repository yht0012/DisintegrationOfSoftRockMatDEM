clear;
load('TempModel/step2.mat');
d.calculateData();
d.mo.setGPU('off');
B.setUIoutput();
d=B.d;
d.calculateData();
d.getModel();
d.resetStatus();
d.mo.isHeat=1;
d.setStandarddT();
d.mo.isCrack=1;
initialWC=0;
visRate=1;
d.mo.mVis=d.mo.mVis*visRate;
surfacelement=d.GROUP.surface;
d.mo.SET.aWC=ones(d.aNum,1)*initialWC;
d.mo.SET.mWater=d.mo.mM.*d.mo.SET.aWC(1:d.mNum);
d.mo.SET.aWC(d.mNum+1:d.aNum)=-1;
nballCol=size(d.mo.nBall,2);
nRow=ones(1,size(d.mo.nBall,2));
projectname='Permeate';
filname=['RESULT'];

cbFilter=d.mo.cFilter|d.mo.bFilter;
	sZ=d.mo.aZ;
	nZ=sZ(d.mo.nBall);
	nZCenter=sZ*nRow;
	nZCenter=nZCenter(1:d.mo.mNum,1:end);
	nZDiff=nZ-nZCenter;
	factorZ=nZDiff;
	factorZ(~cbFilter|factorZ<0)=9999;
	factorZGain=factorZ*0.00851+0.03;
	factorZGain(factorZGain>10)=0;
	factorZ2=nZDiff;
	factorZ2(~cbFilter|factorZ2>0)=9999;
	factorZWeaken=abs(factorZ2)*0.0127;
	factorZWeaken(factorZWeaken>10)=0;

GraMat=factorZGain++factorZWeaken;

nballMat=d.mo.nBall;
Serial_ID=find(d.mo.SET.aWC==-1);
for i=1:size(Serial_ID,1)
	nballMat(nballMat==Serial_ID(i))=0;
end
nballMat(nballMat~=0)=1;
GraMat(~nballMat)=0;
Initial_nBondRate=d.mo.nBondRate;
nballMat2=d.mo.nBall;



clayelement=d.GROUP.Clay;

normFactor=1;
normDistri=fs.getDistribution('norm',d.aNum,normFactor);
d.mo.aBF=d.mo.aBF.*normDistri;
fs.mixProperty(d,'aBF');

for i=1:1
	for j=1:10
		d.mo.aR(clayelement)=d.aR(clayelement).*(1+0.012*((d.mo.SET.aWC(clayelement)-initialWC)/initialWC));
		d.mo.SET.aWC(surfacelement)=0.5;
		d.mo.SET.mWater=d.mo.mM.*d.mo.SET.aWC(1:d.mNum);
		sizenball=size(nballMat2,2);
		nRow=ones(1,sizenball);
		nWaterDiff=d.mo.SET.aWC(nballMat2)-d.mo.SET.aWC(1:d.mNum)*nRow;
		nWaterDiff_mod=nWaterDiff.*GraMat;
		mWaterFlow=sum(nWaterDiff_mod,2);
		d.mo.SET.aWC(1:d.mo.mNum)=d.mo.SET.aWC(1:d.mo.mNum)+mWaterFlow;
		nBondRate_nWaterDiff1=(d.mo.SET.aWC(nballMat2)+d.mo.SET.aWC(1:d.mNum)*nRow)/2;
		nBondRate_nWaterDiff1=nBondRate_nWaterDiff1.*nballMat2;
		nBondRate_nWaterDiff1(~cbFilter)=0;
		nBondRate_nWaterDiff1=nBondRate_nWaterDiff1.*-0.1+1.01;
		nBondRate_nWaterDiff1=exp(-nBondRate_nWaterDiff1*0.1);
		nBondRate_nWaterDiff1(nBondRate_nWaterDiff1>1)=1;
		nBondRate_nWaterDiff1(nBondRate_nWaterDiff1<0)=0;
		fi = d.mo.SET.aWC(1:1410, 1:1);
		d.mo.mVis=d.mo.mVis.*  exp (-fi*0.1);
		d.balance('Standard',0.1);
		d.show('SETaWC')
		
	
	end

	save([filname num2str(i) '.mat']);
end