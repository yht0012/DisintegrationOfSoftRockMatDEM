%the code is used to calculate the normal force
function obj=normalContact(obj)
%----------------------move the balls----------------------
dt=obj.dT;%let the balls moved during a time step dt
m_Num=obj.mNum;
obj.totalT=obj.totalT+dt;%accumulate the time
dmX=dt*obj.mVX+0.5*(dt*dt)*(obj.mAX);%new displacement during this step
dmY=dt*obj.mVY+0.5*(dt*dt)*(obj.mAY);
dmZ=dt*obj.mVZ+0.5*(dt*dt)*(obj.mAZ);

obj.dis_mXYZ=obj.dis_mXYZ+[dmX,dmY,dmZ];
%if the accumulative displacement is greater than the grid threshold
%if the ball move out of the nBall range, redefine the nBall
if max(abs(obj.dis_mXYZ(:)))>obj.dSideRate*obj.dSide
    obj.dispNote(['balanceTime' num2str(obj.totalT) '->dis_m->setNearbyBall']);
    obj.setNearbyBall();
end
%new ball position-->
obj.aX(1:m_Num)=obj.aX(1:m_Num)+dmX;
obj.aY(1:m_Num)=obj.aY(1:m_Num)+dmY;
obj.aZ(1:m_Num)=obj.aZ(1:m_Num)+dmZ;
%----------------------end move the balls----------------------
%----------------------calculate initial inter-ball normal force----------------------
%I represents central ball and J represents nearby ball
nRow=ones(1,size(obj.nBall,2));%a row whose width is the same as nBall
%all nearby ball force-->
nIJX=obj.aX(obj.nBall)-obj.aX(1:m_Num)*nRow;%the relative displacement between central- and nearby balls
nIJY=obj.aY(obj.nBall)-obj.aY(1:m_Num)*nRow;
nIJZ=obj.aZ(obj.nBall)-obj.aZ(1:m_Num)*nRow;
nIJRsum=obj.aR(obj.nBall)+obj.aR(1:m_Num)*nRow;%sum the radiuses of the central- and connected balls, the code can be written in setNearby
nIJdis=sqrt(nIJX.*nIJX+nIJY.*nIJY+nIJZ.*nIJZ);%distance between nearby balls and central ball
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@deal with overlap@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%because the code allows overlap of elements, when two elements
%have the same coordinates, nIJdis will be zero, and result in
%error in the following calculation, in this case,
%nIJdis=1e-100, force between overlap elements will be zero
if max(nIJdis(:)==0)
    obj.dispNote('Overlap of elements in build.mo.balance()!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    nIJdis(nIJdis==0)=1e-100;
end
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@end deal with overlap@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
nIJXn=nIJdis-nIJRsum;%normal relative displacement
nXnorm=nIJX./nIJdis;nYnorm=nIJY./nIJdis;nZnorm=nIJZ./nIJdis;%normalized vector, i.e. length(X,Y,Z)==1

clear nIJX nIJY nIJZ nIJRsum nIJdis%clear data to save memory
if obj.isClump==1
    nIJXn=nIJXn+obj.nClump;
end

%nFN0=obj.nKNe.*nIJXn;%initial normal force between balls, the normal force should time filter later
eval(obj.FnCommand);

%----------------------end calculate initial inter-ball normal force----------------------
%Note: nFN0 record the normal forces between central balls and
%all nearby balls, including balls that not affect the central
%balls, real forces is the product of nFN0 and filters
%----------------------set compressive- and tensile force filters----------------------
obj.cFilter=(obj.nBall~=obj.aNum&nIJXn<-1e-14);%filter of compressive force, nXnIJ<0, -1e15 may error
%filter of tensile force-->
nBreakFI=obj.aBF(1:m_Num)*nRow;%breaking force of central ball, the code can be written in setNearby
nBreakFJ=obj.aBF(obj.nBall);%breaking force of nearby balls
nBreakF=min(nBreakFI,nBreakFJ).*obj.nBondRate;%the lower value of breaking force is used

bfilter=nFN0<nBreakF&obj.bFilter;%update intact bond filter, find the ball within the breaking strain, others are broken bonds
clear nBreakFI nBreakFJ;
if obj.isHeat==0
    clear nBreakF;
end
if obj.isClump==1
    bfilter=bfilter|(obj.nClump~=0);
end
tfilter=(obj.nBall~=obj.aNum&nIJXn>1e-14)&bfilter;%tensile bonds, the Xn is possitive
ctfilter=obj.cFilter|tfilter;%compressive or tensile
%----------------------end set compressive- and tensile force filters----------------------
nFN=nFN0.*ctfilter;%set factual normal force, the normal force may be changed when bonds break in shear mode
clear ctfilter;
mFXnew=0;mFYnew=0;mFZnew=0;%initialize the XYZ force components of balls
openFilter=obj.bFilter&(~bfilter);%bonds break in openning mode
%----------------------record crack----------------------
if obj.isCrack==1&&sum(openFilter(:))>0%record the imformation of crack to make movie
    [startIds,endIds]=fs.nFilter2Con(obj.nBall,openFilter);
    %record ball Ids of breaking bond, time, openning mode
    obj.status.breakId=[obj.status.breakId;gather(startIds),gather(endIds),ones(size(endIds))*[obj.totalT,1]];%not in GPU@@@@@@@@@@@@@@
    clear startIds endIds;
end
%----------------------end calculate inter-ball shear force----------------------

%----------------------calculate particle resultant force----------------------
%set the final normal force components,%XYZ components of force, used in class "modelStatus"
obj.nFnX=nFN.*nXnorm;clear nXnorm;
obj.nFnY=nFN.*nYnorm;clear nYnorm;
obj.nFnZ=nFN.*nZnorm;clear nZnorm nFN;%deal with isFailure later, 20180616

if isfield(obj.SET,'groupPair')%remove force between groupPair
    f=~obj.SET.gFilter;
    obj.nFnX=obj.nFnX.*f;
    obj.nFnY=obj.nFnY.*f;
    obj.nFnZ=obj.nFnZ.*f;
    clear f;
end
if isempty(obj.mVis)
    mVFXnew=-obj.mVisX.*obj.mVX;%calculate viscosity components of model balls-->
    mVFYnew=-obj.mVisY.*obj.mVY;
    mVFZnew=-obj.mVisZ.*obj.mVZ;
else
    mVFXnew=-obj.mVis.*obj.mVX;%calculate viscosity components of model balls-->
    mVFYnew=-obj.mVis.*obj.mVY;
    mVFZnew=-obj.mVis.*obj.mVZ;
end

mFXnew=mFXnew+sum(obj.nFnX,2)+mVFXnew+obj.mGX;%calculate net force components of model balls-->
mFYnew=mFYnew+sum(obj.nFnY,2)+mVFYnew+obj.mGY;%shear force has been added in "calculate inter-ball shear force"
mFZnew=mFZnew+sum(obj.nFnZ,2)+mVFZnew+obj.mGZ;

%----------------------calculate heat----------------------
%heat includes viscosity heat, breaking heat and slipping heat
if obj.isHeat==1%the heat when boundary bonds break is also calculated
    %------------------viscosity heat------------------
    visHeat=-0.5*((obj.mVFX+mVFXnew).*dmX+(obj.mVFY+mVFYnew).*dmY+(obj.mVFZ+mVFZnew).*dmZ);%
    obj.mVFX=mVFXnew;obj.mVFY=mVFYnew;obj.mVFZ=mVFZnew;%viscosity force
    clear mVFXnew mVFYnew mVFZnew dmX dmY dmZ;
    %obj.TAG.aHeat=obj.aHeat(1:m_Num,1);to be deleted
    %obj.TAG.visHeat=visHeat;to be deleted
    obj.aHeat(1:m_Num,1)=obj.aHeat(1:m_Num,1)+gather(visHeat);% @@@ 1 Viscosity Heat @@@
    clear visHeat;
    %------------------end viscosity heat------------------
    %------------------breaking heat------------------
    breakFilter=obj.bFilter&(~bfilter);%bonds that broken during this time step, also used in Heat calculation
    isBondBreak=sum(breakFilter(:))>0;
    if isBondBreak%if bond break, then calculate the breaking heat
        %when the bond breaks in tensile status, i.e. Xn>0,
        %energy of normal spring is converted into heat
        %--------------calculate breaking heat of normal spring--------------
        breakTFilter=breakFilter&obj.tFilter;%the bonds break in tensile status (not tensile mode),may result in error***** corrected on 2017.12.26 in setNearbyBall
        nBreakF2=nBreakF.*nBreakF;
        nIBall=(1:m_Num)'*nRow;%central ball matrix, each row has same value, used in Heat
        nBreakTHeat=0.5*nBreakF2./obj.aKN(nIBall).*breakTFilter;%heat of central balls, matrix
        obj.aHeat(1:m_Num,2)=obj.aHeat(1:m_Num,2)+sum(nBreakTHeat,2);% @@@ 2 Breaking Heat of Normal Spring @@@
        %--------------end calculate breaking heat of normal spring--------------
        %--------------calculate heat when boundary bond breaks, normal spring--------------
        breakbTFilter=breakTFilter&(obj.nBall>m_Num);%boundary bonds break in tensile status
        clear nBreakTHeat breakTFilter;
        nBreakbTHeat=0.5*nBreakF2./obj.aKN(obj.nBall).*breakbTFilter;%heat of boundary balls, matrix
        clear nBreakF2 breakbTFilter;
        %heat of boundary balls is recorded in row mNum+1
        obj.aHeat(m_Num+1,2)=obj.aHeat(m_Num+1,2)+sum(nBreakbTHeat(:));% @@@ 2 Breaking Heat of Normal Spring @@@
        %--------------end calculate heat when boundary bond breaks, normal spring--------------
    end
    clear nFS0;
end
clear nIJdSX nIJdSY nIJdSZ;
obj.bFilter=bfilter;obj.tFilter=tfilter;
clear bfilter tfilter;

mM1=1./obj.mM;%reciprocal of ball mass
mAXnew=mFXnew.*mM1;%acceloration-->
mAYnew=mFYnew.*mM1;
mAZnew=mFZnew.*mM1;
clear mFXnew mFYnew mFZnew;
obj.mVX=obj.mVX+0.5*dt*(obj.mAX+mAXnew);%velocity-->
obj.mVY=obj.mVY+0.5*dt*(obj.mAY+mAYnew);
obj.mVZ=obj.mVZ+0.5*dt*(obj.mAZ+mAZnew);
obj.mAX=mAXnew;
obj.mAY=mAYnew;
obj.mAZ=mAZnew;
clear mAXnew mAYnew mAZnew;

if obj.isFix==1
    obj.mAX(obj.FixXId)=0;obj.mAY(obj.FixYId)=0;obj.mAZ(obj.FixZId)=0;
    obj.mVX(obj.FixXId)=0;obj.mVY(obj.FixYId)=0;obj.mVZ(obj.FixZId)=0;
end
%----------------------end particle failure----------------------
%----------------------begin record additional data----------------------
if isfield(obj.SET,'balanceData')
    fNames=fieldnames(obj.SET.balanceData);%switch the fields
    for i=1:length(fNames)
        fName=fNames{i};
        obj.SET.balanceData.(fName)=gather(eval(fName));
    end
end
end