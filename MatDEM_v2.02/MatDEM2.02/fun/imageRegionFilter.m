function regionFilter=image2RegionFilter(fileName,imH,imW)
%used in user_3DSlope2,
%change black-white image to imH*imW filter, black is 0, white is 1
source=imread(fileName);
source = imresize(source,[imH,imW]);
sumS=flipud(sum(source,3));
regionFilter=sumS==0;
end