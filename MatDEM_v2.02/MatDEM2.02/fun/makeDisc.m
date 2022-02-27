function disc=makeDisc(discR,ballR)
rate=1;%increase the radius of ball
circleNum=ceil(discR/(ballR*2/rate));
dCircleR=discR/circleNum;
X=0;Y=0;Z=0;R=ballR;
for i=1:circleNum
    circleR=i*dCircleR;
    circle=mfs.makeCircle(circleR,ballR);
    X=[X;circle.X];
    Y=[Y;circle.Y];
    Z=[Z;circle.Z];
    R=[R;circle.R];
end
disc.X=X;disc.Y=Y;disc.Z=Z;disc.R=R;
disc.discR=discR;disc.ballR=ballR;
end