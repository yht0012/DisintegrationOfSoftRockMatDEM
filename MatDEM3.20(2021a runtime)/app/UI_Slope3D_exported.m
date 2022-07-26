classdef UI_Slope3D < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        Figure_WinMain                  matlab.ui.Figure
        TabGroup_Modules                matlab.ui.container.TabGroup
        Tab_PreProcessingModule         matlab.ui.container.Tab
        Panel_LoadElevationData         matlab.ui.container.Panel
        Button_LoadElevationDataBefore  matlab.ui.control.Button
        Button_LoadElevationDataAfter   matlab.ui.control.Button
        Label_ElevationDataBeforeName   matlab.ui.control.Label
        Label_ElevationDataAfterName    matlab.ui.control.Label
        Button_CheckElevationDataBefore  matlab.ui.control.Button
        Button_CheckElevationDataAfter  matlab.ui.control.Button
        UIAxes_PlottingAreaPre          matlab.ui.control.UIAxes
        Panel_Generate3DMeshgrid        matlab.ui.container.Panel
        Label_2                         matlab.ui.control.Label
        NumericEditField_RotationAngle  matlab.ui.control.NumericEditField
        Button_RotateElevationData      matlab.ui.control.Button
        Button_GenerateMeshgrid         matlab.ui.control.Button
        Button_SaveMeshgrid             matlab.ui.control.Button
        Label_3                         matlab.ui.control.Label
        NumericEditField_MeshgridInterval  matlab.ui.control.NumericEditField
        Tab_Step0                       matlab.ui.container.Tab
        Panel_Create3DSurfaces          matlab.ui.container.Panel
        Label_4                         matlab.ui.control.Label
        NumericEditField_BallRadius0    matlab.ui.control.NumericEditField
        Label_5                         matlab.ui.control.Label
        NumericEditField_AdditionalDepthBeneath  matlab.ui.control.NumericEditField
        Label_6                         matlab.ui.control.Label
        NumericEditField_AdditionalLayerNumberAbove  matlab.ui.control.NumericEditField
        Label_7                         matlab.ui.control.Label
        NumericEditField_WallElementLayerNumber  matlab.ui.control.NumericEditField
        Label_8                         matlab.ui.control.Label
        NumericEditField_BottomShellLayerNumber  matlab.ui.control.NumericEditField
        Label_9                         matlab.ui.control.Label
        NumericEditField_TopShellLayerNumber  matlab.ui.control.NumericEditField
        Button_CreateSurfaces           matlab.ui.control.Button
        Button_SaveSurfaces             matlab.ui.control.Button
        Button_LoadMeshgridData         matlab.ui.control.Button
        Label_MeshgridDataName          matlab.ui.control.Label
        Table_SurfacesData0             matlab.ui.control.Table
        UIAxes_PlottingArea0            matlab.ui.control.UIAxes
        Tab_Step1                       matlab.ui.container.Tab
        Panel_InitialModeling           matlab.ui.container.Panel
        Button_LoadSurfacesData         matlab.ui.control.Button
        Label_SurfacesDataName          matlab.ui.control.Label
        Label_10                        matlab.ui.control.Label
        EditField_ModelName             matlab.ui.control.EditField
        Label_11                        matlab.ui.control.Label
        NumericEditField_DistributionRate  matlab.ui.control.NumericEditField
        CheckBox_isClump                matlab.ui.control.CheckBox
        Label_12                        matlab.ui.control.Label
        NumericEditField_BallRadius1    matlab.ui.control.NumericEditField
        Button_BuildInitialModel        matlab.ui.control.Button
        Button_GravitySediment          matlab.ui.control.Button
        Button_Save1                    matlab.ui.control.Button
        Label_13                        matlab.ui.control.Label
        Spinner_RandomSeed              matlab.ui.control.Spinner
        Button_PostProcessingModule1    matlab.ui.control.Button
        Label_15                        matlab.ui.control.Label
        NumericEditField_TimeRate       matlab.ui.control.NumericEditField
        Label_16                        matlab.ui.control.Label
        EditField_FileName1             matlab.ui.control.EditField
        CheckBox_AutoTimeRate           matlab.ui.control.CheckBox
        UIAxes_PlottingArea1            matlab.ui.control.UIAxes
        Table_LayersData                matlab.ui.control.Table
        Tab_Step2                       matlab.ui.container.Tab
        Panel_CuttingModelAndSettingMaterials  matlab.ui.container.Panel
        Button_LoadGeometricalModel     matlab.ui.control.Button
        Label_GeometricalModelName      matlab.ui.control.Label
        Button_RemoveTopShell           matlab.ui.control.Button
        CheckBox_ifCalcuBeyondSlope     matlab.ui.control.CheckBox
        Button_LoadSlopeShadow          matlab.ui.control.Button
        Button_BalanceBondedModel       matlab.ui.control.Button
        Button_LoadMaterials            matlab.ui.control.Button
        Button_GroupingAndSetMaterials  matlab.ui.control.Button
        Button_GenerateFinalModel       matlab.ui.control.Button
        Label_17                        matlab.ui.control.Label
        EditField_FileName2             matlab.ui.control.EditField
        Button_Save2                    matlab.ui.control.Button
        Button_PostProcessingModule2    matlab.ui.control.Button
        Label_18                        matlab.ui.control.Label
        NumericEditField_ViscosityRate2  matlab.ui.control.NumericEditField
        CheckBox_AutoViscosityRate2     matlab.ui.control.CheckBox
        Label_19                        matlab.ui.control.Label
        NumericEditField_ShadowWidth    matlab.ui.control.NumericEditField
        Label_20                        matlab.ui.control.Label
        NumericEditField_ShadowHeight   matlab.ui.control.NumericEditField
        UIAxes_PlottingArea2            matlab.ui.control.UIAxes
        Table_GroupsData                matlab.ui.control.Table
        Tab_Step3                       matlab.ui.container.Tab
        Panel_IterativeCalculation      matlab.ui.container.Panel
        Button_LoadFinalModel           matlab.ui.control.Button
        Label_FinalModelName            matlab.ui.control.Label
        CheckBox_isShear                matlab.ui.control.CheckBox
        CheckBox_isHeat                 matlab.ui.control.CheckBox
        Label_21                        matlab.ui.control.Label
        NumericEditField_TimeStepRate   matlab.ui.control.NumericEditField
        Label_22                        matlab.ui.control.Label
        NumericEditField_ViscosityRate3  matlab.ui.control.NumericEditField
        Label_23                        matlab.ui.control.Label
        NumericEditField_TotalCycle     matlab.ui.control.NumericEditField
        Button_StartCalculation         matlab.ui.control.Button
        Label_24                        matlab.ui.control.Label
        EditField_FileName3             matlab.ui.control.EditField
        Button_Save3                    matlab.ui.control.Button
        Button_PostProcessingModule3    matlab.ui.control.Button
        UIAxes_PlottingArea3            matlab.ui.control.UIAxes
        Table_EnergyAndHeatData         matlab.ui.control.Table
        Label                           matlab.ui.control.Label
        EditField_CommandLine           matlab.ui.control.EditField
        Button_Run                      matlab.ui.control.Button
        TextArea_Message                matlab.ui.control.TextArea
    end

    
    properties (Access = public)
        Settings;
        Box;
        DataCenter;
        OtherData;
    end
    

    methods (Access = private)x

        % Code that executes after component creation
        function startupFcn(app)
            app.Settings=[];
            app.Box=[];
            app.DataCenter=[];
            app.OtherData=[];
            app.Settings.PlottingAreaParentHandle=app.Tab_PreProcessingModule;
            app.Settings.PlottingAreaParentPosition=app.Tab_PreProcessingModule.Position;
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingAreaPre;
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingAreaPre.Position;
            app.Settings.OutputFocus=app.TextArea_Message;
            setappdata(0,'app',app);
            setappdata(0,'CurrentWindow',1);
        end

        % Button pushed function: Button_LoadElevationDataBefore
        function Button_LoadElevationDataBeforeButtonPushed(app, event)
            [file,path]=uigetfile('slope\*.txt');
            try
                if ~contains(file,'.txt')
                    msgbox('当前仅支持打开.txt格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            app.OtherData.DataBefore=load([path,file]);
            app.Label_ElevationDataBeforeName.Text=['已导入',file];
            app.TextArea_Message.Value=['已导入数据文件：',path,file;app.TextArea_Message.Value];
            app.Button_CheckElevationDataBefore.Enable='on';
            if strcmp(app.Button_CheckElevationDataBefore.Enable,'on')&&strcmp(app.Button_CheckElevationDataAfter.Enable,'on')
                app.Button_RotateElevationData.Enable='on';
            end
        end

        % Button pushed function: Button_LoadElevationDataAfter
        function Button_LoadElevationDataAfterButtonPushed(app, event)
            [file,path]=uigetfile('slope\*.txt');
            try
                if ~contains(file,'.txt')
                    msgbox('当前仅支持打开.txt格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            app.OtherData.DataAfter=load([path,file]);
            app.Label_ElevationDataAfterName.Text=['已导入',file];
            app.TextArea_Message.Value=['已导入数据文件：',path,file;app.TextArea_Message.Value];
            app.Button_CheckElevationDataAfter.Enable='on';
            if strcmp(app.Button_CheckElevationDataBefore.Enable,'on')&&strcmp(app.Button_CheckElevationDataAfter.Enable,'on')
                app.Button_RotateElevationData.Enable='on';
            end
        end

        % Button pushed function: Button_RotateElevationData
        function Button_RotateElevationDataButtonPushed(app, event)
            DataBefore=app.OtherData.DataBefore;
            DataAfter=app.OtherData.DataAfter;
            X1=DataBefore(:,1);
            Y1=DataBefore(:,2);
            X2=DataAfter(:,1);
            Y2=DataAfter(:,2);
            [X1,Y1]=mfs.rotateIJ(X1,Y1,app.NumericEditField_RotationAngle.Value);
            [X2,Y2]=mfs.rotateIJ(X2,Y2,app.NumericEditField_RotationAngle.Value);
            DataBefore(:,1)=X1;
            DataBefore(:,2)=Y1;
            DataAfter(:,1)=X2;
            DataAfter(:,2)=Y2;
            app.TextArea_Message.Value=['已在水平面内将高程数据旋转',num2str(app.NumericEditField_RotationAngle.Value),'度';app.TextArea_Message.Value];
            app.OtherData.DataBefore=DataBefore;
            app.OtherData.DataAfter=DataAfter;
            app.Button_GenerateMeshgrid.Enable='on';
        end

        % Button pushed function: Button_GenerateMeshgrid
        function Button_GenerateMeshgridButtonPushed(app, event)
            DataBefore=app.OtherData.DataBefore;
            DataAfter=app.OtherData.DataAfter;
            X1=DataBefore(:,1);
            Y1=DataBefore(:,2);
            Z1=DataBefore(:,3);
            X2=DataAfter(:,1);
            Y2=DataAfter(:,2);
            Z2=DataAfter(:,3);
            minX=min(min(X1),min(X2));
            minY=min(min(Y1),min(Y2));
            X1=X1-minX;
            Y1=Y1-minY;
            X2=X2-minX;
            Y2=Y2-minY;
            minX=min(min(X1),min(X2));
            minY=min(min(Y1),min(Y2));
            maxX=max(max(X1),max(X2));
            maxY=max(max(Y1),max(Y2));
            F1=scatteredInterpolant(X1,Y1,Z1,'natural','nearest');
            F2=scatteredInterpolant(X2,Y2,Z2,'natural','nearest');
            [x,y]=meshgrid(minX:app.NumericEditField_MeshgridInterval.Value:maxX,minY:app.NumericEditField_MeshgridInterval.Value:maxY);
            z1=F1(x,y);
            z2=F2(x,y);
            zavg=(z1+z2)/2;
            dz=z2-z1;
            DetailLevel=6; %细节等级，0最低，10最高。
            mesh(app.UIAxes_PlottingAreaPre,x(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),zavg(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),ones(size(dz(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))));
            axis(app.UIAxes_PlottingAreaPre,'equal');
            grid(app.UIAxes_PlottingAreaPre,'on');
            title(app.UIAxes_PlottingAreaPre,'三维格网');
            colorbar(app.UIAxes_PlottingAreaPre);
            view(app.UIAxes_PlottingAreaPre,60,30);
            S.X=x;
            S.Y=y;
            S.Z1=z1;
            S.Z2=z2;
            app.TextArea_Message.Value=['已生成三维格网';app.TextArea_Message.Value];
            app.OtherData.S=S;
            app.Button_SaveMeshgrid.Enable='on';
        end

        % Button pushed function: Button_SaveMeshgrid
        function Button_SaveMeshgridButtonPushed(app, event)
            [file,path]=uiputfile('slope\Temp3DMeshgrid.mat');
            S=app.OtherData.S;
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'S');
                app.TextArea_Message.Value=['已将三维格网保存为：',path,file;app.TextArea_Message.Value];
            end
        end

        % Button pushed function: Button_CheckElevationDataBefore
        function Button_CheckElevationDataBeforeButtonPushed(app, event)
            DataBefore=app.OtherData.DataBefore;
            X=DataBefore(:,1);
            Y=DataBefore(:,2);
            Z=DataBefore(:,3);
            figure;
            scatter3(X,Y,Z,ones(size(Z)),Z,'.');
            axis equal;
            grid on;
            title('滑坡前高程数据');
            colorbar;
            view(60,30);
        end

        % Button pushed function: Button_CheckElevationDataAfter
        function Button_CheckElevationDataAfterButtonPushed(app, event)
            DataAfter=app.OtherData.DataAfter;
            X=DataAfter(:,1);
            Y=DataAfter(:,2);
            Z=DataAfter(:,3);
            figure;
            scatter3(X,Y,Z,ones(size(Z)),Z,'.');
            axis equal;
            grid on;
            title('滑坡后高程数据');
            colorbar;
            view(60,30);
        end

        % Button pushed function: Button_LoadMeshgridData
        function Button_LoadMeshgridDataButtonPushed(app, event)
            [file,path]=uigetfile('slope\*.mat');
            try
                if ~contains(file,'.mat')
                    msgbox('当前仅支持打开.mat格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            load([path,file]);
            app.Label_MeshgridDataName.Text=['已导入',file];
            app.TextArea_Message.Value=['已导入数据文件：',path,file;app.TextArea_Message.Value];
            app.OtherData.S=S;
            app.Button_CreateSurfaces.Enable='on';
            f.ChangePlottingAreaParent(app.Tab_Step0);
            f.ChangePlottingArea(app.UIAxes_PlottingArea0);
        end

        % Button pushed function: Button_CreateSurfaces
        function Button_CreateSurfacesButtonPushed(app, event)
            ballR=app.NumericEditField_BallRadius0.Value;
            shellTNum=app.NumericEditField_WallElementLayerNumber.Value;
            additionalDepth=app.NumericEditField_AdditionalDepthBeneath.Value;
            surfPackNum=ceil(additionalDepth/(2*ballR));
            surfPackNum2=app.NumericEditField_AdditionalLayerNumberAbove.Value;
            botPackNum=app.NumericEditField_BottomShellLayerNumber.Value;
            topPackNum=app.NumericEditField_TopShellLayerNumber.Value;
            C=Tool_Cut();
            C.SET.ballR=ballR;
            C.SET.shellTNum=shellTNum;
            C.SET.additionalDepth=additionalDepth;
            C.SET.surfPackNum=surfPackNum;
            C.SET.surfPackNum2=surfPackNum2;
            C.SET.botPackNum=botPackNum;
            C.SET.topPackNum=topPackNum;
            S=app.OtherData.S;
            interval=S.Y(2)-S.Y(1);
            X1cut=floor(0/interval); X2cut=floor(120/interval);
            Y1cut=floor(160/interval); Y2cut=floor(200/interval);
            S.X=S.X(1+Y1cut:end-Y2cut,1+X1cut:end-X2cut);
            S.Y=S.Y(1+Y1cut:end-Y2cut,1+X1cut:end-X2cut);
            S.Z1=S.Z1(1+Y1cut:end-Y2cut,1+X1cut:end-X2cut);
            S.Z2=S.Z2(1+Y1cut:end-Y2cut,1+X1cut:end-X2cut);
            S.X=S.X-min(S.X(:));
            S.Y=S.Y-min(S.Y(:));
            S.dZ=S.Z2-S.Z1;
            S0.name='S0';
            S0.X=S.X; S0.Y=S.Y; S0.Z=S.Z1;
            S0min=S;
            S0min.name='S0min';
            S0min.Z=min(S.Z1,S.Z2);
            S_bot=mfs.moveMeshGrid(S0min,-2*ballR*(surfPackNum+botPackNum));
            S_bot.name='Sbot';
            S_bot0=mfs.moveMeshGrid(S_bot,2*ballR*botPackNum);
            S_bot0.name='Sbot0';
            S_top=mfs.moveMeshGrid(S0,2*ballR*(surfPackNum2+topPackNum));
            S_top.name='Stop';
            topRate=0.3;
            dZ=max(S_top.Z(:))-min(S_top.Z(:));
            topFilter=S_top.Z>max(S_top.Z(:))-topRate*dZ;
            topAdditionalHeight=100;
            topZ=S_top.Z(topFilter);
            dTopZ=topAdditionalHeight*(topZ-min(topZ))/(topRate*dZ);
            S_top.Z(topFilter)=S_top.Z(topFilter)+dTopZ;
            S_top0=mfs.moveMeshGrid(S_top,-2*ballR*topPackNum);
            S_top0.name='Stop0';
            S_source=S0;
            S_source.name='Ssource';
            S_source.Z=S.Z2;
            [imageHeight,imageWidth]=size(S.X);
            sourceFilter=mfs.image2RegionFilter('slope/lps_slopesource.png',imageHeight,imageWidth);
            S_source.Z(~sourceFilter)=max(S_source.Z(:))+100;
            S_source.Z(sourceFilter)=S_source.Z(sourceFilter)-ballR;
            C.addSurf(S_bot,'S_bot');
            C.addSurf(S_bot0,'S_bot0');
            C.addSurf(S0,'S0');
            C.addSurf(S_top0,'S_top0');
            C.addSurf(S_top,'S_top');
            C.addSurf(S_source,'S_source');
            C.addSurf(S0min,'S0min');
            C.SET.S=S;
            C.SET.sampleThickness=max(abs(S.dZ(:)))+additionalDepth;
            TempCell=struct2cell(C.SurfId);
            TempMat=cell2mat(TempCell);
            scatter3(app.UIAxes_PlottingArea0,[0,0],[0,0],[mean(C.SurfData.S0.Z),mean(C.SurfData.S0.Z)],[0.001,0.001],[min(TempMat),max(TempMat)],'.');
            app.Table_SurfacesData0.Data=[];
            DetailLevel=6; %细节等级，0最低，10最高。
            TempHandles(C.SurfId.S_bot)=surface(app.UIAxes_PlottingArea0,S_bot.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_bot.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_bot.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S_bot*ones(size(S_bot.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S_bot,'S_bot',true}];
            TempHandles(C.SurfId.S_bot0)=surface(app.UIAxes_PlottingArea0,S_bot0.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_bot0.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_bot0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S_bot0*ones(size(S_bot0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S_bot0,'S_bot0',true}];
            TempHandles(C.SurfId.S0)=surface(app.UIAxes_PlottingArea0,S0.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S0.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S0*ones(size(S0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S0,'S0',true}];
            TempHandles(C.SurfId.S_top0)=surface(app.UIAxes_PlottingArea0,S_top0.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_top0.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_top0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S_top0*ones(size(S_top0.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S_top0,'S_top0',true}];
            TempHandles(C.SurfId.S_top)=surface(app.UIAxes_PlottingArea0,S_top.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_top.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_top.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S_top*ones(size(S_top.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S_top,'S_top',true}];
            TempHandles(C.SurfId.S_source)=surface(app.UIAxes_PlottingArea0,S_source.X(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_source.Y(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),S_source.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end),C.SurfId.S_source*ones(size(S_source.Z(1:1+round((end-1)/100)*(10-DetailLevel):end,1:1+round((end-1)/100)*(10-DetailLevel):end))),'LineStyle','none');
            app.Table_SurfacesData0.Data=[app.Table_SurfacesData0.Data;{C.SurfId.S_source,'S_source',true}];
            axis(app.UIAxes_PlottingArea0,'equal');
            axis(app.UIAxes_PlottingArea0,'manual');
            grid(app.UIAxes_PlottingArea0,'on');
            title(app.UIAxes_PlottingArea0,'三维层面');
            view(app.UIAxes_PlottingArea0,60,30);
            app.TextArea_Message.Value=['已创建三维层面';app.TextArea_Message.Value];
            app.OtherData.C=C;
            app.OtherData.TempHandles=TempHandles;
            app.Button_SaveSurfaces.Enable='on';
        end

        % Button pushed function: Button_SaveSurfaces
        function Button_SaveSurfacesButtonPushed(app, event)
            [file,path]=uiputfile('slope/TempSurfaces.mat');
            C=app.OtherData.C;
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'C');
                app.TextArea_Message.Value=['已将三维层面保存为：',path,file;app.TextArea_Message.Value];
            end
        end

        % Cell edit callback: Table_SurfacesData0
        function Table_SurfacesData0CellEdit(app, event)
            indices = event.Indices;
            newData = event.NewData;
            TempHandles=app.OtherData.TempHandles;
            if newData==true
                set(TempHandles(app.Table_SurfacesData0.Data{indices(1),1}),'Visible','on');
            else
                set(TempHandles(app.Table_SurfacesData0.Data{indices(1),1}),'Visible','off');
            end
        end

        % Button pushed function: Button_LoadSurfacesData
        function Button_LoadSurfacesDataButtonPushed(app, event)
            [file,path]=uigetfile('slope\*.mat');
            try
                if ~contains(file,'.mat')
                    msgbox('当前仅支持打开.mat格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            load([path,file]);
            app.Label_SurfacesDataName.Text=['已导入',file];
            app.TextArea_Message.Value=['已导入数据文件：',path,file;app.TextArea_Message.Value];
            app.OtherData.C=C;
            app.NumericEditField_BallRadius1.Value=C.SET.ballR;
            app.NumericEditField_BallRadius1.Editable='off';
            app.Button_BuildInitialModel. Enable='on';
            f.ChangePlottingAreaParent(app.Tab_Step1);
            f.ChangePlottingArea(app.UIAxes_PlottingArea1);
        end

        % Button pushed function: Button_BuildInitialModel
        function Button_BuildInitialModelButtonPushed(app, event)
            C=app.OtherData.C;
            fs.randSeed(app.Spinner_RandomSeed.Value);
            B=obj_Box;
            B.name=app.EditField_ModelName.Value;
            B.GPUstatus='auto';
            B.ballR=app.NumericEditField_BallRadius1.Value;
            B.distriRate=app.NumericEditField_DistributionRate.Value;
            B.isClump=app.CheckBox_isClump.Value;
            S_top=C.SurfData.S_top;
            boxWidth=max(S_top.X(:));
            boxLength=max(S_top.Y(:));
            boxHeight=max(S_top.Z(:))*1.1;
            B.sampleW=boxWidth;
            B.sampleL=boxLength;
            B.sampleH=boxHeight;
            B.platenStatus(:)=0;
            %B.setUIoutput(app.TextArea_Message);
            B.buildModel();
            B.createSample();
            B.sample.R=B.sample.R*2^(1/12);
            S_Bbot=C.SurfData.S_bot;
            S_Bbot.Z=S_Bbot.Z-4*B.ballR;
            S_Btop=C.SurfData.S_top;
            S_Btop.Z=S_Btop.Z+0.8*(max(S_top.Z)-min(S_top.Z));
            B.addSurf(C.SurfData.S_bot);
            B.addSurf(C.SurfData.S_top);
            B.addSurf(S_Bbot);
            B.addSurf(S_Btop);
            B.cutGroup({'sample','botB','topB'},1,2);
            B.cutGroup({'lefB','rigB','froB','bacB'},3,4);
            B.finishModel();
            B.setSoftMat();
            B.d=B.exportModel();
            d=B.d;
            d.mo.isShear=0;
            C.d=d;
            ID=C.SurfId;
            groupNames={'botShell','slopeBody','addedBody','topShell'};
            C.setLayer({'sample'},[ID.S_bot,ID.S_bot0,ID.S0,ID.S_top0,ID.S_top],groupNames);
            d.makeModelByGroups(groupNames);
            d.defineWallElement('botShell');
            d.mo.aR(d.GROUP.botShell)=B.ballR*1.3;
            mo=d.mo;
            mo.isFix=1;
            groupId_top=d.getGroupId('topShell');
            mo.FixXId=groupId_top;
            mo.FixYId=groupId_top;
            mo.FixZId=groupId_top;
            nBall=d.mo.nBall;
            bcFilter=sum(nBall>d.mNum&nBall~=d.aNum,2)>0;
            gFilter=false(size(bcFilter));
            gFilter(groupId_top)=true;
            mo.aR(groupId_top)=B.ballR;
            mo.aR(gFilter&(~bcFilter))=1.3*B.ballR;
            d.setClump('topShell');
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aR');
            app.Table_LayersData.Data=[];
            app.Table_LayersData.Data=[{'botShell',true};{'slopeBody',true};{'addedBody',true};{'topShell',true}];
            fs.disp('已建立初始模型');
            B.SET.C=C;
            app.Box=B;
            app.DataCenter=d;
            app.NumericEditField_TimeRate.Value=round(C.SET.sampleThickness/B.sampleH*100000)/100000;
            app.CheckBox_AutoTimeRate.Enable='on';
            app.Button_GravitySediment.Enable='on';
            app.Button_PostProcessingModule1.Enable='on';
        end

        % Button pushed function: Button_GravitySediment
        function Button_GravitySedimentButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            B.uniformGRate=1;
            d.mo.setGPU('auto');
            B.gravitySediment(app.NumericEditField_TimeRate.Value);
            d.mo.setGPU('off');
            d.mo.FixZId=[];
            d.mo.dT=d.mo.dT*4;
            d.mo.setGPU('auto');
            d.balance('Standard',app.NumericEditField_TimeRate.Value);
            d.mo.setGPU('off');
            d.mo.dT=d.mo.dT/4;
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aR');
            app.Table_LayersData.Data=[];
            app.Table_LayersData.Data=[{'botShell',true};{'slopeBody',true};{'addedBody',true};{'topShell',true}];
            fs.disp('已重力沉积');
            app.Box=B;
            app.DataCenter=d;
            app.EditField_FileName1.Value=[B.name,'1'];
            app.Button_Save1.Enable='on';
        end

        % Button pushed function: Button_Save1
        function Button_Save1ButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            d.clearData(1);
            [file,path]=uiputfile(['TempModel/',app.EditField_FileName1.Value,'.mat']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'B','d','C','-v7.3');
                fs.disp(['已保存模型：',path,file]);
            end
        end

        % Button pushed function: Button_PostProcessingModule1
        function Button_PostProcessingModule1ButtonPushed(app, event)
            d=app.DataCenter;
            d.showB=1;
            d.showFilter();
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_PostProcess(d);
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.DataCenter=d;
        end

        % Close request function: Figure_WinMain
        function Figure_WinMainCloseRequest(app, event)
            delete(app)
            try
                rmappdata(0,'app');
                rmappdata(0,'CurrentWindow');
            catch
                %不做任何处理。
            end
        end

        % Value changed function: CheckBox_AutoTimeRate
        function CheckBox_AutoTimeRateValueChanged(app, event)
            value = app.CheckBox_AutoTimeRate.Value;
            if value==true
                B=app.Box;
                C=B.SET.C;
                app.NumericEditField_TimeRate.Value=round(C.SET.sampleThickness/B.sampleH*100000)/100000;
                app.NumericEditField_TimeRate.Editable='off';
            else
                app.NumericEditField_TimeRate.Editable='on';
            end
        end

        % Cell edit callback: Table_LayersData
        function Table_LayersDataCellEdit(app, event)
            indices = event.Indices;
            newData = event.NewData;
            d=app.DataCenter;
            GroupNames={};
            for i=1:size(app.Table_LayersData.Data,1)
                if app.Table_LayersData.Data{i,2}==true
                    GroupNames=[GroupNames,app.Table_LayersData.Data{i,1}];
                end
            end
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.showFilter('Group',GroupNames);
            d.show('aR');
        end

        % Button pushed function: Button_LoadGeometricalModel
        function Button_LoadGeometricalModelButtonPushed(app, event)
            [file,path]=uigetfile('TempModel\*.mat');
            try
                if ~contains(file,'.mat')
                    msgbox('当前仅支持打开.mat格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            load([path,file]);
            app.Label_GeometricalModelName.Text=['已导入',file];
            fs.disp(['已导入数据文件：',path,file]);
            %B.setUIoutput(app.TextArea_Message);
            %d=B.d;
            d.calculateData();
            d.mo.setGPU('off');
            d.getModel();
            d.resetStatus();
            d.mo.setNearbyBall();
            d.mo.zeroBalance();
            app.Box=B;
            app.DataCenter=d;
            app.Button_RemoveTopShell.Enable='on';
            f.ChangePlottingAreaParent(app.Tab_Step2);
            f.ChangePlottingArea(app.UIAxes_PlottingArea2);
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aR');
        end

        % Button pushed function: Button_RemoveTopShell
        function Button_RemoveTopShellButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            try
                d.protectGroup('botShell','on');
                groupNames={'slopeBody','addedBody','topShell'};
                d.delGroup(groupNames);
                ID=C.SurfId;
                groupNames={'slopeBody','addedBody'};
                C.setLayer({'sample'},[ID.S_bot0,ID.S0,ID.S_top0],groupNames);
                d.makeModelByGroups(groupNames);
                d.showB=3;
                d.showFilter();
                d.showFilter('SlideY',0.3,0.7);
                d.show('aR');
                fs.disp('已移除顶壳');
                B.SET.C=C;
                app.Box=B;
                app.DataCenter=d;
                app.CheckBox_ifCalcuBeyondSlope.Enable='on';
                app.Button_LoadSlopeShadow.Enable='on';
                app.Button_PostProcessingModule2.Enable='on';
            catch
                return;
            end
        end

        % Button pushed function: Button_LoadSlopeShadow
        function Button_LoadSlopeShadowButtonPushed(app, event)
            [file,path]=uigetfile('slope\*.*');
            if isequal(file,0)==true
                return;
            end
            imageHeight=app.NumericEditField_ShadowHeight.Value;
            imageWidth=app.NumericEditField_ShadowWidth.Value;
            try
                regionFilter=mfs.image2RegionFilter([path,file],imageHeight,imageWidth);
                fs.disp(['已导入影像：',path,file]);
                app.OtherData.regionFilter=regionFilter;
                app.Button_BalanceBondedModel.Enable='on';
            catch
                msgbox('导入影像失败！');
            end
        end

        % Button pushed function: Button_BalanceBondedModel
        function Button_BalanceBondedModelButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            if app.CheckBox_ifCalcuBeyondSlope.Value==false
                regionFilter=app.OtherData.regionFilter;
                sX=d.mo.aX(1:d.mNum);
                sY=d.mo.aY(1:d.mNum);
                sFilter=mfs.applyRegionFilter(regionFilter,sX,sY);
                sFilter=~sFilter;
                sId=find(sFilter);
                sId(sId>d.mNum)=[];
                d.addGroup('slopeWall',sId);
                d.defineWallElement('slopeWall');
            end
            d.mo.setGPU('auto');
            d.balanceBondedModel();
            d.mo.setGPU('off');
            fs.disp('已平衡胶结模型');
            app.Box=B;
            app.DataCenter=d;
            app.Button_LoadMaterials.Enable='on';
        end

        % Button pushed function: Button_LoadMaterials
        function Button_LoadMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            UI_Material(d,B.ballR);
            fs.disp('已导入材料');
            app.Box=B;
            app.DataCenter=d;
            app.Button_GroupingAndSetMaterials.Enable=true;
        end

        % Button pushed function: Button_GroupingAndSetMaterials
        function Button_GroupingAndSetMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            C.layerNum=0;
            ID=C.SurfId;
            C.setLayer({'sample'},[ID.S_bot,ID.S0],{'slopeBody'});
            C.setLayer({'sample'},[ID.S_source,ID.S0],{'slopeSource'});
            if isfield(d.GROUP,'slopeWall')
                C.setLayer({'slopeWall'},[ID.S_bot,ID.S0],{'slopeWall'});
                groupNames={'slopeBody','slopeSource','slopeWall'};
            else
                groupNames={'slopeBody','slopeSource'};
            end
            d.makeModelByGroups(groupNames);
            if strcmp(d.Mats{1,1}.name,'lpsSoil')
                d.setGroupMat('slopeBody','lpsSoil');
                d.setGroupMat('slopeSource','lpsSoil');
                if isfield(d.GROUP,'slopeWall')
                    d.setGroupMat('slopeWall','lpsSoil');
                end
            end
            d.groupMat2Model(groupNames,1);
            if isfield(d.GROUP,'slopeWall')
                S0_shell=mfs.moveMeshGrid(C.SurfData.S0,-C.SET.ballR*2*C.SET.shellTNum);
                C.addSurf(S0_shell,'S0_shell');
                delFilter=false(d.aNum,1);
                delFilter(d.GROUP.botShell)=true;
                delFilter(d.GROUP.slopeWall)=true;
                dilatedTNum=C.SET.shellTNum;
                se1=strel('disk',ceil(2*B.ballR*dilatedTNum*app.NumericEditField_ShadowWidth.Value/B.sampleW));
                protectedRegionFilter=imdilate(app.OtherData.regionFilter,se1);
                protectedFilter=mfs.applyRegionFilter(protectedRegionFilter,d.mo.aX,d.mo.aY);
                ID=C.SurfId;
                C.setLayer({'slopeWall','botShell'},[ID.S0_shell,ID.S0],{'surfaceShell'});
                protectedFilter(d.GROUP.surfaceShell)=true;
                delFilter(protectedFilter)=false;
                d.delElement(find(delFilter));
            end
            d.mo.setNearbyBall();
            d.mo.zeroBalance();
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aMatId');
            app.Table_GroupsData.Data=[];
            if isfield(d.GROUP,'slopeWall')
                app.Table_GroupsData.Data=[{'botShell',true};{'slopeBody',true};{'slopeSource',true};{'slopeWall',true}];
            else
                app.Table_GroupsData.Data=[{'botShell',true};{'slopeBody',true};{'slopeSource',true}];
            end
            fs.disp('已分组赋材料');
            B.SET.C=C;
            app.Box=B;
            app.DataCenter=d;
            app.NumericEditField_ViscosityRate2.Value=round(B.sampleH/C.SET.sampleThickness);
            app.CheckBox_AutoViscosityRate2.Enable='on';
            app.Button_GenerateFinalModel.Enable='on';
        end

        % Button pushed function: Button_GenerateFinalModel
        function Button_GenerateFinalModelButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.mo.mVis=d.mo.mVis*app.NumericEditField_ViscosityRate2.Value;
            d.mo.setGPU('auto');
            d.balanceBondedModel();
            d.mo.bFilter(:)=1;
            d.balance('Standard');
            d.mo.setGPU('off');
            d.mo.mVis=d.mo.mVis/app.NumericEditField_ViscosityRate2.Value;
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aMatId');
            app.Table_GroupsData.Data=[];
            if isfield(d.GROUP,'slopeWall')
                app.Table_GroupsData.Data=[{'botShell',true};{'slopeBody',true};{'slopeSource',true};{'slopeWall',true}];
            else
                app.Table_GroupsData.Data=[{'botShell',true};{'slopeBody',true};{'slopeSource',true}];
            end
            fs.disp('已生成最终模型');
            app.Box=B;
            app.DataCenter=d;
            app.EditField_FileName2.Value=[B.name,'2'];
            app.Button_Save2.Enable='on';
        end

        % Button pushed function: Button_Save2
        function Button_Save2ButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            d.clearData(1);
            [file,path]=uiputfile(['TempModel/',app.EditField_FileName2.Value,'.mat']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'B','d','C','-v7.3');
                fs.disp(['已保存模型：',path,file]);
            end
        end

        % Button pushed function: Button_PostProcessingModule2
        function Button_PostProcessingModule2ButtonPushed(app, event)
            d=app.DataCenter;
            d.showB=1;
            d.showFilter();
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_PostProcess(d);
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.DataCenter=d;
        end

        % Value changed function: CheckBox_ifCalcuBeyondSlope
        function CheckBox_ifCalcuBeyondSlopeValueChanged(app, event)
            value = app.CheckBox_ifCalcuBeyondSlope.Value;
            if value==true
                app.Button_BalanceBondedModel.Enable='on';
            else
                if isfield(app.OtherData,'regionFilter')==false
                    app.Button_BalanceBondedModel.Enable='off';
                else
                    app.Button_BalanceBondedModel.Enable='on';
                end
            end
        end

        % Value changed function: CheckBox_AutoViscosityRate2
        function CheckBox_AutoViscosityRate2ValueChanged(app, event)
            value = app.CheckBox_AutoViscosityRate2.Value;
            if value==true
                B=app.Box;
                C=B.SET.C;
                app.NumericEditField_ViscosityRate2.Value=round(B.sampleH/C.SET.sampleThickness);
                app.NumericEditField_ViscosityRate2.Editable='off';
            else
                app.NumericEditField_ViscosityRate2.Editable='on';
            end
        end

        % Cell edit callback: Table_GroupsData
        function Table_GroupsDataCellEdit(app, event)
            indices = event.Indices;
            newData = event.NewData;
            d=app.DataCenter;
            GroupNames={};
            for i=1:size(app.Table_GroupsData.Data,1)
                if app.Table_GroupsData.Data{i,2}==true
                    GroupNames=[GroupNames,app.Table_GroupsData.Data{i,1}];
                end
            end
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.showFilter('Group',GroupNames);
            d.show('aMatId');
        end

        % Button pushed function: Button_LoadFinalModel
        function Button_LoadFinalModelButtonPushed(app, event)
            [file,path]=uigetfile('TempModel\*.mat');
            try
                if ~contains(file,'.mat')
                    msgbox('当前仅支持打开.mat格式的数据文件！');
                    return;
                end
            catch
                return;
            end
            load([path,file]);
            app.Label_FinalModelName.Text=['已导入',file];
            fs.disp(['已导入数据文件：',path,file]);
            %B.setUIoutput(app.TextArea_Message);
            %d=B.d;
            d.calculateData();
            d.mo.setGPU('off');
            d.getModel();
            d.resetStatus();
            d.mo.setNearbyBall();
            d.mo.zeroBalance();
            app.Box=B;
            app.DataCenter=d;
            app.Button_StartCalculation.Enable='on';
            f.ChangePlottingAreaParent(app.Tab_Step3);
            f.ChangePlottingArea(app.UIAxes_PlottingArea3);
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.show('aR');
        end

        % Button pushed function: Button_StartCalculation
        function Button_StartCalculationButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.breakGroup({'slopeSource'});
            d.breakGroupOuter({'slopeSource'});
            d.mo.isShear=app.CheckBox_isShear.Value;
            d.mo.isHeat=app.CheckBox_isHeat.Value;
            d.setStandarddT();
            d.mo.dT=d.mo.dT*app.NumericEditField_TimeStepRate.Value;
            d.mo.mVis=d.mo.mVis*app.NumericEditField_ViscosityRate3.Value;
            fileName=['data\step\',B.name,'temp_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_loopNum'];
            save([fileName,'0.mat'],'-v7.3');
            fs.disp(['已保存临时文件：',fileName,'0.mat']);
            app.Table_EnergyAndHeatData.Data=[];
            totalCircle=app.NumericEditField_TotalCycle.Value;
            d.tic(totalCircle);
            GPUstatus=d.mo.setGPU('auto');
            for i=1:totalCircle
                d.mo.setGPU(GPUstatus);
                d.balance('Standard');
                d.mo.setGPU('off');
                if d.mo.isHeat==true
                    TotalHeat=sum(d.status.heats,2);
                    app.Table_EnergyAndHeatData.Data=[app.Table_EnergyAndHeatData.Data;{i,d.status.totalEs(end),TotalHeat(end)}];
                else
                    app.Table_EnergyAndHeatData.Data=[app.Table_EnergyAndHeatData.Data;{i,d.status.totalEs(end),'未记录热量'}];
                end
                d.clearData(1);
                save([fileName,num2str(i),'.mat'],'-v7.3');
                fs.disp(['已保存临时文件：',fileName,num2str(i),'.mat']);
                d.calculateData();
                d.toc();
            end
            d.showB=3;
            d.showFilter();
            d.showFilter('SlideY',0.3,0.7);
            d.data.TotalDisplacement=sqrt((d.data.XDisplacement).^2+(d.data.YDisplacement).^2+(d.data.ZDisplacement).^2);
            d.show('TotalDisplacement');
            fs.disp('已完成计算');
            app.Box=B;
            app.DataCenter=d;
            app.EditField_FileName3.Value=[B.name,'3'];
            app.Button_Save3.Enable='on';
        end

        % Button pushed function: Button_Save3
        function Button_Save3ButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            d.clearData(1);
            [file,path]=uiputfile(['TempModel/',app.EditField_FileName3.Value,'.mat']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'B','d','C','-v7.3');
                fs.disp(['已保存模型：',path,file]);
            end
        end

        % Button pushed function: Button_PostProcessingModule3
        function Button_PostProcessingModule3ButtonPushed(app, event)
            d=app.DataCenter;
            d.showB=1;
            d.showFilter();
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_PostProcess(d);
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.DataCenter=d;
        end

        % Button pushed function: Button_Run
        function Button_RunButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            C=B.SET.C;
            Data=app.OtherData;
            app.TextArea_Message.Value=[app.EditField_CommandLine.Value;app.TextArea_Message.Value];
            try
                eval(app.EditField_CommandLine.Value);
            catch ME
                app.TextArea_Message.Value=[ME.identifier;app.TextArea_Message.Value];
            end
            app.EditField_CommandLine.Value='';
            B.SET.C=C;
            app.Box=B;
            app.DataCenter=d;
            app.otherData=Data;
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create Figure_WinMain
            app.Figure_WinMain = uifigure;
            app.Figure_WinMain.Position = [100 100 800 600];
            app.Figure_WinMain.Name = '滑坡灾害试验室';
            app.Figure_WinMain.Resize = 'off';
            app.Figure_WinMain.CloseRequestFcn = createCallbackFcn(app, @Figure_WinMainCloseRequest, true);

            % Create TabGroup_Modules
            app.TabGroup_Modules = uitabgroup(app.Figure_WinMain);
            app.TabGroup_Modules.Position = [21 161 760 420];

            % Create Tab_PreProcessingModule
            app.Tab_PreProcessingModule = uitab(app.TabGroup_Modules);
            app.Tab_PreProcessingModule.Title = '前处理：根据数字高程数据生成三维格网';

            % Create Panel_LoadElevationData
            app.Panel_LoadElevationData = uipanel(app.Tab_PreProcessingModule);
            app.Panel_LoadElevationData.Title = '导入高程数据';
            app.Panel_LoadElevationData.Position = [21 205 250 170];

            % Create Button_LoadElevationDataBefore
            app.Button_LoadElevationDataBefore = uibutton(app.Panel_LoadElevationData, 'push');
            app.Button_LoadElevationDataBefore.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadElevationDataBeforeButtonPushed, true);
            app.Button_LoadElevationDataBefore.Position = [21 114 120 24];
            app.Button_LoadElevationDataBefore.Text = '导入滑坡前高程数据';

            % Create Button_LoadElevationDataAfter
            app.Button_LoadElevationDataAfter = uibutton(app.Panel_LoadElevationData, 'push');
            app.Button_LoadElevationDataAfter.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadElevationDataAfterButtonPushed, true);
            app.Button_LoadElevationDataAfter.Position = [21 44 120 24];
            app.Button_LoadElevationDataAfter.Text = '导入滑坡后高程数据';

            % Create Label_ElevationDataBeforeName
            app.Label_ElevationDataBeforeName = uilabel(app.Panel_LoadElevationData);
            app.Label_ElevationDataBeforeName.Position = [21 86 200 22];
            app.Label_ElevationDataBeforeName.Text = '尚未导入任何数据文件！';

            % Create Label_ElevationDataAfterName
            app.Label_ElevationDataAfterName = uilabel(app.Panel_LoadElevationData);
            app.Label_ElevationDataAfterName.Position = [21 16 200 22];
            app.Label_ElevationDataAfterName.Text = '尚未导入任何数据文件！';

            % Create Button_CheckElevationDataBefore
            app.Button_CheckElevationDataBefore = uibutton(app.Panel_LoadElevationData, 'push');
            app.Button_CheckElevationDataBefore.ButtonPushedFcn = createCallbackFcn(app, @Button_CheckElevationDataBeforeButtonPushed, true);
            app.Button_CheckElevationDataBefore.Enable = 'off';
            app.Button_CheckElevationDataBefore.Position = [151 114 80 24];
            app.Button_CheckElevationDataBefore.Text = '查看高程数据';

            % Create Button_CheckElevationDataAfter
            app.Button_CheckElevationDataAfter = uibutton(app.Panel_LoadElevationData, 'push');
            app.Button_CheckElevationDataAfter.ButtonPushedFcn = createCallbackFcn(app, @Button_CheckElevationDataAfterButtonPushed, true);
            app.Button_CheckElevationDataAfter.Enable = 'off';
            app.Button_CheckElevationDataAfter.Position = [151 44 80 24];
            app.Button_CheckElevationDataAfter.Text = '查看高程数据';

            % Create UIAxes_PlottingAreaPre
            app.UIAxes_PlottingAreaPre = uiaxes(app.Tab_PreProcessingModule);
            title(app.UIAxes_PlottingAreaPre, '三维格网')
            xlabel(app.UIAxes_PlottingAreaPre, 'X')
            ylabel(app.UIAxes_PlottingAreaPre, 'Y')
            app.UIAxes_PlottingAreaPre.TitleFontWeight = 'bold';
            app.UIAxes_PlottingAreaPre.Position = [291 25 450 350];

            % Create Panel_Generate3DMeshgrid
            app.Panel_Generate3DMeshgrid = uipanel(app.Tab_PreProcessingModule);
            app.Panel_Generate3DMeshgrid.Title = '生成三维格网';
            app.Panel_Generate3DMeshgrid.Position = [21 25 250 170];

            % Create Label_2
            app.Label_2 = uilabel(app.Panel_Generate3DMeshgrid);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [18 116 166 22];
            app.Label_2.Text = '旋转角（单位：°，逆正顺负）';

            % Create NumericEditField_RotationAngle
            app.NumericEditField_RotationAngle = uieditfield(app.Panel_Generate3DMeshgrid, 'numeric');
            app.NumericEditField_RotationAngle.Limits = [-180 180];
            app.NumericEditField_RotationAngle.Position = [199 116 30 22];
            app.NumericEditField_RotationAngle.Value = -60;

            % Create Button_RotateElevationData
            app.Button_RotateElevationData = uibutton(app.Panel_Generate3DMeshgrid, 'push');
            app.Button_RotateElevationData.ButtonPushedFcn = createCallbackFcn(app, @Button_RotateElevationDataButtonPushed, true);
            app.Button_RotateElevationData.Enable = 'off';
            app.Button_RotateElevationData.Position = [21 84 210 24];
            app.Button_RotateElevationData.Text = '在水平面内旋转高程数据';

            % Create Button_GenerateMeshgrid
            app.Button_GenerateMeshgrid = uibutton(app.Panel_Generate3DMeshgrid, 'push');
            app.Button_GenerateMeshgrid.ButtonPushedFcn = createCallbackFcn(app, @Button_GenerateMeshgridButtonPushed, true);
            app.Button_GenerateMeshgrid.Enable = 'off';
            app.Button_GenerateMeshgrid.Position = [131 44 100 24];
            app.Button_GenerateMeshgrid.Text = '生成三维格网';

            % Create Button_SaveMeshgrid
            app.Button_SaveMeshgrid = uibutton(app.Panel_Generate3DMeshgrid, 'push');
            app.Button_SaveMeshgrid.ButtonPushedFcn = createCallbackFcn(app, @Button_SaveMeshgridButtonPushed, true);
            app.Button_SaveMeshgrid.Enable = 'off';
            app.Button_SaveMeshgrid.Position = [21 14 210 24];
            app.Button_SaveMeshgrid.Text = '保存三维格网';

            % Create Label_3
            app.Label_3 = uilabel(app.Panel_Generate3DMeshgrid);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [21 46 53 22];
            app.Label_3.Text = '格网间距';

            % Create NumericEditField_MeshgridInterval
            app.NumericEditField_MeshgridInterval = uieditfield(app.Panel_Generate3DMeshgrid, 'numeric');
            app.NumericEditField_MeshgridInterval.Limits = [0.001 Inf];
            app.NumericEditField_MeshgridInterval.Position = [89 46 30 22];
            app.NumericEditField_MeshgridInterval.Value = 5;

            % Create Tab_Step0
            app.Tab_Step0 = uitab(app.TabGroup_Modules);
            app.Tab_Step0.Title = '第0步：根据三维格网生成层面';

            % Create Panel_Create3DSurfaces
            app.Panel_Create3DSurfaces = uipanel(app.Tab_Step0);
            app.Panel_Create3DSurfaces.Title = '创建层面';
            app.Panel_Create3DSurfaces.Position = [21 185 280 190];

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [11 106 53 22];
            app.Label_4.Text = '单元半径';

            % Create NumericEditField_BallRadius0
            app.NumericEditField_BallRadius0 = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_BallRadius0.Limits = [0.001 Inf];
            app.NumericEditField_BallRadius0.Position = [101 106 30 22];
            app.NumericEditField_BallRadius0.Value = 10;

            % Create Label_5
            app.Label_5 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [11 76 89 22];
            app.Label_5.Text = '追加深度（下）';

            % Create NumericEditField_AdditionalDepthBeneath
            app.NumericEditField_AdditionalDepthBeneath = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_AdditionalDepthBeneath.Limits = [0 Inf];
            app.NumericEditField_AdditionalDepthBeneath.Position = [101 76 30 22];
            app.NumericEditField_AdditionalDepthBeneath.Value = 60;

            % Create Label_6
            app.Label_6 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_6.HorizontalAlignment = 'right';
            app.Label_6.Position = [141 76 89 22];
            app.Label_6.Text = '追加层数（上）';

            % Create NumericEditField_AdditionalLayerNumberAbove
            app.NumericEditField_AdditionalLayerNumberAbove = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_AdditionalLayerNumberAbove.Limits = [0 Inf];
            app.NumericEditField_AdditionalLayerNumberAbove.Position = [231 76 30 22];
            app.NumericEditField_AdditionalLayerNumberAbove.Value = 1;

            % Create Label_7
            app.Label_7 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.Position = [141 106 65 22];
            app.Label_7.Text = '墙单元层数';

            % Create NumericEditField_WallElementLayerNumber
            app.NumericEditField_WallElementLayerNumber = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_WallElementLayerNumber.Limits = [1 Inf];
            app.NumericEditField_WallElementLayerNumber.Position = [231 106 30 22];
            app.NumericEditField_WallElementLayerNumber.Value = 6;

            % Create Label_8
            app.Label_8 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.Position = [11 46 77 22];
            app.Label_8.Text = '下模具板层数';

            % Create NumericEditField_BottomShellLayerNumber
            app.NumericEditField_BottomShellLayerNumber = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_BottomShellLayerNumber.Limits = [1 Inf];
            app.NumericEditField_BottomShellLayerNumber.Position = [101 46 30 22];
            app.NumericEditField_BottomShellLayerNumber.Value = 3;

            % Create Label_9
            app.Label_9 = uilabel(app.Panel_Create3DSurfaces);
            app.Label_9.HorizontalAlignment = 'right';
            app.Label_9.Position = [141 46 77 22];
            app.Label_9.Text = '上模具板层数';

            % Create NumericEditField_TopShellLayerNumber
            app.NumericEditField_TopShellLayerNumber = uieditfield(app.Panel_Create3DSurfaces, 'numeric');
            app.NumericEditField_TopShellLayerNumber.Limits = [1 Inf];
            app.NumericEditField_TopShellLayerNumber.Position = [231 46 30 22];
            app.NumericEditField_TopShellLayerNumber.Value = 2;

            % Create Button_CreateSurfaces
            app.Button_CreateSurfaces = uibutton(app.Panel_Create3DSurfaces, 'push');
            app.Button_CreateSurfaces.ButtonPushedFcn = createCallbackFcn(app, @Button_CreateSurfacesButtonPushed, true);
            app.Button_CreateSurfaces.Enable = 'off';
            app.Button_CreateSurfaces.Position = [21 14 110 24];
            app.Button_CreateSurfaces.Text = '创建层面';

            % Create Button_SaveSurfaces
            app.Button_SaveSurfaces = uibutton(app.Panel_Create3DSurfaces, 'push');
            app.Button_SaveSurfaces.ButtonPushedFcn = createCallbackFcn(app, @Button_SaveSurfacesButtonPushed, true);
            app.Button_SaveSurfaces.Enable = 'off';
            app.Button_SaveSurfaces.Position = [151 14 110 24];
            app.Button_SaveSurfaces.Text = '保存层面';

            % Create Button_LoadMeshgridData
            app.Button_LoadMeshgridData = uibutton(app.Panel_Create3DSurfaces, 'push');
            app.Button_LoadMeshgridData.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadMeshgridDataButtonPushed, true);
            app.Button_LoadMeshgridData.Position = [21 134 90 24];
            app.Button_LoadMeshgridData.Text = '导入三维格网';

            % Create Label_MeshgridDataName
            app.Label_MeshgridDataName = uilabel(app.Panel_Create3DSurfaces);
            app.Label_MeshgridDataName.Position = [121 136 140 22];
            app.Label_MeshgridDataName.Text = '尚未导入任何数据文件！';

            % Create Table_SurfacesData0
            app.Table_SurfacesData0 = uitable(app.Tab_Step0);
            app.Table_SurfacesData0.ColumnName = {'层面编号'; '层面名称'; '可见性'};
            app.Table_SurfacesData0.RowName = {};
            app.Table_SurfacesData0.ColumnEditable = [false false true];
            app.Table_SurfacesData0.CellEditCallback = createCallbackFcn(app, @Table_SurfacesData0CellEdit, true);
            app.Table_SurfacesData0.Position = [21 25 280 140];

            % Create UIAxes_PlottingArea0
            app.UIAxes_PlottingArea0 = uiaxes(app.Tab_Step0);
            title(app.UIAxes_PlottingArea0, '层面')
            xlabel(app.UIAxes_PlottingArea0, 'X')
            ylabel(app.UIAxes_PlottingArea0, 'Y')
            app.UIAxes_PlottingArea0.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea0.Position = [321 25 420 350];

            % Create Tab_Step1
            app.Tab_Step1 = uitab(app.TabGroup_Modules);
            app.Tab_Step1.Title = '第1步：几何建模';

            % Create Panel_InitialModeling
            app.Panel_InitialModeling = uipanel(app.Tab_Step1);
            app.Panel_InitialModeling.Title = '初始建模';
            app.Panel_InitialModeling.Position = [21 135 260 240];

            % Create Button_LoadSurfacesData
            app.Button_LoadSurfacesData = uibutton(app.Panel_InitialModeling, 'push');
            app.Button_LoadSurfacesData.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadSurfacesDataButtonPushed, true);
            app.Button_LoadSurfacesData.Position = [21 184 70 24];
            app.Button_LoadSurfacesData.Text = '导入层面';

            % Create Label_SurfacesDataName
            app.Label_SurfacesDataName = uilabel(app.Panel_InitialModeling);
            app.Label_SurfacesDataName.Position = [101 186 140 22];
            app.Label_SurfacesDataName.Text = '尚未导入任何数据文件！';

            % Create Label_10
            app.Label_10 = uilabel(app.Panel_InitialModeling);
            app.Label_10.HorizontalAlignment = 'right';
            app.Label_10.Position = [21 146 29 32];
            app.Label_10.Text = {'模型'; '名称'};

            % Create EditField_ModelName
            app.EditField_ModelName = uieditfield(app.Panel_InitialModeling, 'text');
            app.EditField_ModelName.Position = [65 151 80 22];
            app.EditField_ModelName.Value = 'lps_3DSlope';

            % Create Label_11
            app.Label_11 = uilabel(app.Panel_InitialModeling);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.Position = [141 116 53 22];
            app.Label_11.Text = '分散系数';

            % Create NumericEditField_DistributionRate
            app.NumericEditField_DistributionRate = uieditfield(app.Panel_InitialModeling, 'numeric');
            app.NumericEditField_DistributionRate.Limits = [0 Inf];
            app.NumericEditField_DistributionRate.Position = [209 116 30 22];
            app.NumericEditField_DistributionRate.Value = 0.2;

            % Create CheckBox_isClump
            app.CheckBox_isClump = uicheckbox(app.Panel_InitialModeling);
            app.CheckBox_isClump.Text = '使用团簇模型';
            app.CheckBox_isClump.Position = [21 83 94 22];

            % Create Label_12
            app.Label_12 = uilabel(app.Panel_InitialModeling);
            app.Label_12.HorizontalAlignment = 'right';
            app.Label_12.Position = [21 116 53 22];
            app.Label_12.Text = '单元半径';

            % Create NumericEditField_BallRadius1
            app.NumericEditField_BallRadius1 = uieditfield(app.Panel_InitialModeling, 'numeric');
            app.NumericEditField_BallRadius1.Position = [89 116 30 22];

            % Create Button_BuildInitialModel
            app.Button_BuildInitialModel = uibutton(app.Panel_InitialModeling, 'push');
            app.Button_BuildInitialModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BuildInitialModelButtonPushed, true);
            app.Button_BuildInitialModel.Enable = 'off';
            app.Button_BuildInitialModel.Position = [141 82 100 24];
            app.Button_BuildInitialModel.Text = '建立初始模型';

            % Create Button_GravitySediment
            app.Button_GravitySediment = uibutton(app.Panel_InitialModeling, 'push');
            app.Button_GravitySediment.ButtonPushedFcn = createCallbackFcn(app, @Button_GravitySedimentButtonPushed, true);
            app.Button_GravitySediment.Enable = 'off';
            app.Button_GravitySediment.Position = [181 47 60 24];
            app.Button_GravitySediment.Text = '重力沉积';

            % Create Button_Save1
            app.Button_Save1 = uibutton(app.Panel_InitialModeling, 'push');
            app.Button_Save1.ButtonPushedFcn = createCallbackFcn(app, @Button_Save1ButtonPushed, true);
            app.Button_Save1.Enable = 'off';
            app.Button_Save1.Position = [125 12 50 24];
            app.Button_Save1.Text = '保存';

            % Create Label_13
            app.Label_13 = uilabel(app.Panel_InitialModeling);
            app.Label_13.HorizontalAlignment = 'right';
            app.Label_13.Position = [151 146 29 32];
            app.Label_13.Text = {'随机'; '种子'};

            % Create Spinner_RandomSeed
            app.Spinner_RandomSeed = uispinner(app.Panel_InitialModeling);
            app.Spinner_RandomSeed.Limits = [1 Inf];
            app.Spinner_RandomSeed.Position = [195 151 44 22];
            app.Spinner_RandomSeed.Value = 1;

            % Create Button_PostProcessingModule1
            app.Button_PostProcessingModule1 = uibutton(app.Panel_InitialModeling, 'push');
            app.Button_PostProcessingModule1.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModule1ButtonPushed, true);
            app.Button_PostProcessingModule1.Enable = 'off';
            app.Button_PostProcessingModule1.Position = [181 12 60 24];
            app.Button_PostProcessingModule1.Text = '后处理';

            % Create Label_15
            app.Label_15 = uilabel(app.Panel_InitialModeling);
            app.Label_15.HorizontalAlignment = 'right';
            app.Label_15.Position = [21 47 53 22];
            app.Label_15.Text = '时间比率';

            % Create NumericEditField_TimeRate
            app.NumericEditField_TimeRate = uieditfield(app.Panel_InitialModeling, 'numeric');
            app.NumericEditField_TimeRate.Limits = [0 Inf];
            app.NumericEditField_TimeRate.Editable = 'off';
            app.NumericEditField_TimeRate.Position = [81 47 40 22];
            app.NumericEditField_TimeRate.Value = 1;

            % Create Label_16
            app.Label_16 = uilabel(app.Panel_InitialModeling);
            app.Label_16.HorizontalAlignment = 'right';
            app.Label_16.Position = [21 13 41 22];
            app.Label_16.Text = '文件名';

            % Create EditField_FileName1
            app.EditField_FileName1 = uieditfield(app.Panel_InitialModeling, 'text');
            app.EditField_FileName1.Position = [71 13 48 22];

            % Create CheckBox_AutoTimeRate
            app.CheckBox_AutoTimeRate = uicheckbox(app.Panel_InitialModeling);
            app.CheckBox_AutoTimeRate.ValueChangedFcn = createCallbackFcn(app, @CheckBox_AutoTimeRateValueChanged, true);
            app.CheckBox_AutoTimeRate.Enable = 'off';
            app.CheckBox_AutoTimeRate.Text = {'自动'; '比率'};
            app.CheckBox_AutoTimeRate.Position = [131 43 46 32];
            app.CheckBox_AutoTimeRate.Value = true;

            % Create UIAxes_PlottingArea1
            app.UIAxes_PlottingArea1 = uiaxes(app.Tab_Step1);
            title(app.UIAxes_PlottingArea1, '绘图区')
            xlabel(app.UIAxes_PlottingArea1, 'X')
            ylabel(app.UIAxes_PlottingArea1, 'Y')
            app.UIAxes_PlottingArea1.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea1.Position = [301 25 440 350];

            % Create Table_LayersData
            app.Table_LayersData = uitable(app.Tab_Step1);
            app.Table_LayersData.ColumnName = {'组名'; '可见性'};
            app.Table_LayersData.RowName = {};
            app.Table_LayersData.ColumnEditable = [false true];
            app.Table_LayersData.CellEditCallback = createCallbackFcn(app, @Table_LayersDataCellEdit, true);
            app.Table_LayersData.Position = [21 25 260 100];

            % Create Tab_Step2
            app.Tab_Step2 = uitab(app.TabGroup_Modules);
            app.Tab_Step2.Title = '第2步：材料设置';

            % Create Panel_CuttingModelAndSettingMaterials
            app.Panel_CuttingModelAndSettingMaterials = uipanel(app.Tab_Step2);
            app.Panel_CuttingModelAndSettingMaterials.Title = '模型切割与材料设置';
            app.Panel_CuttingModelAndSettingMaterials.Position = [21 125 260 250];

            % Create Button_LoadGeometricalModel
            app.Button_LoadGeometricalModel = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_LoadGeometricalModel.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadGeometricalModelButtonPushed, true);
            app.Button_LoadGeometricalModel.Position = [21 194 70 24];
            app.Button_LoadGeometricalModel.Text = '导入模型';

            % Create Label_GeometricalModelName
            app.Label_GeometricalModelName = uilabel(app.Panel_CuttingModelAndSettingMaterials);
            app.Label_GeometricalModelName.Position = [101 196 140 22];
            app.Label_GeometricalModelName.Text = '尚未导入任何数据文件！';

            % Create Button_RemoveTopShell
            app.Button_RemoveTopShell = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_RemoveTopShell.ButtonPushedFcn = createCallbackFcn(app, @Button_RemoveTopShellButtonPushed, true);
            app.Button_RemoveTopShell.Enable = 'off';
            app.Button_RemoveTopShell.Position = [21 164 70 24];
            app.Button_RemoveTopShell.Text = '移除顶壳';

            % Create CheckBox_ifCalcuBeyondSlope
            app.CheckBox_ifCalcuBeyondSlope = uicheckbox(app.Panel_CuttingModelAndSettingMaterials);
            app.CheckBox_ifCalcuBeyondSlope.ValueChangedFcn = createCallbackFcn(app, @CheckBox_ifCalcuBeyondSlopeValueChanged, true);
            app.CheckBox_ifCalcuBeyondSlope.Enable = 'off';
            app.CheckBox_ifCalcuBeyondSlope.Text = {'计算滑坡区域以外'; '单元的运动（更慢）'};
            app.CheckBox_ifCalcuBeyondSlope.Position = [101 161 130 32];

            % Create Button_LoadSlopeShadow
            app.Button_LoadSlopeShadow = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_LoadSlopeShadow.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadSlopeShadowButtonPushed, true);
            app.Button_LoadSlopeShadow.Enable = 'off';
            app.Button_LoadSlopeShadow.Position = [91 124 60 24];
            app.Button_LoadSlopeShadow.Text = '导入影像';

            % Create Button_BalanceBondedModel
            app.Button_BalanceBondedModel = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_BalanceBondedModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BalanceBondedModelButtonPushed, true);
            app.Button_BalanceBondedModel.Enable = 'off';
            app.Button_BalanceBondedModel.Position = [161 124 80 24];
            app.Button_BalanceBondedModel.Text = '平衡胶结模型';

            % Create Button_LoadMaterials
            app.Button_LoadMaterials = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_LoadMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadMaterialsButtonPushed, true);
            app.Button_LoadMaterials.Enable = 'off';
            app.Button_LoadMaterials.Position = [21 84 100 24];
            app.Button_LoadMaterials.Text = '导入材料';

            % Create Button_GroupingAndSetMaterials
            app.Button_GroupingAndSetMaterials = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_GroupingAndSetMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_GroupingAndSetMaterialsButtonPushed, true);
            app.Button_GroupingAndSetMaterials.Enable = 'off';
            app.Button_GroupingAndSetMaterials.Position = [141 84 100 24];
            app.Button_GroupingAndSetMaterials.Text = '分组赋材料';

            % Create Button_GenerateFinalModel
            app.Button_GenerateFinalModel = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_GenerateFinalModel.ButtonPushedFcn = createCallbackFcn(app, @Button_GenerateFinalModelButtonPushed, true);
            app.Button_GenerateFinalModel.Enable = 'off';
            app.Button_GenerateFinalModel.Position = [181 38 60 40];
            app.Button_GenerateFinalModel.Text = {'生成最'; '终模型'};

            % Create Label_17
            app.Label_17 = uilabel(app.Panel_CuttingModelAndSettingMaterials);
            app.Label_17.HorizontalAlignment = 'right';
            app.Label_17.Position = [21 9 41 22];
            app.Label_17.Text = '文件名';

            % Create EditField_FileName2
            app.EditField_FileName2 = uieditfield(app.Panel_CuttingModelAndSettingMaterials, 'text');
            app.EditField_FileName2.Position = [71 9 48 22];

            % Create Button_Save2
            app.Button_Save2 = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_Save2.ButtonPushedFcn = createCallbackFcn(app, @Button_Save2ButtonPushed, true);
            app.Button_Save2.Enable = 'off';
            app.Button_Save2.Position = [125 8 50 24];
            app.Button_Save2.Text = '保存';

            % Create Button_PostProcessingModule2
            app.Button_PostProcessingModule2 = uibutton(app.Panel_CuttingModelAndSettingMaterials, 'push');
            app.Button_PostProcessingModule2.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModule2ButtonPushed, true);
            app.Button_PostProcessingModule2.Enable = 'off';
            app.Button_PostProcessingModule2.Position = [181 8 60 24];
            app.Button_PostProcessingModule2.Text = '后处理';

            % Create Label_18
            app.Label_18 = uilabel(app.Panel_CuttingModelAndSettingMaterials);
            app.Label_18.HorizontalAlignment = 'right';
            app.Label_18.Position = [21 47 53 22];
            app.Label_18.Text = '阻尼倍率';

            % Create NumericEditField_ViscosityRate2
            app.NumericEditField_ViscosityRate2 = uieditfield(app.Panel_CuttingModelAndSettingMaterials, 'numeric');
            app.NumericEditField_ViscosityRate2.Limits = [1 Inf];
            app.NumericEditField_ViscosityRate2.Editable = 'off';
            app.NumericEditField_ViscosityRate2.Position = [81 47 30 22];
            app.NumericEditField_ViscosityRate2.Value = 1;

            % Create CheckBox_AutoViscosityRate2
            app.CheckBox_AutoViscosityRate2 = uicheckbox(app.Panel_CuttingModelAndSettingMaterials);
            app.CheckBox_AutoViscosityRate2.ValueChangedFcn = createCallbackFcn(app, @CheckBox_AutoViscosityRate2ValueChanged, true);
            app.CheckBox_AutoViscosityRate2.Enable = 'off';
            app.CheckBox_AutoViscosityRate2.Text = {'自动'; '倍率'};
            app.CheckBox_AutoViscosityRate2.Position = [125 42 46 32];
            app.CheckBox_AutoViscosityRate2.Value = true;

            % Create Label_19
            app.Label_19 = uilabel(app.Panel_CuttingModelAndSettingMaterials);
            app.Label_19.HorizontalAlignment = 'right';
            app.Label_19.Position = [11 136 25 22];
            app.Label_19.Text = '宽';

            % Create NumericEditField_ShadowWidth
            app.NumericEditField_ShadowWidth = uieditfield(app.Panel_CuttingModelAndSettingMaterials, 'numeric');
            app.NumericEditField_ShadowWidth.Limits = [1 Inf];
            app.NumericEditField_ShadowWidth.Position = [41 136 38 22];
            app.NumericEditField_ShadowWidth.Value = 596;

            % Create Label_20
            app.Label_20 = uilabel(app.Panel_CuttingModelAndSettingMaterials);
            app.Label_20.HorizontalAlignment = 'right';
            app.Label_20.Position = [11 113 25 22];
            app.Label_20.Text = '高';

            % Create NumericEditField_ShadowHeight
            app.NumericEditField_ShadowHeight = uieditfield(app.Panel_CuttingModelAndSettingMaterials, 'numeric');
            app.NumericEditField_ShadowHeight.Position = [41 113 38 22];
            app.NumericEditField_ShadowHeight.Value = 256;

            % Create UIAxes_PlottingArea2
            app.UIAxes_PlottingArea2 = uiaxes(app.Tab_Step2);
            title(app.UIAxes_PlottingArea2, '绘图区')
            xlabel(app.UIAxes_PlottingArea2, 'X')
            ylabel(app.UIAxes_PlottingArea2, 'Y')
            app.UIAxes_PlottingArea2.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea2.Position = [301 25 440 350];

            % Create Table_GroupsData
            app.Table_GroupsData = uitable(app.Tab_Step2);
            app.Table_GroupsData.ColumnName = {'组名'; '可见性'};
            app.Table_GroupsData.RowName = {};
            app.Table_GroupsData.ColumnEditable = [false true];
            app.Table_GroupsData.CellEditCallback = createCallbackFcn(app, @Table_GroupsDataCellEdit, true);
            app.Table_GroupsData.Position = [21 25 260 90];

            % Create Tab_Step3
            app.Tab_Step3 = uitab(app.TabGroup_Modules);
            app.Tab_Step3.Title = '第3步：平衡迭代';

            % Create Panel_IterativeCalculation
            app.Panel_IterativeCalculation = uipanel(app.Tab_Step3);
            app.Panel_IterativeCalculation.Title = '迭代计算';
            app.Panel_IterativeCalculation.Position = [21 185 260 190];

            % Create Button_LoadFinalModel
            app.Button_LoadFinalModel = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_LoadFinalModel.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadFinalModelButtonPushed, true);
            app.Button_LoadFinalModel.Position = [21 134 70 24];
            app.Button_LoadFinalModel.Text = '导入模型';

            % Create Label_FinalModelName
            app.Label_FinalModelName = uilabel(app.Panel_IterativeCalculation);
            app.Label_FinalModelName.Position = [101 136 140 22];
            app.Label_FinalModelName.Text = '尚未导入任何数据文件！';

            % Create CheckBox_isShear
            app.CheckBox_isShear = uicheckbox(app.Panel_IterativeCalculation);
            app.CheckBox_isShear.Text = '考虑剪力';
            app.CheckBox_isShear.Position = [21 106 70 22];

            % Create CheckBox_isHeat
            app.CheckBox_isHeat = uicheckbox(app.Panel_IterativeCalculation);
            app.CheckBox_isHeat.Text = '计算热量';
            app.CheckBox_isHeat.Position = [21 76 70 22];
            app.CheckBox_isHeat.Value = true;

            % Create Label_21
            app.Label_21 = uilabel(app.Panel_IterativeCalculation);
            app.Label_21.HorizontalAlignment = 'right';
            app.Label_21.Position = [111 106 65 22];
            app.Label_21.Text = '时间步倍率';

            % Create NumericEditField_TimeStepRate
            app.NumericEditField_TimeStepRate = uieditfield(app.Panel_IterativeCalculation, 'numeric');
            app.NumericEditField_TimeStepRate.Limits = [1 5];
            app.NumericEditField_TimeStepRate.Position = [190 106 50 22];
            app.NumericEditField_TimeStepRate.Value = 4;

            % Create Label_22
            app.Label_22 = uilabel(app.Panel_IterativeCalculation);
            app.Label_22.HorizontalAlignment = 'right';
            app.Label_22.Position = [112 76 53 22];
            app.Label_22.Text = '阻尼倍率';

            % Create NumericEditField_ViscosityRate3
            app.NumericEditField_ViscosityRate3 = uieditfield(app.Panel_IterativeCalculation, 'numeric');
            app.NumericEditField_ViscosityRate3.Limits = [0 1];
            app.NumericEditField_ViscosityRate3.Position = [180 76 60 22];
            app.NumericEditField_ViscosityRate3.Value = 1e-05;

            % Create Label_23
            app.Label_23 = uilabel(app.Panel_IterativeCalculation);
            app.Label_23.HorizontalAlignment = 'right';
            app.Label_23.Position = [21 45 53 22];
            app.Label_23.Text = '循环总数';

            % Create NumericEditField_TotalCycle
            app.NumericEditField_TotalCycle = uieditfield(app.Panel_IterativeCalculation, 'numeric');
            app.NumericEditField_TotalCycle.Limits = [1 Inf];
            app.NumericEditField_TotalCycle.Position = [89 45 40 22];
            app.NumericEditField_TotalCycle.Value = 30;

            % Create Button_StartCalculation
            app.Button_StartCalculation = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_StartCalculation.ButtonPushedFcn = createCallbackFcn(app, @Button_StartCalculationButtonPushed, true);
            app.Button_StartCalculation.Enable = 'off';
            app.Button_StartCalculation.Position = [150 44 90 24];
            app.Button_StartCalculation.Text = '开始计算';

            % Create Label_24
            app.Label_24 = uilabel(app.Panel_IterativeCalculation);
            app.Label_24.HorizontalAlignment = 'right';
            app.Label_24.Position = [21 13 41 22];
            app.Label_24.Text = '文件名';

            % Create EditField_FileName3
            app.EditField_FileName3 = uieditfield(app.Panel_IterativeCalculation, 'text');
            app.EditField_FileName3.Position = [71 13 48 22];

            % Create Button_Save3
            app.Button_Save3 = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_Save3.ButtonPushedFcn = createCallbackFcn(app, @Button_Save3ButtonPushed, true);
            app.Button_Save3.Enable = 'off';
            app.Button_Save3.Position = [125 12 50 24];
            app.Button_Save3.Text = '保存';

            % Create Button_PostProcessingModule3
            app.Button_PostProcessingModule3 = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_PostProcessingModule3.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModule3ButtonPushed, true);
            app.Button_PostProcessingModule3.Enable = 'off';
            app.Button_PostProcessingModule3.Position = [180 12 60 24];
            app.Button_PostProcessingModule3.Text = '后处理';

            % Create UIAxes_PlottingArea3
            app.UIAxes_PlottingArea3 = uiaxes(app.Tab_Step3);
            title(app.UIAxes_PlottingArea3, '绘图区')
            xlabel(app.UIAxes_PlottingArea3, 'X')
            ylabel(app.UIAxes_PlottingArea3, 'Y')
            app.UIAxes_PlottingArea3.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea3.Position = [301 25 440 350];

            % Create Table_EnergyAndHeatData
            app.Table_EnergyAndHeatData = uitable(app.Tab_Step3);
            app.Table_EnergyAndHeatData.ColumnName = {'循环次数'; '能量'; '热量'};
            app.Table_EnergyAndHeatData.RowName = {};
            app.Table_EnergyAndHeatData.Position = [21 25 260 140];

            % Create Label
            app.Label = uilabel(app.Figure_WinMain);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [21 129 41 22];
            app.Label.Text = '命令行';

            % Create EditField_CommandLine
            app.EditField_CommandLine = uieditfield(app.Figure_WinMain, 'text');
            app.EditField_CommandLine.Position = [77 129 594 22];

            % Create Button_Run
            app.Button_Run = uibutton(app.Figure_WinMain, 'push');
            app.Button_Run.ButtonPushedFcn = createCallbackFcn(app, @Button_RunButtonPushed, true);
            app.Button_Run.Position = [681 127 100 24];
            app.Button_Run.Text = '运行';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.Figure_WinMain);
            app.TextArea_Message.Position = [21 21 760 100];
        end
    end

    methods (Access = public)

        % Construct app
        function app = UI_Slope3D_exported

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.Figure_WinMain)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.Figure_WinMain)
        end
    end
end