cla                                                                                                  
ballR=0.01;                                                                                         
helixInnerR=ballR;                                                                                   
helixOuterR=0.1;                                                                                     
helixHeight=1;                                                                                       
circle=6;                                                                                            
Rrate=0.8;                                                                                           
helixObj=f.run('fun/makeHelix.m',helixInnerR,helixOuterR,helixHeight,circle,ballR,Rrate);     
 
plane=mfs.denseModel(0.8,@mfs.makeBox,1,0,1,ballR);%make a pile struct
bacPlane=mfs.move(plane,-0.5,0.5,0);
botPlaten=mfs.rotate(plane,'YZ',90);
botPlaten=mfs.move(botPlaten,-0.5,0.5,0);
figure;
allObj=mfs.combineObj(helixObj,bacPlane);
allObj=mfs.combineObj(allObj,botPlaten);

fs.showObj(allObj);