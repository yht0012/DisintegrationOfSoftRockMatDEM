function sFilter=applyRegionFilter(regionFilter,sX,sY)
%used in user_3DSlope2, user regionFilter to select elements
[imH,imW]=size(regionFilter);%get height and width
sNum=length(sX);
x1=min(sX);x2=max(sX);
y1=min(sY);y2=max(sY);
%find the coordinates of ball on the image
imBallI=floor((sX-x1)/(x2-x1)*(imW-1))+1;
imBallJ=floor((sY-y1)/(y2-y1)*(imH-1))+1;
sFilter=false(sNum,1);
for i=1:sNum
    sFilter(i)=regionFilter(imBallJ(i),imBallI(i));
end
end