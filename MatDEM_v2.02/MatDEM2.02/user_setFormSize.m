%used to change the form size, when the top portion of the form is not shown
moveY=-1;%moving distance
h=f.getHandles()
h.uitable1.Position(4)=h.uitable1.Position(4)+moveY;
h.togglebutton_File.Position(2)=h.togglebutton_File.Position(2)+moveY;
h.togglebutton_Para.Position(2)=h.togglebutton_Para.Position(2)+moveY;

h.uipanel_File.Position(4)=h.uipanel_File.Position(4)+moveY;
h.uipanel_Para.Position(4)=h.uipanel_Para.Position(4)+moveY;

h.edit_allCommand.Position(4)=h.edit_allCommand.Position(4)+moveY;
h.uitable_Para.Position(4)=h.uitable_Para.Position(4)+moveY;

newY=h.pushbutton_FileBack.Position(2)+moveY;
h.pushbutton_FileBack.Position(2)=newY;
h.togglebutton_File1.Position(2)=newY;
h.togglebutton_File2.Position(2)=newY;
h.togglebutton_File3.Position(2)=newY;
h.togglebutton_File4.Position(2)=newY;
h.togglebutton_File5.Position(2)=newY;
h.togglebutton_File6.Position(2)=newY;
h.pushbutton_FileForward.Position(2)=newY;
h.pushbutton_FileExit.Position(2)=newY;

newY=h.pushbutton_ParaBack.Position(2)+moveY;
h.pushbutton_ParaBack.Position(2)=newY;
h.togglebutton_Para1.Position(2)=newY;
h.togglebutton_Para2.Position(2)=newY;
h.togglebutton_Para3.Position(2)=newY;
h.togglebutton_Para4.Position(2)=newY;
h.togglebutton_Para5.Position(2)=newY;
h.togglebutton_Para6.Position(2)=newY;
h.pushbutton_ParaForward.Position(2)=newY;
h.pushbutton_ParaExit.Position(2)=newY;

h.pushbutton_openFolder.Position(2)=h.pushbutton_openFolder.Position(2)+moveY;
h.pushbutton_refresh.Position(2)=h.pushbutton_refresh.Position(2)+moveY;
h.listbox_files.Position(4)=h.listbox_files.Position(4)+moveY;
%