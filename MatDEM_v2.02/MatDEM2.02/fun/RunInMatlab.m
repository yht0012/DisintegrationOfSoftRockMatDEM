%this code shows how to run function in matlab
%open the file in matlab and set type=1; and run the code
%then open the file in MatDEM and set type=2; run the code, and it will get
%the same result.
clear;
type=2;
%run in matlab
if type==1
ringObj=makeRing(0.1,3,0.01,0.6);
else
%run in MatDEM
ringObj=f.run('fun/makeRing.m',0.1,3,0.01,0.6);
end
ringObj3D=mfs.make3Dfrom2D(ringObj,0.6,0.01);

ringObj3D=mfs.move(ringObj3D,0.5,0.5,0.5);
ringObj3D=mfs.rotate(ringObj3D,'YZ',60);%rotate the object and then move it

figure
subplot(1,2,1);
fs.showObj(ringObj);
subplot(1,2,2);
fs.showObj(ringObj3D);