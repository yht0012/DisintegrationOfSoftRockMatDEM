function obj=makeHelicalLine(outerR,curveHeight,circle,ballR,Rrate)
totalAngle=2*pi*circle;
r=outerR-ballR;
h=curveHeight-ballR*2;
curveL=sqrt((totalAngle*r)^2+h*h);
ballR2=ballR*Rrate;
ballNum=ceil(curveL/(ballR2*2));

dAngle=totalAngle/ballNum;

A=(0:dAngle:totalAngle)';
obj.X=cos(A)*r;
obj.Y=sin(A)*r;
obj.Z=(0:(h/ballNum):h)'+ballR;
obj.R=ones(size(obj.X))*ballR;
end

