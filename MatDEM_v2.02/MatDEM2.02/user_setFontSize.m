%用于改变主程序字体大小，运行以增大字体
%used to change the font size
h=f.getHandles()
fontSize=14;
tableWidth=100;
h.edit_allCommand.FontSize=fontSize;%font size of comand editor
h.uitable_Para.FontSize=fontSize;%font size of data viewer
h.uitable1.FontSize=fontSize;%font size of left parameter list
h.edit_output.FontSize=fontSize;%font size of left parameter list

W=num2cell(ones(1,10)*tableWidth);
h.uitable_Para.ColumnWidth=W;