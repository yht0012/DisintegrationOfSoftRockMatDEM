function d=moveGroup2Center(B,gName)
d=B.d;
gX=d.mo.aX(d.GROUP.(gName));
gY=d.mo.aY(d.GROUP.(gName));
gZ=d.mo.aZ(d.GROUP.(gName));
dx=B.sampleW/2-(max(gX)+min(gX))/2;
dy=B.sampleL/2-(max(gY)+min(gY))/2;
dz=B.sampleH/2-(max(gZ)+min(gZ))/2;
d.moveGroup(gName,dx,dy,dz);
end