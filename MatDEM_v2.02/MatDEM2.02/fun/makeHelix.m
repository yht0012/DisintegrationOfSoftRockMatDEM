function helixObj=makeHelix(helixInnerR,helixOuterR,helixHeight,circle,ballR,Rrate)
lineNum=ceil((helixOuterR-helixInnerR)/(ballR*2*Rrate));
helixR=helixInnerR:(helixOuterR-helixInnerR)/lineNum:helixOuterR;

helixObj.X=[];
helixObj.Y=[];
helixObj.Z=[];
helixObj.R=[];
f.define('fun/makeHelicalLine.m')
for i=1:lineNum+1
newObj=f.run('fun/makeHelicalLine.m',helixR(i),helixHeight,circle,ballR,Rrate);
helixObj=mfs.combineObj(helixObj,newObj);
end
end

