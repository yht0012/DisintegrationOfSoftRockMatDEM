%the code can run in Matlab
innerR=1;
layerNum=3;
minBallR=0.05;
Rrate=0.8;
figure
%ringObj=makeRing(innerR,layerNum,minBallR,Rrate);
%In MatDEM, you may change the above code to:
ringObj=f.run('fun/makeRing.m',innerR,layerNum,minBallR,Rrate);
fs.showObj(ringObj);