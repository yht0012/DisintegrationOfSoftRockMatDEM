function filter=getColumnFilter(X,Y,Z,dipD,dipA,radius,height)
%rotate the model
dipD=dipD*pi/180;dipA=dipA*pi/180;
%rotate anticlosewise on XY plane
mX=X*cos(dipD)+Y*cos(pi/2+dipD)+Z*0;
mY=X*cos(pi/2-dipD)+Y*cos(dipD)+Z*0;
mZ=X*0+Y*0+Z*1;
%incline to -Y
mX=mX*1+mY*0+Z*0;
mY=mX*0+mY*cos(dipA)+mZ*cos(pi/2+dipA);
mZ=mX*0+mY*cos(pi/2-dipA)+mZ*cos(dipA);
%layered, strong first
cx=(max(mX)+min(mX))/2;
cy=(max(mY)+min(mY))/2;
cz=(max(mZ)+min(mZ))/2;
columnFilter1=(mX-cx).^2+(mY-cy).^2<radius^2;
columnFilter2=mZ-cz<height/2&mZ-cz>-height/2;
filter=columnFilter1&columnFilter2;
end