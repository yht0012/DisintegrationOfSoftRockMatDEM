function obj=make3DLine(lineX,lineY,lineZ,ballR,Rrate)
ballR0=ballR;
ballR=ballR0*Rrate;
lineL=sqrt((lineX(2)-lineX(1))^2+(lineY(2)-lineY(1))^2+(lineZ(2)-lineZ(1))^2);
num=ceil(lineL/(ballR*2))+1;
dX=(lineX(2)-lineX(1))/num;
dY=(lineY(2)-lineY(1))/num;
dZ=(lineZ(2)-lineZ(1))/num;

obj.X=lineX(1)+dX*(0:num)';
obj.Y=lineY(1)+dY*(0:num)';
obj.Z=lineZ(1)+dZ*(0:num)';
obj.R=ones(num+1,1)*ballR0;
end