%此代码用于展示MatDEM提供的多个应用示例，将appId设为1到4
clear;
f.clearApp();
appFileNames{1}='app/UI_Roller_exported.m';
appFileNames{2}='app/UI_MaterialTraining_exported.m';
appFileNames{3}='app/UI_Demo_exported.m';
appFileNames{4}='app/UI_BoxModel.m';
appFileNames{5}='app/UI_Aerolite.m';

appId=1;%changed it from 1 to 5
isMenu=true;%true or false, whether show the default menu
app=f.runWinApp(appFileNames{appId},isMenu);