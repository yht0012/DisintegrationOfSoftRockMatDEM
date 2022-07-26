clear;                                                                                                       
load('TempModel/step2.mat');                                                                                 
normFactor=1;                                                                                                
d.calculateData();                                                                                           
d.mo.setGPU('on');                                                                                           
B.setUIoutput();                                                                                             
d=B.d;                                                                                                       
d.calculateData();                                                                                           
d.getModel();                                                                                                
d.resetStatus();                                                                                             
d.mo.isHeat=1;                                                                                               
d.setStandarddT();                                                                                           
d.mo.isCrack=1;                                                                                              
filname=['RESULT'];                                                                                          
initialWC=0.01;                                                                                              
clayelement=d.GROUP.Clay;                                                                                    
%crackelement=d.GROUP.Crack;                                                                                 
d.mo.SET.aWC=ones(d.aNum,1)*initialWC;                                                                       
d.mo.SET.mWater=d.mo.mM.*d.mo.SET.aWC(1:d.mNum);                                                             
d.mo.SET.aWC(d.mNum+1:d.aNum)=-1;                                                                            
normDistri=fs.getDistribution('norm',d.aNum,normFactor);                                                     
d.mo.aBF=d.mo.aBF.*normDistri;                                                                               
fs.mixProperty(d,'aBF');                                                                                     
                                                                                                             
layer1=d.GROUP.layer1;                                                                                       
layer2=d.GROUP.layer2;                                                                                       
layer3=d.GROUP.layer3;                                                                                       
layer4=d.GROUP.layer4;                                                                                       
nRow=ones(1,size(d.mo.nBall,2));                                                                             
cbFilter=d.mo.cFilter|d.mo.bFilter;                                                                          
	sZ=d.mo.aZ;                                                                                                 
	nZ=sZ(d.mo.nBall);                                                                                          
	nZCenter=sZ*nRow;                                                                                           
	nZCenter=nZCenter(1:d.mo.mNum,1:end);                                                                       
	nZDiff=nZ-nZCenter;                                                                                         
	factorZ=nZDiff;                                                                                             
	factorZ(~cbFilter|factorZ<0)=9999;                                                                          
	factorZGain=factorZ*15;                                                                                     
	factorZGain(factorZGain>10)=0;                                                                              
	factorZ2=nZDiff;                                                                                            
	factorZ2(~cbFilter|factorZ2>0)=100000;                                                                      
	factorZWeaken=abs(factorZ2)*0.0000008;                                                                      
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
Initial_nBondRate=d.mo.nBondRate;                                                                            
                                                                                                             
d.show('SETaWC');                                                                                            
d.mo.dT=d.mo.dT*4;                                                                                           
k=0;                                                                                                         
totalCircle=100;                                                                                             
stepNum=100;                                                                                                 
d.tic(totalCircle*stepNum);                                                                                  
fName=['data/step/' d.name 'loopNum'];                                                                       
save([fName '0.mat']);                                                                                       
fs.disp('Start calculation');                                                                                
for i=1:totalCircle                                                                                          
    for j=1:stepNum                                                                                          
        d.toc();                                                                                             
        d.mo.SET.aWC(layer4)=0.5;                                                                            
        %d.mo.SET.aWC(crackelement)=0.5;                                                                     
        nRow=ones(1,size(d.mo.nBall,2));                                                                     
        nWaterDiff=d.mo.SET.aWC(d.mo.nBall)-d.mo.SET.aWC(1:d.mNum)*nRow;                                     
        nWaterDiff_mod=nWaterDiff.*GraMat;                                                                   
        mWaterFlow=sum(nWaterDiff_mod,2);                                                                    
        d.mo.SET.aWC(1:d.mo.mNum)=d.mo.SET.aWC(1:d.mo.mNum)+mWaterFlow;                                      
        nWaterDiff(~cbFilter)=0;                                                                             
        nWC=d.mo.SET.aWC(d.mo.nBall);                                                                        
        nWaterDiff(nWC==-1)=0;                                                                               
                                                                                                             
       d.mo.aR(clayelement)=d.aR(clayelement).*(1+0.00001*((d.mo.SET.aWC(clayelement)-initialWC)/initialWC));
        d.mo.balance();%calculation                                                                          
                                                                                                             
        eleaWC = d.mo.SET.aWC(1:d.mNum);                                                                     
        d.mo.aBF(1:d.mNum)=56.41.*exp(-eleaWC*0.99)+7.45;                                                    
        fs.mixProperty(d,'aBF');                                                                             
                                                                                                             
        nBondRate_awc=eleaWC*nRow;                                                                           
        nBondRate_nWaterDiff1=exp(-nBondRate_awc*0.9);                                                       
        nBondRate_nWaterDiff1(~cbFilter)=0;                                                                  
        nBondRate_nWaterDiff1(nBondRate_nWaterDiff1>1)=1;                                                    
        nBondRate_nWaterDiff1(nBondRate_nWaterDiff1<0)=0;                                                    
        d.mo.nBondRate=Initial_nBondRate.*nBondRate_nWaterDiff1;                                             
                                                                                                             
        d.show('SETaWC');                                                                                    
        averlayer2aWC=mean(d.mo.SET.aWC(layer2));                                                            
        averaWC=mean(eleaWC);                                                                                
        if (averlayer2aWC > 0.30)                                                                            
            k=1;                                                                                             
            break;                                                                                           
        end                                                                                                  
        d.recordStatus();                                                                                    
    end                                                                                                      
    d.clearData(1);                                                                                          
    save([fName num2str(i) '.mat']);                                                                         
    d.calculateData();                                                                                       
    if (k==1)                                                                                                
        break;                                                                                               
    end                                                                                                      
d.show('SETaWC');                                                                                            
end                                                                                                          
                                                                                                             
d.breakGroupOuter({'layer3'});                                                                               
d.breakGroup({'layer3'});                                                                                    
                                                                                                             
d.mo.isHeat=1;                                                                                               
visRate=0.000001;                                                                                            
d.mo.mVis=d.mo.mVis*visRate;                                                                                 
gpuStatus=d.mo.setGPU('on');                                                                                 
d.setStandarddT();                                                                                           
d.mo.dT=d.mo.dT*8;                                                                                           
                                                                                                             
totalCircle=1;                                                                                               
d.tic(totalCircle);                                                                                          
fName=['data/step/' B.name  num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];                           
save([fName '0.mat']);                                                                                       
for i=1:totalCircle                                                                                          
    d.mo.setGPU(gpuStatus);                                                                                  
    d.balance('Standard',1);                                                                                 
    d.clearData(1);                                                                                          
    save([fName num2str(i) '.mat']);                                                                         
    d.calculateData();                                                                                       
    d.toc();                                                                                                 
end                                                                                                          
                                                                                                             
fs.disp('Calculation finished');                                                                             
d.showB=2;                                                                                                   
d.show('SETaWC');                                                                                            
d.mo.setGPU('off');                                                                                          
d.clearData(1);                                                                                              
d.recordCalHour('disintegration');                                                                           
save([filname num2str(i) '.mat']);                                                                           
d.calculateData();                                                                                           