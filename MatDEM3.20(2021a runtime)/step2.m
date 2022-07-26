clear;                                                                           
load('TempModel/step1.mat');                                                     
B.setUIoutput();                                                                 
d=B.d;                                                                           
d.calculateData();                                                               
d.mo.setGPU('off');                                                              
d.getModel();                                                                    
                                                                                 
C=Tool_Cut(d);                                                                   
lSurf=load('slope/layersv2.txt');                                                
C.addSurf(lSurf);                                                                
C.setLayer({'sample'},[1,2,3,4,5]);                                              
gNames={'lefPlaten';'rigPlaten';'botPlaten';'layer1';'layer2';'layer3';'layer4'};
d.makeModelByGroups(gNames);                                                     
                                                                                 
aR0=d.mo.aR;                                                                     
FILTER1=(aR0<=0.000521777210964366);                                             
d.addGroup('Clay',find(FILTER1));                                                
                                                                                 
d.setGroupId();                                                                  
d.show('groupId');                                                               
                                                                                 
matTxt=load('Mats\WeakRock1.txt');                                               
Mats{1,1}=material('WeakRock1',matTxt,B.ballR);                                  
Mats{1,1}.Id=1;                                                                  
d.Mats=Mats;                                                                     
d.setGroupMat('layer1','WeakRock1');                                             
d.setGroupMat('layer2','WeakRock1');                                             
d.setGroupMat('layer3','WeakRock1');                                             
d.setGroupMat('layer4','WeakRock1');                                             
d.setGroupMat('Clay','WeakRock1');                                               
d.groupMat2Model({'layer1','layer2','layer3','layer4','Clay'},2);                
d.groupMat2Model({'sample'},1);                                                  
                                                                                 
d.balanceBondedModel0(1);                                                        
d.balanceBondedModel0(1);                                                        
d.balance('Standard',5);                                                         
d.status.dispEnergy();                                                           
                                                                                 
save(['TempModel/' B.name '2.mat'],'B','d');                                     