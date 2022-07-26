%this code show how to continue a simulation
%load a data file first, and run the following code
B.setUIoutput();
d.calculateData()
addCircle=50;
totalCircle=totalCircle+addCircle;
d.tic(addCircle);
for i=i+1:totalCircle
    %@@@the following code is copied from the original code file@@@
    for j=1:100
        %---------computing
        d.balance();
        if mod(j,calGInterval)==6
            planetfs.resetmGXYZ(d);
            if B.SET.fastGroupModel==1
                planetfs.setGroupOuterGravitation(d,{'earth','sphere2','box'});
            else
                planetfs.setModelGravitation(d);
            end
        end
        
        %---------limit space
        sphereR=B.SET.spaceSize*sqrt(2)/2;
        planetfs.limitElementInSphere(d,sphereR);
        
        %---------record data
        if mod(j,recordInterval)==0
            groupCenter=planetfs.getGroupCenter(d);
            earthCenter=[earthCenter;groupCenter.earth];
            sphere2Center=[sphere2Center;groupCenter.sphere2];
            boxCenter=[boxCenter;groupCenter.box];
            d.recordStatus();
        end
    end
    %---------show the result
    d.figureNumber=d.show(showType);
    view(0,90);
    plot3(earthCenter(:,1),earthCenter(:,2),earthCenter(:,3),'-b');
    plot3(sphere2Center(:,1),sphere2Center(:,2),sphere2Center(:,3),'-r');
    plot3(boxCenter(:,1),boxCenter(:,2),boxCenter(:,3),'-k');
    
    save([fName num2str(i) '.mat']);
    pause(0.05);
end

d.mo.setGPU('off');
d.clearData(1);
d.recordCalHour('BoxCrush3Finish');
save(['TempModel/' B.name '3.mat'],'d');
save(['TempModel/' B.name '3R' num2str(B.ballR) '-' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
d.calculateData();