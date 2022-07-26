classdef UI_SlopeNet < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        SlopeNet                     matlab.ui.Figure
        TextArea_Message             matlab.ui.control.TextArea
        TabGroup                     matlab.ui.container.TabGroup
        Tab_Step1                    matlab.ui.container.Tab
        Button                       matlab.ui.control.Button
        Panel                        matlab.ui.container.Panel
        CheckBox                     matlab.ui.control.CheckBox
        Label_7                      matlab.ui.control.Label
        EditField                    matlab.ui.control.EditField
        EditField_2Label             matlab.ui.control.Label
        EditField_2                  matlab.ui.control.NumericEditField
        EditField_5Label             matlab.ui.control.Label
        EditField_5                  matlab.ui.control.NumericEditField
        EditField_6Label             matlab.ui.control.Label
        EditField_6                  matlab.ui.control.NumericEditField
        EditField_3Label             matlab.ui.control.Label
        EditField_3                  matlab.ui.control.EditField
        EditField_4Label             matlab.ui.control.Label
        EditField_4                  matlab.ui.control.NumericEditField
        EditField_7Label             matlab.ui.control.Label
        EditField_7                  matlab.ui.control.NumericEditField
        Panel_2                      matlab.ui.container.Panel
        EditField_8Label             matlab.ui.control.Label
        EditField_8                  matlab.ui.control.NumericEditField
        EditField_9Label             matlab.ui.control.Label
        EditField_9                  matlab.ui.control.NumericEditField
        Label_8                      matlab.ui.control.Label
        EditField_10                 matlab.ui.control.NumericEditField
        Label_9                      matlab.ui.control.Label
        EditField_11                 matlab.ui.control.NumericEditField
        Label_10                     matlab.ui.control.Label
        EditField_12                 matlab.ui.control.NumericEditField
        UIAxes_PlottingArea1         matlab.ui.control.UIAxes
        Tab_Step2                    matlab.ui.container.Tab
        Step1Panel                   matlab.ui.container.Panel
        Label_12                     matlab.ui.control.Label
        EditField_16                 matlab.ui.control.NumericEditField
        EditField_17Label            matlab.ui.control.Label
        EditField_17                 matlab.ui.control.NumericEditField
        Label_11                     matlab.ui.control.Label
        EditField_15                 matlab.ui.control.NumericEditField
        EditField_14Label            matlab.ui.control.Label
        EditField_14                 matlab.ui.control.NumericEditField
        CheckBox_3                   matlab.ui.control.CheckBox
        CheckBox_2                   matlab.ui.control.CheckBox
        EditField_13Label            matlab.ui.control.Label
        EditField_13                 matlab.ui.control.NumericEditField
        Button_2                     matlab.ui.control.Button
        Panel_4                      matlab.ui.container.Panel
        EditField_18Label            matlab.ui.control.Label
        EditField_18                 matlab.ui.control.NumericEditField
        EditField_19Label            matlab.ui.control.Label
        EditField_19                 matlab.ui.control.NumericEditField
        EditField_20Label            matlab.ui.control.Label
        EditField_20                 matlab.ui.control.NumericEditField
        EditField_21Label            matlab.ui.control.Label
        EditField_21                 matlab.ui.control.NumericEditField
        ShowNetButton                matlab.ui.control.Button
        Panel_5                      matlab.ui.container.Panel
        EditField_22Label            matlab.ui.control.Label
        EditField_22                 matlab.ui.control.NumericEditField
        EditField_23Label            matlab.ui.control.Label
        EditField_23                 matlab.ui.control.NumericEditField
        EditField_24Label            matlab.ui.control.Label
        EditField_24                 matlab.ui.control.NumericEditField
        EditField_25Label            matlab.ui.control.Label
        EditField_25                 matlab.ui.control.NumericEditField
        EditField_26Label            matlab.ui.control.Label
        EditField_26                 matlab.ui.control.NumericEditField
        Label_13                     matlab.ui.control.Label
        DropDown                     matlab.ui.control.DropDown
        Button_3                     matlab.ui.control.Button
        UIAxes_PlottingArea2         matlab.ui.control.UIAxes
        Tab_Step3                    matlab.ui.container.Tab
        Panel_IterativeCalculation   matlab.ui.container.Panel
        Button_LoadFinalModel        matlab.ui.control.Button
        Label_FinalModelName         matlab.ui.control.Label
        CheckBox_isHeat              matlab.ui.control.CheckBox
        Label_3                      matlab.ui.control.Label
        NumericEditField_ViscosityRate3  matlab.ui.control.NumericEditField
        Label_4                      matlab.ui.control.Label
        NumericEditField_TotalCycle  matlab.ui.control.NumericEditField
        Button_StartCalculation      matlab.ui.control.Button
        Label_5                      matlab.ui.control.Label
        EditField_FileName3          matlab.ui.control.EditField
        Button_Save3                 matlab.ui.control.Button
        Table_EnergyAndHeatData      matlab.ui.control.Table
        UIAxes_PlottingArea3         matlab.ui.control.UIAxes
        Button_Run                   matlab.ui.control.Button
        Label                        matlab.ui.control.Label
        EditField_CommandLine        matlab.ui.control.EditField
        Button_Pause                 matlab.ui.control.Button
        Button_Continue              matlab.ui.control.Button
        Button_Stop                  matlab.ui.control.Button
        Label_6                      matlab.ui.control.Label
    end

    
    properties (Access = public)
        Settings;
        Box;
        DataCenter;
    end
    
    methods (Access = private)
        
        function setPlottingArea(app,parentHandle,parentHandlePos,plottingArea,plottingAreaPos)
            app.Settings.PlottingAreaParentHandle=parentHandle; %声明绘图区所在父窗口（或控件）的句柄。
            app.Settings.PlottingAreaParentPosition=parentHandlePos; %声明绘图区所在父窗口（或控件）的位置。
            app.Settings.PlottingAreaHandle=plottingArea; %声明绘图区的句柄。
            app.Settings.PlottingAreaPosition=plottingAreaPos; %声明绘图区的位置。
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            ufs.setUIoutputApp(app,app.TextArea_Message);
            ufs.setIconApp(app.SlopeNet,'Resources/MatDEMlogo.ico');
            app.Settings.PlottingAreaParentHandle=app.Tab_Step1; %声明绘图区所在父窗口（或控件）的句柄。
            app.Settings.PlottingAreaParentPosition=app.Tab_Step1.Position; %声明绘图区所在父窗口（或控件）的位置。
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingArea1; %声明绘图区的句柄。
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingArea1.Position; %声明绘图区的位置。
%             setappdata(0,'app',app); %将app设为全局变量。
%             setappdata(0,'CurrentWindow',1); %将全局变量CurrentWindow设为1。
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            fs.randSeed(1);%build random model
            B=obj_Box;%build a box object
            B.name=app.EditField.Value;
            B.GPUstatus='auto';
            B.ballR=app.EditField_2.Value;
            B.isClump=app.CheckBox.Value;
            B.distriRate=app.EditField_4.Value;
            B.sampleW=app.EditField_5.Value;
            B.sampleL=app.EditField_6.Value;
            B.sampleH=app.EditField_7.Value;
            %B.BexpandRate=4;
            %B.PexpandRate=4;
            B.type=app.EditField_3.Value;
            %B.type='TriaxialCompression';
            B.setType();
            B.buildInitialModel();%B.show();
            B.setUIoutput(app.TextArea_Message);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command
            
            d=B.d;%d.breakGroup('sample');d.breakGroup('lefPlaten');
            %--------------end initial model------------
            B.gravitySediment();
            B.compactSample(2);%input is compaction time
            mfs.reduceGravity(d,10);%reduce the gravity of element
            
            %------------return and save result--------------
