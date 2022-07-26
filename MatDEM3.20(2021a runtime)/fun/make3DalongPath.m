function allObj=make3DalongPath(obj2D,X,Y,Z,dDis,dAngle)
%used in user_Cable
dis=0;
allObj.X=[];allObj.Y=[];allObj.Z=[];allObj.R=[];allObj.groupId=[];
discId=0;
for i=1:length(X)-1
    x1=X(i);x2=X(i+1);
    y1=Y(i);y2=Y(i+1);
    z1=Z(i);z2=Z(i+1);
    dx=x2-x1;dy=y2-y1;dz=z2-z1;
    disNew=sqrt(dx*dx+dy*dy+dz*dz);
    dis=dis+disNew;
    if dis/dDis>discId
        discId=discId+1;
        xyDis=sqrt(dx*dx+dy*dy);
        angleA=rad2deg(atan2(dy,dx));
        angleB=rad2deg(atan2(xyDis,dz));
        discNew=mfs.rotate(obj2D,'XY',dAngle*discId);
        discNew=mfs.rotate2Path(discNew,[x1,y1,z1],[x2,y2,z2]);
        allObj=mfs.combineObj(allObj,discNew);
    end
end
end