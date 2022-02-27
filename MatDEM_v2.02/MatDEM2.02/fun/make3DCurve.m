function curveObj=make3DCurve(lineX,lineY,lineZ,ballR,Rrate)
curveObj.X=[];
curveObj.Y=[];
curveObj.Z=[];
curveObj.R=[];
for i=1:length(lineX)-1
    lineObj=f.run('fun/make3DLine.m',lineX(i:i+1),lineY(i:i+1),lineZ(i:i+1),ballR,Rrate);
    lineObj.X(end)=[];
    lineObj.Y(end)=[];
    lineObj.Z(end)=[];
    lineObj.R(end)=[];
    curveObj=mfs.combineObj(curveObj,lineObj);
end
end