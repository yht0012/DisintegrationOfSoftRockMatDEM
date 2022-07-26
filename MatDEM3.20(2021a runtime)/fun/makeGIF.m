function fName=makeGIF(fName,indexBegin,interval,indexEnd,GIFType)
figure;
setappdata(0,'simpleFigure',0);%show axis and title
list=indexBegin:interval:indexEnd;
GIFFigureNumber=1;
for showIndex=1:length(list)
    fs.disp(['Step: ' num2str(showIndex) '/' num2str(length(list))]);
    load([fName num2str(list(showIndex)) '.mat']);%load the saved file
    d.calculateData();%calculate the data of the model
    d.mo.setGPU('off');
    
    %d.showFilter('SlideY',0.5,1);%cut the model if necessary
    d.showB=3;%show the frame
    d.isUI=0;
    d.figureNumber=GIFFigureNumber;
    h=d.show(GIFType);%show the result    
    xlim([0,B.sampleW]);
    zlim([0,B.sampleH]);
    
    %view(10*showCircle,30);%change the camera position
    set(gcf,'Position',[10,10,1000,1000]);%set the size of the figure
    str={['MatDEM' num2str(basicfs.version)]; [num2str(d.mo.totalT) 's'];['width:' num2str(B.sampleW) 'm']};
    text(0,0,B.sampleH-B.ballR*2,str,'VerticalAlignment','top');
    
    frames(showIndex)=getframe();%record the figure
    pause(0.2);%pause 0.1 second
end
close(h);%close the figure
dTime=0.3;%time step of GIF
fs.movie2gif([fName(11:end) GIFType '1.gif'],frames,dTime);%save the gif;
end