%             d.status.dispEnergy();%display the energy of the model
%             app.setPlottingArea(app.Tab_Step1,app.Tab_Step1.Position,app.UIAxes_PlottingArea1,app.UIAxes_PlottingArea1.Position)
            d.show('aR');
            
            packBoxObj=B.d.group2Obj('sample');%make struct object from a group
            packBoxObj=mfs.moveObj2Origin(packBoxObj);
            sphereObj=mfs.cutSphereObj(packBoxObj,app.EditField_8.Value);
            sphereObj2=mfs.cutSphereObj(packBoxObj,app.EditField_9.Value);
            boxObj=mfs.cutBoxObj(packBoxObj,app.EditField_10.Value,app.EditField_11.Value,app.EditField_12.Value);
            d.mo.setGPU('off');
            d.clearData(1);%clear dependent data
            d.recordCalHour('Step1Finish');
            save(['TempModel/' B.name '1.mat'],'-regexp','[^app]');
            save(['TempModel/' B.name '1R' num2str(B.ballR) '-distri' num2str(B.distriRate) 'aNum' num2str(d.aNum) '.mat'],'-regexp','[^app]');
            d.calculateData();%because data is clear, it will be re-calculated
            app.Box=B;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command
            app.DataCenter=d;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            slopeW=app.EditField_22.Value;
            slopeL=app.EditField_24.Value;
            slopeH=app.EditField_23.Value;
            slope=mfs.denseModel(0.6,@mfs.makeBox,slopeW,slopeL,slopeH,app.EditField_25.Value);
            slopeId=d.addElement(1,slope,'boundary');%add a slope boundary
            d.addGroup('slope',slopeId);%add a new group
            rotateX=max(d.aX(d.GROUP.slope));rotateZ=max(d.aZ(d.GROUP.slope));
            d.rotateGroup('slope',app.DropDown.Value,app.EditField_26.Value,rotateX,0,rotateZ);%rotate the group along XZ plane
            d.moveGroup('slope',-min(d.aX(d.GROUP.slope)),0,-min(d.aZ(d.GROUP.slope)));%move the slope
            
            % slopeW=6/4;slopeL=B.sampleL;slopeH=B.ballR;
            % slope=mfs.denseModel(0.6,@mfs.makeBox,slopeW,slopeL,slopeH,B.ballR);%make a pile struct
            % slopeId=d.addElement(1,slope,'boundary');%add a slope boundary
            % d.addGroup('step',slopeId);%add a new group
            % rotateX=max(d.aX(d.GROUP.slope));rotateZ=max(d.aZ(d.GROUP.slope));
            % d.moveGroup('step',B.sampleW*0.4/2,0,B.sampleH*0.8/2);%move the slope
                      
            d.delElement('botPlaten');%remove bottom platen
            
            f.ChangePlottingAreaParent(app.Tab_Step2);
            f.ChangePlottingArea(app.UIAxes_PlottingArea2);
%             d.showFilter('Group', {'slope'}, 'aR');
            d.show('aR');
            
            %------------record data
            d.mo.setGPU('off');
            d.clearData(1);%clear dependent data in d
            d.recordCalHour('BoxSlopeNet2Finish');
            save(['TempModel/' B.name '2.mat'],'-regexp','[^app]');
            save(['TempModel/' B.name '2R' num2str(B.ballR) '-distri' num2str(B.distriRate) 'aNum' num2str(d.aNum) '.mat'],'-regexp','[^app]');
            d.calculateData();
            app.Box=B;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command
            app.DataCenter=d;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command
        end

        % Button pushed function: Button_Run
        function Button_RunPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
