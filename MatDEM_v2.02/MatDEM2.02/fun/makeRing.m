function ringObj=makeRing(innerR,layerNum,minBallR,Rrate)
r1=minBallR*Rrate;
R1=innerR+minBallR;
outerR=innerR+2*minBallR;
disc=mfs.makeCircle(innerR+minBallR,r1);
dAngle=360/length(disc.R);

%t=r1/sqrt(R1*R1+r1*r1);
%r2=R1*t+r1*t*t+sqrt(r1*(r1+2*R1*t+r1*t*t))*t;
t=sqrt(R1*R1-r1*r1);
r2=((t*R1/r1+r1)+sqrt(2*R1*t+R1*R1))/(R1*R1/(r1*r1)-1);

expandRate=r2/r1;
ringObj=disc;
ringObj.ballRs(1)=disc.ballR;
for i=1:layerNum-1
    disc.X=disc.X*expandRate;
    disc.Y=disc.Y*expandRate;
    disc.Z=disc.Z*expandRate;
    disc.R=disc.R*expandRate;
    disc=mfs.rotate(disc,'XY',dAngle/2);
    ringObj=mfs.combineObj(ringObj,disc);
    outerR=outerR*expandRate;
    ringObj.ballRs(i+1)=disc.R(1);
end
ringObj.R=ringObj.R/Rrate;
ringObj.ballRs=ringObj.ballRs/Rrate;

ringObj.dAngle=dAngle;
ringObj.innerR=innerR;
ringObj.outerR=outerR;
ringObj.Rrate=Rrate;
end