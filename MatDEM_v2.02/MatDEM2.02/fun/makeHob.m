function obj=makeHob(hobR,hobT,cutRate,ballR,Rrate)
hobR2=hobR-ballR;
hobT2=hobT-ballR*2;
ballR2=ballR*Rrate;
obj=f.run('fun/makeDisc.m',hobR2,ballR2);
layerNum=ceil((hobT2/2-ballR2)/(ballR2*2));
for i=1:layerNum
    newObj=f.run('fun/makeDisc.m',hobR2-ballR2*cutRate*i,ballR2);
    newObj1=mfs.move(newObj,0,0,ballR2*2*i);
    obj=mfs.combineObj(obj,newObj1);
    newObj2=mfs.move(newObj,0,0,-ballR2*2*i);
    obj=mfs.combineObj(obj,newObj2);
end
obj.R(:)=ballR;
end