%             C=B.SET.C;
%             Data=app.OtherData;
            app.TextArea_Message.Value=[app.EditField_CommandLine.Value;app.TextArea_Message.Value];
            try
                eval(app.EditField_CommandLine.Value);
            catch ME
                app.TextArea_Message.Value=[ME.identifier;app.TextArea_Message.Value];
            end
            app.EditField_CommandLine.Value='';
%             B.SET.C=C;
            app.Box=B;
            app.DataCenter=d;
%             app.otherData=Data;
        end

        % Button pushed function: ShowNetButton
        function ShowNetButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
%             cellW=B.sampleL/10;
%             cellH=B.sampleL/10;
            netObj=mfs.denseModel(0.8,@mfs.makeNet,app.EditField_20.Value,app.EditField_21.Value,app.EditField_18.Value,app.EditField_19.Value,B.ballR);
%             fs.showObj(netObj);
            netId=d.addElement(1,netObj);%add a slope boundary
            d.addGroup('net',netId);%add a new group
            d.rotateGroup('net','XY',90,0,0,0);%rotate the group along XZ plane
            d.rotateGroup('net','XZ',180);%rotate the group along XZ plane
            %@@@@@@@@@@@@@@@@@add dZ here
            d.moveGroup('net',B.sampleW*0.8,0,0);
            d.setClump('net');
            %find the boundary of the net and fix them
            netY=d.mo.aY(netId);netZ=d.mo.aZ(netId);
            yFilter=(netY==min(netY)|netY==max(netY));
            zFilter=(netZ==min(netZ));
            netBoundaryFilter=yFilter|zFilter;
            boundaryNetId=netId(netBoundaryFilter);
            d.addFixId('X',boundaryNetId);%fix the X-coordinate
            d.addFixId('Y',boundaryNetId);
            d.addFixId('Z',boundaryNetId);
            
            f.ChangePlottingAreaParent(app.Tab_Step2);
            f.ChangePlottingArea(app.UIAxes_PlottingArea2);
%             d.showFilter('Group', {'net'}, 'aR');
            d.show('aR');
            
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            load('TempModel/SlopeNet1.mat');
            B.d.mo.setGPU('off');
                        
            %make a big box for the simulation
            fs.randSeed(1);%random model seed, 1,2,3...
            B=obj_Box;%declare a box object
            B.name='SlopeNet';
            %--------------initial model------------
            B.GPUstatus='auto';%program will test the CPU and GPU speed, and choose the quicker one
            B.ballR=app.EditField_13.Value;
            B.isShear=app.CheckBox_2.Value;
            B.isClump=app.CheckBox_3.Value;%if isClump=1, particles are composed of several balls
            B.distriRate=app.EditField_14.Value;%define distribution of ball radius,
            B.sampleW=app.EditField_16.Value;%width, length, height, average radius
            B.sampleL=app.EditField_17.Value;%when L is zero, it is a 2-dimensional model
            B.sampleH=app.EditField_15.Value;
            B.BexpandRate=2;%boundary is 4-ball wider than
            B.PexpandRate=0;
            B.type='botPlaten';%add a top platen to compact model
            B.isSample=0;
            B.setType();
            B.buildInitialModel();
            d=B.d;
            d.mo.setGPU('off');
            d.showB=3;
            
            %import the packed box (from step 1) on the top left side of the model
            sphereObjId=d.addElement(1,sphereObj);%add regular model elements (not boundary)
            d.addGroup('sphere',sphereObjId);%add a new group
            d.moveGroup('sphere',B.sampleW/8,B.sampleL*1/2,B.sampleH*3.05/4);
            d.setClump('sphere');
            
            sphereObjId=d.addElement(1,sphereObj2);%add regular model elements (not boundary)
            d.addGroup('sphere2',sphereObjId);%add a new group
            d.moveGroup('sphere2',B.sampleW*1.7/8,B.sampleL*1.38/4,B.sampleH*3.05/4);
            d.setClump('sphere2');
            
            boxObjId=d.addElement(1,boxObj);%add regular model elements (not boundary)
            d.addGroup('box',boxObjId);%add a new group
            %d.rotateGroup('box','XZ',10);
            d.moveGroup('box',B.sampleW/8,B.sampleL*1/4,B.sampleH*2.84/4);
            d.setClump('box');
            
            f.ChangePlottingAreaParent(app.Tab_Step2);
            f.ChangePlottingArea(app.UIAxes_PlottingArea2);
%             d.showFilter('Group', {'sphere','sphere2','box'}, 'aR');
            d.show('aR');
            
            app.Box=B;
            app.DataCenter=d;
            
            app.ShowNetButton.Enable='on';
            app.Button_3.Enable='on';
        end

        % Button pushed function: Button_LoadFinalModel
        function Button_LoadFinalModelPushed(app, event)
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
                        
            d.calculateData();
            d.mo.setGPU('off');
            d.getModel();%d.setModel();%reset the initial status of the model
            d.status=modelStatus(d);%initialize model status, which records running information
            
            app.Box=B;
            app.DataCenter=d;
            app.Button_StartCalculation.Enable='on';
            f.ChangePlottingAreaParent(app.Tab_Step3);
            f.ChangePlottingArea(app.UIAxes_PlottingArea3);
            d.showB=3;
