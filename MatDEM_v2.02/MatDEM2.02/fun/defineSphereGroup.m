function defineSphereGroup(d,gName,centerx,centery,centerz,R)
mX=d.mo.aX(1:d.mNum);mY=d.mo.aY(1:d.mNum);mZ=d.mo.aZ(1:d.mNum);
mDis=sqrt((mX-centerx).^2+(mY-centery).^2+(mZ-centerz).^2);
filter=mDis<R;
d.addGroup(gName,find(filter));
end