%             d.showFilter();
%             d.showFilter('SlideY',0.3,0.7);
            d.show('aR');
        end

        % Button pushed function: Button_StartCalculation
        function Button_StartCalculationPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.mo.isHeat=app.CheckBox_isHeat.Value;%calculate heat in the model
            visRate=app.NumericEditField_ViscosityRate3.Value;
            d.mo.mVis=d.mo.mVis*visRate;%use low viscosity for dynamic simulation
            d.mo.setGPU('auto');
            d.setStandarddT();
            %d.mo.isShear=0;
            totalCircle=app.NumericEditField_TotalCycle.Value;
            d.tic(totalCircle);
            %.mat files will be saved in the folder data/step
            fName=['data/step/' B.name num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];
            save([fName '0.mat']);%return;
            for i=1:totalCircle
                d.balance(50,d.SET.packNum*1.5);
                d.mo.setGPU('off');
                if d.mo.isHeat==true
                    TotalHeat=sum(d.status.heats,2);
                    app.Table_EnergyAndHeatData.Data=[app.Table_EnergyAndHeatData.Data;{i,d.status.totalEs(end),TotalHeat(end)}];
                else
                    app.Table_EnergyAndHeatData.Data=[app.Table_EnergyAndHeatData.Data;{i,d.status.totalEs(end),'未记录热量'}];
                end
                d.show('mV');
                drawnow;
                d.clearData(1);%clear data in d.mo
                save([fName num2str(i) '.mat']);
                d.calculateData();
                d.toc();%show the note of time
            end
            fs.disp('已完成计算');
            app.Box=B;
            app.DataCenter=d;
            app.EditField_FileName3.Value=[B.name,'3'];
            app.Button_Save3.Enable='on';
        end

        % Button pushed function: Button_Save3
        function Button_Save3Pushed(app, event)
            B=app.Box;
            d=app.DataCenter;
%             C=B.SET.C;
            d.clearData(1);
            [file,path]=uiputfile(['TempModel/',app.EditField_FileName3.Value,'.mat']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'B','d','-v7.3');
                fs.disp(['已保存模型：',path,file]);
            end
        end

        % Button pushed function: Button_Pause
        function Button_PausePushed(app, event)
            app.Button_Pause.Enable='off';
            app.Button_Continue.Enable='on';
            ufs.uiwait(app.SlopeNet);
        end

        % Button pushed function: Button_Continue
        function Button_ContinuePushed(app, event)
            app.Button_Pause.Enable='on';
            app.Button_Continue.Enable='off';
            ufs.uiresume(app.SlopeNet);
        end

        % Button pushed function: Button_Stop
        function Button_StopPushed(app, event)
            app.Button_Pause.Enable='on';
            ufs.stopRun(app.SlopeNet,app.Box);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create SlopeNet and hide until all components are created
            app.SlopeNet = uifigure('Visible', 'off');
            app.SlopeNet.Position = [100 100 827 597];
            app.SlopeNet.Name = '柔性防护挡网试验室';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.SlopeNet);
            app.TextArea_Message.Position = [17 8 791 87];
            app.TextArea_Message.Value = {'Output meseage'};

            % Create TabGroup
            app.TabGroup = uitabgroup(app.SlopeNet);
            app.TabGroup.Position = [15 169 805 414];

            % Create Tab_Step1
            app.Tab_Step1 = uitab(app.TabGroup);
            app.Tab_Step1.Title = 'Step1 堆积与切割模型';

            % Create Button
            app.Button = uibutton(app.Tab_Step1, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [86.5 20 122 25];
            app.Button.Text = '堆积与切割模型';

            % Create Panel
            app.Panel = uipanel(app.Tab_Step1);
            app.Panel.Title = '堆积模型';
            app.Panel.Position = [13 193 292 171];

            % Create CheckBox
            app.CheckBox = uicheckbox(app.Panel);
            app.CheckBox.Text = '是否团簇';
            app.CheckBox.Position = [188 80 70 22];

            % Create Label_7
            app.Label_7 = uilabel(app.Panel);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.Position = [1 115 53 22];
            app.Label_7.Text = '模型名称';

            % Create EditField
            app.EditField = uieditfield(app.Panel, 'text');
            app.EditField.HorizontalAlignment = 'center';
            app.EditField.Position = [64 115 70 22];
            app.EditField.Value = 'SlopeNet';

            % Create EditField_2Label
            app.EditField_2Label = uilabel(app.Panel);
            app.EditField_2Label.HorizontalAlignment = 'right';
            app.EditField_2Label.Position = [142 115 53 22];
            app.EditField_2Label.Text = '单元半径';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.Panel, 'numeric');
            app.EditField_2.HorizontalAlignment = 'center';
            app.EditField_2.Position = [203 115 68 22];
            app.EditField_2.Value = 0.1;

            % Create EditField_5Label
            app.EditField_5Label = uilabel(app.Panel);
            app.EditField_5Label.HorizontalAlignment = 'right';
            app.EditField_5Label.Position = [142 47 65 22];
            app.EditField_5Label.Text = '模型箱宽度';

            % Create EditField_5
            app.EditField_5 = uieditfield(app.Panel, 'numeric');
            app.EditField_5.HorizontalAlignment = 'center';
            app.EditField_5.Position = [214 47 68 22];
            app.EditField_5.Value = 1;

            % Create EditField_6Label
            app.EditField_6Label = uilabel(app.Panel);
            app.EditField_6Label.HorizontalAlignment = 'right';
            app.EditField_6Label.Position = [1 14 65 22];
            app.EditField_6Label.Text = '模型箱长度';

            % Create EditField_6
            app.EditField_6 = uieditfield(app.Panel, 'numeric');
            app.EditField_6.HorizontalAlignment = 'center';
            app.EditField_6.Position = [74 14 68 22];
            app.EditField_6.Value = 1;

            % Create EditField_3Label
            app.EditField_3Label = uilabel(app.Panel);
            app.EditField_3Label.HorizontalAlignment = 'right';
            app.EditField_3Label.Position = [2 80 53 22];
            app.EditField_3Label.Text = '模型类型';

            % Create EditField_3
            app.EditField_3 = uieditfield(app.Panel, 'text');
            app.EditField_3.HorizontalAlignment = 'center';
            app.EditField_3.Position = [63 81 86 22];
            app.EditField_3.Value = 'GeneralSlope';

            % Create EditField_4Label
            app.EditField_4Label = uilabel(app.Panel);
            app.EditField_4Label.HorizontalAlignment = 'right';
            app.EditField_4Label.Position = [2 47 53 22];
            app.EditField_4Label.Text = '分散系数';

            % Create EditField_4
            app.EditField_4 = uieditfield(app.Panel, 'numeric');
            app.EditField_4.HorizontalAlignment = 'center';
            app.EditField_4.Position = [64 47 68 22];
            app.EditField_4.Value = 0.2;

            % Create EditField_7Label
            app.EditField_7Label = uilabel(app.Panel);
            app.EditField_7Label.HorizontalAlignment = 'right';
            app.EditField_7Label.Position = [143 14 65 22];
            app.EditField_7Label.Text = '模型箱高度';

            % Create EditField_7
            app.EditField_7 = uieditfield(app.Panel, 'numeric');
            app.EditField_7.HorizontalAlignment = 'center';
            app.EditField_7.Position = [214 14 68 22];
            app.EditField_7.Value = 1.2;

            % Create Panel_2
            app.Panel_2 = uipanel(app.Tab_Step1);
            app.Panel_2.Title = '切割模型形成崩塌物体';
            app.Panel_2.Position = [14 68 292 105];

            % Create EditField_8Label
            app.EditField_8Label = uilabel(app.Panel_2);
            app.EditField_8Label.HorizontalAlignment = 'right';
            app.EditField_8Label.Position = [0 48 60 22];
            app.EditField_8Label.Text = '球体1半径';

            % Create EditField_8
            app.EditField_8 = uieditfield(app.Panel_2, 'numeric');
            app.EditField_8.HorizontalAlignment = 'center';
            app.EditField_8.Position = [68 48 68 22];
            app.EditField_8.Value = 0.4;

            % Create EditField_9Label
            app.EditField_9Label = uilabel(app.Panel_2);
            app.EditField_9Label.HorizontalAlignment = 'right';
            app.EditField_9Label.Position = [152 48 60 22];
            app.EditField_9Label.Text = '球体2半径';

            % Create EditField_9
            app.EditField_9 = uieditfield(app.Panel_2, 'numeric');
            app.EditField_9.HorizontalAlignment = 'center';
            app.EditField_9.Position = [218 48 68 22];
            app.EditField_9.Value = 0.2333;

            % Create Label_8
            app.Label_8 = uilabel(app.Panel_2);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.Position = [16 7 29 32];
            app.Label_8.Text = {'块体'; '宽度'};

            % Create EditField_10
            app.EditField_10 = uieditfield(app.Panel_2, 'numeric');
            app.EditField_10.HorizontalAlignment = 'center';
            app.EditField_10.Position = [54 12 42 22];
            app.EditField_10.Value = 0.5;

            % Create Label_9
            app.Label_9 = uilabel(app.Panel_2);
            app.Label_9.HorizontalAlignment = 'right';
            app.Label_9.Position = [107 7 29 32];
            app.Label_9.Text = {'块体'; '长度'};

            % Create EditField_11
            app.EditField_11 = uieditfield(app.Panel_2, 'numeric');
            app.EditField_11.HorizontalAlignment = 'center';
            app.EditField_11.Position = [146 12 42 22];
            app.EditField_11.Value = 0.4;

            % Create Label_10
            app.Label_10 = uilabel(app.Panel_2);
            app.Label_10.HorizontalAlignment = 'right';
            app.Label_10.Position = [199 7 29 32];
            app.Label_10.Text = {'块体'; '高度'};

            % Create EditField_12
            app.EditField_12 = uieditfield(app.Panel_2, 'numeric');
            app.EditField_12.HorizontalAlignment = 'center';
            app.EditField_12.Position = [240 12 42 22];
            app.EditField_12.Value = 0.333;

            % Create UIAxes_PlottingArea1
            app.UIAxes_PlottingArea1 = uiaxes(app.Tab_Step1);
            title(app.UIAxes_PlottingArea1, '绘图区')
            xlabel(app.UIAxes_PlottingArea1, 'X')
            ylabel(app.UIAxes_PlottingArea1, 'Y')
            app.UIAxes_PlottingArea1.PlotBoxAspectRatio = [1.30612244897959 1 1];
            app.UIAxes_PlottingArea1.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea1.Position = [335 12 457 369];

            % Create Tab_Step2
            app.Tab_Step2 = uitab(app.TabGroup);
            app.Tab_Step2.Title = 'Step2 结构体建模';

            % Create Step1Panel
            app.Step1Panel = uipanel(app.Tab_Step2);
            app.Step1Panel.Title = '建立空箱子并导入Step1中切割的模型';
            app.Step1Panel.Position = [12 210 311 170];

            % Create Label_12
            app.Label_12 = uilabel(app.Step1Panel);
            app.Label_12.HorizontalAlignment = 'right';
            app.Label_12.Position = [160 46 65 22];
            app.Label_12.Text = '模型箱宽度';

            % Create EditField_16
            app.EditField_16 = uieditfield(app.Step1Panel, 'numeric');
            app.EditField_16.HorizontalAlignment = 'center';
            app.EditField_16.Position = [229 46 68 22];
            app.EditField_16.Value = 7;

            % Create EditField_17Label
            app.EditField_17Label = uilabel(app.Step1Panel);
            app.EditField_17Label.HorizontalAlignment = 'right';
            app.EditField_17Label.Position = [-5 13 65 22];
            app.EditField_17Label.Text = '模型箱长度';

            % Create EditField_17
            app.EditField_17 = uieditfield(app.Step1Panel, 'numeric');
            app.EditField_17.HorizontalAlignment = 'center';
            app.EditField_17.Position = [68 13 68 22];
            app.EditField_17.Value = 4;

            % Create Label_11
            app.Label_11 = uilabel(app.Step1Panel);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.Position = [0 46 65 22];
            app.Label_11.Text = '模型箱高度';

            % Create EditField_15
            app.EditField_15 = uieditfield(app.Step1Panel, 'numeric');
            app.EditField_15.HorizontalAlignment = 'center';
            app.EditField_15.Position = [71 46 68 22];
            app.EditField_15.Value = 4;

            % Create EditField_14Label
            app.EditField_14Label = uilabel(app.Step1Panel);
            app.EditField_14Label.HorizontalAlignment = 'right';
            app.EditField_14Label.Position = [12 79 53 22];
            app.EditField_14Label.Text = '分散系数';

            % Create EditField_14
            app.EditField_14 = uieditfield(app.Step1Panel, 'numeric');
            app.EditField_14.HorizontalAlignment = 'center';
            app.EditField_14.Position = [69 79 68 22];
            app.EditField_14.Value = 0.2;

            % Create CheckBox_3
            app.CheckBox_3 = uicheckbox(app.Step1Panel);
            app.CheckBox_3.Text = '是否团簇';
            app.CheckBox_3.Position = [188 79 70 22];

            % Create CheckBox_2
            app.CheckBox_2 = uicheckbox(app.Step1Panel);
            app.CheckBox_2.Text = '是否有剪力';
            app.CheckBox_2.Position = [188 114 82 22];

            % Create EditField_13Label
            app.EditField_13Label = uilabel(app.Step1Panel);
            app.EditField_13Label.HorizontalAlignment = 'right';
            app.EditField_13Label.Position = [0 114 53 22];
            app.EditField_13Label.Text = '单元半径';

            % Create EditField_13
            app.EditField_13 = uieditfield(app.Step1Panel, 'numeric');
            app.EditField_13.HorizontalAlignment = 'center';
            app.EditField_13.Position = [68 114 68 22];
            app.EditField_13.Value = 0.1;

            % Create Button_2
            app.Button_2 = uibutton(app.Step1Panel, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.Position = [183 10 100 25];
            app.Button_2.Text = '显示切割模型';

            % Create Panel_4
            app.Panel_4 = uipanel(app.Tab_Step2);
            app.Panel_4.Title = '防护网';
            app.Panel_4.Position = [12 119 311 92];

            % Create EditField_18Label
            app.EditField_18Label = uilabel(app.Panel_4);
            app.EditField_18Label.HorizontalAlignment = 'right';
            app.EditField_18Label.Position = [19 36 29 32];
            app.EditField_18Label.Text = {'网眼'; '宽度'};

            % Create EditField_18
            app.EditField_18 = uieditfield(app.Panel_4, 'numeric');
            app.EditField_18.HorizontalAlignment = 'center';
            app.EditField_18.Position = [54 41 42 22];
            app.EditField_18.Value = 0.4;

            % Create EditField_19Label
            app.EditField_19Label = uilabel(app.Panel_4);
            app.EditField_19Label.HorizontalAlignment = 'right';
            app.EditField_19Label.Position = [112 36 29 32];
            app.EditField_19Label.Text = {'网眼'; '高度'};

            % Create EditField_19
            app.EditField_19 = uieditfield(app.Panel_4, 'numeric');
            app.EditField_19.HorizontalAlignment = 'center';
            app.EditField_19.Position = [148 41 42 22];
            app.EditField_19.Value = 0.4;

            % Create EditField_20Label
            app.EditField_20Label = uilabel(app.Panel_4);
            app.EditField_20Label.HorizontalAlignment = 'right';
            app.EditField_20Label.Position = [10 8 38 22];
            app.EditField_20Label.Text = '网宽';

            % Create EditField_20
            app.EditField_20 = uieditfield(app.Panel_4, 'numeric');
            app.EditField_20.HorizontalAlignment = 'center';
            app.EditField_20.Position = [54 8 42 22];
            app.EditField_20.Value = 4;

            % Create EditField_21Label
            app.EditField_21Label = uilabel(app.Panel_4);
            app.EditField_21Label.HorizontalAlignment = 'right';
            app.EditField_21Label.Position = [104 8 37 22];
            app.EditField_21Label.Text = '网高';

            % Create EditField_21
            app.EditField_21 = uieditfield(app.Panel_4, 'numeric');
            app.EditField_21.HorizontalAlignment = 'center';
            app.EditField_21.Position = [148 8 42 22];
            app.EditField_21.Value = 1.333;

            % Create ShowNetButton
            app.ShowNetButton = uibutton(app.Panel_4, 'push');
            app.ShowNetButton.ButtonPushedFcn = createCallbackFcn(app, @ShowNetButtonPushed, true);
            app.ShowNetButton.Enable = 'off';
            app.ShowNetButton.Position = [217 17 75 25];
            app.ShowNetButton.Text = '显示防护网';

            % Create Panel_5
            app.Panel_5 = uipanel(app.Tab_Step2);
            app.Panel_5.Title = '斜坡';
            app.Panel_5.Position = [12 1 311 119];

            % Create EditField_22Label
            app.EditField_22Label = uilabel(app.Panel_5);
            app.EditField_22Label.HorizontalAlignment = 'right';
            app.EditField_22Label.Position = [3 68 53 22];
            app.EditField_22Label.Text = '斜坡宽度';

            % Create EditField_22
            app.EditField_22 = uieditfield(app.Panel_5, 'numeric');
            app.EditField_22.HorizontalAlignment = 'center';
            app.EditField_22.Position = [60 68 42 22];
            app.EditField_22.Value = 6;

            % Create EditField_23Label
            app.EditField_23Label = uilabel(app.Panel_5);
            app.EditField_23Label.HorizontalAlignment = 'right';
            app.EditField_23Label.Position = [102 68 53 22];
            app.EditField_23Label.Text = '斜坡高度';

            % Create EditField_23
            app.EditField_23 = uieditfield(app.Panel_5, 'numeric');
            app.EditField_23.HorizontalAlignment = 'center';
            app.EditField_23.Position = [159 68 42 22];
            app.EditField_23.Value = 0.1;

            % Create EditField_24Label
            app.EditField_24Label = uilabel(app.Panel_5);
            app.EditField_24Label.HorizontalAlignment = 'right';
            app.EditField_24Label.Position = [201 68 53 22];
            app.EditField_24Label.Text = '斜坡长度';

            % Create EditField_24
            app.EditField_24 = uieditfield(app.Panel_5, 'numeric');
            app.EditField_24.HorizontalAlignment = 'center';
            app.EditField_24.Position = [258 68 42 22];
            app.EditField_24.Value = 4;

            % Create EditField_25Label
            app.EditField_25Label = uilabel(app.Panel_5);
            app.EditField_25Label.HorizontalAlignment = 'right';
            app.EditField_25Label.Position = [16 4 53 22];
            app.EditField_25Label.Text = '颗粒半径';

            % Create EditField_25
            app.EditField_25 = uieditfield(app.Panel_5, 'numeric');
            app.EditField_25.HorizontalAlignment = 'center';
            app.EditField_25.Position = [73 4 42 22];
            app.EditField_25.Value = 0.1;

            % Create EditField_26Label
            app.EditField_26Label = uilabel(app.Panel_5);
            app.EditField_26Label.HorizontalAlignment = 'right';
            app.EditField_26Label.Position = [13 37 77 22];
            app.EditField_26Label.Text = '斜坡旋转角度';

            % Create EditField_26
            app.EditField_26 = uieditfield(app.Panel_5, 'numeric');
            app.EditField_26.ValueDisplayFormat = '%11.4g 度';
            app.EditField_26.HorizontalAlignment = 'center';
            app.EditField_26.Position = [94 37 42 22];
            app.EditField_26.Value = -30;

            % Create Label_13
            app.Label_13 = uilabel(app.Panel_5);
            app.Label_13.HorizontalAlignment = 'right';
            app.Label_13.Position = [170 37 53 22];
            app.Label_13.Text = '旋转平面';

            % Create DropDown
            app.DropDown = uidropdown(app.Panel_5);
            app.DropDown.Items = {'XY', 'YZ', 'XZ'};
            app.DropDown.Position = [231 37 49 22];
            app.DropDown.Value = 'XZ';

            % Create Button_3
            app.Button_3 = uibutton(app.Panel_5, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.Enable = 'off';
            app.Button_3.Position = [179 3 100 25];
            app.Button_3.Text = '显示斜坡';

            % Create UIAxes_PlottingArea2
            app.UIAxes_PlottingArea2 = uiaxes(app.Tab_Step2);
            title(app.UIAxes_PlottingArea2, '绘图区')
            xlabel(app.UIAxes_PlottingArea2, 'X')
            ylabel(app.UIAxes_PlottingArea2, 'Y')
            app.UIAxes_PlottingArea2.PlotBoxAspectRatio = [1.30612244897959 1 1];
            app.UIAxes_PlottingArea2.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea2.Position = [335 12 457 369];

            % Create Tab_Step3
            app.Tab_Step3 = uitab(app.TabGroup);
            app.Tab_Step3.Title = '第3步：平衡迭代';

            % Create Panel_IterativeCalculation
            app.Panel_IterativeCalculation = uipanel(app.Tab_Step3);
            app.Panel_IterativeCalculation.Title = '迭代计算';
            app.Panel_IterativeCalculation.Position = [21 210 272 165];

            % Create Button_LoadFinalModel
            app.Button_LoadFinalModel = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_LoadFinalModel.ButtonPushedFcn = createCallbackFcn(app, @Button_LoadFinalModelPushed, true);
            app.Button_LoadFinalModel.Position = [21 109 70 24];
            app.Button_LoadFinalModel.Text = '导入模型';

            % Create Label_FinalModelName
            app.Label_FinalModelName = uilabel(app.Panel_IterativeCalculation);
            app.Label_FinalModelName.Position = [101 111 140 22];
            app.Label_FinalModelName.Text = '尚未导入任何数据文件！';

            % Create CheckBox_isHeat
            app.CheckBox_isHeat = uicheckbox(app.Panel_IterativeCalculation);
            app.CheckBox_isHeat.Text = '计算热量';
            app.CheckBox_isHeat.Position = [19 73 70 22];
            app.CheckBox_isHeat.Value = true;

            % Create Label_3
            app.Label_3 = uilabel(app.Panel_IterativeCalculation);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [110 73 53 22];
            app.Label_3.Text = '阻尼倍率';

            % Create NumericEditField_ViscosityRate3
            app.NumericEditField_ViscosityRate3 = uieditfield(app.Panel_IterativeCalculation, 'numeric');
            app.NumericEditField_ViscosityRate3.Limits = [0 1];
            app.NumericEditField_ViscosityRate3.HorizontalAlignment = 'center';
            app.NumericEditField_ViscosityRate3.Position = [178 73 60 22];
            app.NumericEditField_ViscosityRate3.Value = 0.0001;

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_IterativeCalculation);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [19 42 53 22];
            app.Label_4.Text = '循环总数';

            % Create NumericEditField_TotalCycle
            app.NumericEditField_TotalCycle = uieditfield(app.Panel_IterativeCalculation, 'numeric');
            app.NumericEditField_TotalCycle.Limits = [1 Inf];
            app.NumericEditField_TotalCycle.HorizontalAlignment = 'center';
            app.NumericEditField_TotalCycle.Position = [87 42 40 22];
            app.NumericEditField_TotalCycle.Value = 2;

            % Create Button_StartCalculation
            app.Button_StartCalculation = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_StartCalculation.ButtonPushedFcn = createCallbackFcn(app, @Button_StartCalculationPushed, true);
            app.Button_StartCalculation.Enable = 'off';
            app.Button_StartCalculation.Position = [148 41 90 24];
            app.Button_StartCalculation.Text = '开始计算';

            % Create Label_5
            app.Label_5 = uilabel(app.Panel_IterativeCalculation);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [19 10 41 22];
            app.Label_5.Text = '文件名';

            % Create EditField_FileName3
            app.EditField_FileName3 = uieditfield(app.Panel_IterativeCalculation, 'text');
            app.EditField_FileName3.Position = [69 10 80 22];

            % Create Button_Save3
            app.Button_Save3 = uibutton(app.Panel_IterativeCalculation, 'push');
            app.Button_Save3.ButtonPushedFcn = createCallbackFcn(app, @Button_Save3Pushed, true);
            app.Button_Save3.Enable = 'off';
            app.Button_Save3.Position = [168 9 50 24];
            app.Button_Save3.Text = '保存';

            % Create Table_EnergyAndHeatData
            app.Table_EnergyAndHeatData = uitable(app.Tab_Step3);
            app.Table_EnergyAndHeatData.ColumnName = {'循环次数'; '能量'; '热量'};
            app.Table_EnergyAndHeatData.RowName = {};
            app.Table_EnergyAndHeatData.Position = [21 25 272 169];

            % Create UIAxes_PlottingArea3
            app.UIAxes_PlottingArea3 = uiaxes(app.Tab_Step3);
            title(app.UIAxes_PlottingArea3, '绘图区')
            xlabel(app.UIAxes_PlottingArea3, 'X')
            ylabel(app.UIAxes_PlottingArea3, 'Y')
            app.UIAxes_PlottingArea3.PlotBoxAspectRatio = [1.30612244897959 1 1];
            app.UIAxes_PlottingArea3.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea3.Position = [305 12 487 369];

            % Create Button_Run
            app.Button_Run = uibutton(app.SlopeNet, 'push');
            app.Button_Run.ButtonPushedFcn = createCallbackFcn(app, @Button_RunPushed, true);
            app.Button_Run.Position = [747 107 61 24];
            app.Button_Run.Text = '运行';

            % Create Label
            app.Label = uilabel(app.SlopeNet);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [16 108 41 22];
            app.Label.Text = '命令行';

            % Create EditField_CommandLine
            app.EditField_CommandLine = uieditfield(app.SlopeNet, 'text');
            app.EditField_CommandLine.Position = [72 108 652 22];

            % Create Button_Pause
            app.Button_Pause = uibutton(app.SlopeNet, 'push');
            app.Button_Pause.ButtonPushedFcn = createCallbackFcn(app, @Button_PausePushed, true);
            app.Button_Pause.Tooltip = {'Pause'};
            app.Button_Pause.Position = [78 135 32 26];
            app.Button_Pause.Text = '||';

            % Create Button_Continue
            app.Button_Continue = uibutton(app.SlopeNet, 'push');
            app.Button_Continue.ButtonPushedFcn = createCallbackFcn(app, @Button_ContinuePushed, true);
            app.Button_Continue.Enable = 'off';
            app.Button_Continue.Tooltip = {'Continue'};
            app.Button_Continue.Position = [118 135 32 26];
            app.Button_Continue.Text = '>';

            % Create Button_Stop
            app.Button_Stop = uibutton(app.SlopeNet, 'push');
            app.Button_Stop.ButtonPushedFcn = createCallbackFcn(app, @Button_StopPushed, true);
            app.Button_Stop.Tooltip = {'Stop'};
            app.Button_Stop.Position = [158 135 32 26];
            app.Button_Stop.Text = 'x';

            % Create Label_6
            app.Label_6 = uilabel(app.SlopeNet);
            app.Label_6.Position = [18 139 51 22];
            app.Label_6.Text = '命令控制';

            % Show the figure after all components are created
            app.SlopeNet.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_SlopeNet

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.SlopeNet)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.SlopeNet)
        end
    end
end