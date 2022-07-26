classdef UI_Roller_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        RollerUIFigure           matlab.ui.Figure
        TextArea_Message         matlab.ui.control.TextArea
        Step1Panel               matlab.ui.container.Panel
        RollerRadiusLabel        matlab.ui.control.Label
        RollerRadiusEditField    matlab.ui.control.NumericEditField
        RollerLengthLabel        matlab.ui.control.Label
        RollerLengthEditField    matlab.ui.control.NumericEditField
        RrateLabel               matlab.ui.control.Label
        RrateEditField           matlab.ui.control.NumericEditField
        BallradiusLabel          matlab.ui.control.Label
        BallradiusEditField      matlab.ui.control.NumericEditField
        BuildRollerButton        matlab.ui.control.Button
        Step2Panel               matlab.ui.container.Panel
        TotalCircleLabel         matlab.ui.control.Label
        TotalCircleEditField     matlab.ui.control.NumericEditField
        StepNumLabel             matlab.ui.control.Label
        StepNumEditField         matlab.ui.control.NumericEditField
        SpeeddegreesSliderLabel  matlab.ui.control.Label
        SpeeddegreesSlider       matlab.ui.control.Slider
        ControlPanel             matlab.ui.container.Panel
        Button_Pause             matlab.ui.control.Button
        Button_Continue          matlab.ui.control.Button
        Button_Stop              matlab.ui.control.Button
        StartRollingButton       matlab.ui.control.Button
        SpeedEditField           matlab.ui.control.NumericEditField
    end

    
    properties (Access = public)
        Settings;
        SET0 % Description
        Box % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
        
            setappdata(0,'isWinApp',1);%
            ufs.setUIoutputApp(app,app.TextArea_Message);
            ufs.setIconApp(app.RollerUIFigure,'Resources/MatDEMlogo.ico');
        end

        % Button pushed function: StartRollingButton
        function StartRollingButtonPushed(app, event)
            
            load('TempModel/Roller1.mat');
            app.Box=B;
            B.setUIoutput(app.TextArea_Message);
            d=B.d;
            d.calculateData();
            d.mo.setGPU('off');
            d.getModel();%get xyz from d.mo
            
            d.showB=2;
            showType='mV';
            d.showFilter('Group',{'tube','sample'});
            d.status.legendLocation='West';
            figureNumber=d.show(showType);
            d.figureNumber=figureNumber;
            
            d.mo.setShear('off');
            d.setStandarddT();
            d.mo.dT=d.mo.dT*4;
            
            d.mo.setGPU('auto');
            
            totalCircle=B.SET.totalCircle;
            stepNum=B.SET.stepNum;
            d.tic(totalCircle);
            fName=['data/step/' B.name num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];
            save([fName '0.mat']);%return;
            for i=1:totalCircle
                for j=1:stepNum
                    speed=app.SpeedEditField.Value;
                    dAngle=speed*d.mo.dT;%rotation angle per time step
                    d.rotateGroup('tube','XZ',dAngle,d.SET.Cx,d.SET.Cy,d.SET.Cz,'mo');
                    d.balance();
                end
                d.recordStatus();
                d.showFilter('Group',{'tube','sample'});
                d.show(showType);
                d.toc();%show the note of time
                pause(0.05);
            end
            
            d.mo.setGPU('off');
            d.clearData(1);
            d.recordCalHour('BoxTunnelHeat2Finish');
            save(['TempModel/' B.name '2.mat'],'B','d');
            save(['TempModel/' B.name '2R' num2str(B.ballR) '-distri' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
            %--------------------end save data-----------------------
            d.calculateData();
        end

        % Button pushed function: BuildRollerButton
        function BuildRollerButtonPushed(app, event)
            SET.ballR = app.BallradiusEditField.Value;
            SET.Rrate=app.RrateEditField.Value;
            SET.rollerInnerR=app.RollerRadiusEditField.Value;
            SET.rollerLength=app.RollerLengthEditField.Value;
            SET.totalCircle=app.TotalCircleEditField.Value;%loop time
            SET.stepNum=app.StepNumEditField.Value;%step per loop
            SET.speed=app.SpeeddegreesSlider.Value+1;%rotation degree per second
            app.SET0=SET;
            
            clear app event;
            
            ballR=SET.ballR;
            tubeR=SET.rollerInnerR+SET.ballR;
            tubeL=SET.rollerLength+SET.ballR*2;
            innerWidth=SET.rollerInnerR*0.3;
            sampleSide=SET.rollerInnerR*1.1;
            sampleLength=tubeL*0.9;
            
            distriRate=0.2;
            sampleObj=mfs.denseModel(1+distriRate,@mfs.makeBox,sampleSide,sampleLength,sampleSide,ballR);
            randRRate=(1-distriRate)+rand(size(sampleObj.R))*distriRate*2;
            sampleObj.R=sampleObj.R.*randRRate;
            sampleObj=mfs.moveObj2Origin(sampleObj);
            %fs.showObj(sampleObj);return
            
            
            tubeObj=mfs.denseModel(SET.Rrate,@mfs.makeTube,tubeR+(1-SET.Rrate)*ballR*2,tubeL,ballR);
            tubeObj=mfs.moveObj2Origin(tubeObj);
            
            planeObj=mfs.denseModel(SET.Rrate,@mfs.makeBox,innerWidth,tubeL,ballR,ballR);
            planeObj.Z=planeObj.Z-ballR;
            planeObj=mfs.rotate(planeObj,'YZ',90);
            planeObj=mfs.move(planeObj,SET.rollerInnerR-innerWidth,0,-tubeL/2);
            planeObj=mfs.rotateCopy(planeObj,60,6);%plane
            tubeObj=mfs.combineObj(tubeObj,planeObj);
            
            bacDiscObj=mfs.denseModel(SET.Rrate,@mfs.makeDisc,SET.rollerInnerR+(1-SET.Rrate)*ballR*1,ballR);
            bacDiscObj=mfs.moveObj2Origin(bacDiscObj);
            bacDiscObj=mfs.move(bacDiscObj,0,0,-SET.rollerLength/2-ballR);
            froDiscObj=mfs.move(bacDiscObj,0,0,SET.rollerLength+ballR*2);
            
            tubeObj=mfs.rotate(tubeObj,'YZ',90);
            bacDiscObj=mfs.rotate(bacDiscObj,'YZ',90);
            froDiscObj=mfs.rotate(froDiscObj,'YZ',90);
            
            tubeOuterR=tubeR+ballR;
            discOuterL=max(bacDiscObj.Y)+ballR;
            tubeObj=mfs.move(tubeObj,tubeOuterR,discOuterL,tubeOuterR);
            bacDiscObj=mfs.move(bacDiscObj,tubeOuterR,discOuterL,tubeOuterR);
            froDiscObj=mfs.move(froDiscObj,tubeOuterR,discOuterL,tubeOuterR);
            sampleObj=mfs.move(sampleObj,tubeOuterR,discOuterL,tubeOuterR);
            
            %             fs.showObj(tubeObj,'add');
            %             hold all;
            %             fs.showObj(bacDiscObj,'add');
            %             fs.showObj(sampleObj);
            %             fs.generalView();
            %             return
            
            fs.randSeed(1);%random model seed, 1,2,3...
            B=obj_Box;%declare a box object
            B.name='Roller';
            %--------------initial model------------
            B.GPUstatus='auto';%program will test the CPU and GPU speed, and choose the quicker one
            B.ballR=ballR;
            B.isShear=0;
            B.sampleW=tubeOuterR*2;
            B.sampleL=discOuterL*2;
            B.sampleH=tubeOuterR*2;
            B.SET.speed=SET.speed;
            B.SET.totalCircle=SET.totalCircle;
            B.SET.stepNum=SET.stepNum;
            B.isSample=0;
            B.setType('botPlaten');
            B.buildInitialModel();
            d=B.d;
            d.mo.setGPU('off');
            
            matTxt1=load('Mats\rubber.txt');
            matTxt1(1)=matTxt1(1)/100;
            Mats{1,1}=material('rubber',matTxt1,B.ballR);
            Mats{1,1}.Id=1;
            d.Mats=Mats;
            
            G=d.GROUP;
            d.delElement([G.lefB;G.rigB;G.froB;G.bacB;G.botB;G.topB]);
            
            [froDiscId,bacDiscId]=d.addElement(1,{froDiscObj,bacDiscObj},'wall');
            d.addGroup('froB',froDiscId);
            d.addGroup('bacB',bacDiscId);
            
            tubeId=d.addElement(1,tubeObj,'wall');
            d.addGroup('tube',tubeId);
            
            tubeX=d.aX(d.GROUP.tube);
            meanTubeX=mean(tubeX);
            lefTubeId=tubeId(tubeX<meanTubeX);
            rigTubeId=tubeId(tubeX>=meanTubeX);
            d.addGroup('lefB',lefTubeId);
            d.addGroup('rigB',rigTubeId);
            
            sampleId=d.addElement(1,sampleObj,'model');
            d.addGroup('sample',sampleId);
            d.delElement('botPlaten');
            d.SET.Cx=tubeOuterR;
            d.SET.Cy=discOuterL;
            d.SET.Cz=tubeOuterR;
            d.groupMat2Model();
            
            d.showB=2;
            figure
            d.showFilter('Group',{'tube','sample'},'aR');
            
            save(['TempModel/' B.name '1.mat'],'B','d');
            save(['TempModel/' B.name '1R' num2str(B.ballR) '-distri' num2str(B.distriRate)  'aNum' num2str(d.aNum) '.mat']);
        end

        % Button pushed function: Button_Pause
        function Button_PausePushed(app, event)
            ufs.uiwait(app.RollerUIFigure);
        end

        % Button pushed function: Button_Continue
        function Button_ContinuePushed(app, event)
            ufs.uiresume(app.RollerUIFigure);
        end

        % Button pushed function: Button_Stop
        function Button_StopPushed(app, event)
            ufs.stopRun(app.RollerUIFigure,app.Box);
        end

        % Value changed function: SpeeddegreesSlider
        function SpeeddegreesSliderValueChanged(app, event)
            value = app.SpeeddegreesSlider.Value;
            app.SpeedEditField.Value=value;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create RollerUIFigure and hide until all components are created
            app.RollerUIFigure = uifigure('Visible', 'off');
            app.RollerUIFigure.Position = [100 100 332 457];
            app.RollerUIFigure.Name = 'Roller';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.RollerUIFigure);
            app.TextArea_Message.Position = [11 8 310 110];
            app.TextArea_Message.Value = {'Message'};

            % Create Step1Panel
            app.Step1Panel = uipanel(app.RollerUIFigure);
            app.Step1Panel.Title = 'Step 1';
            app.Step1Panel.Position = [11 328 310 120];

            % Create RollerRadiusLabel
            app.RollerRadiusLabel = uilabel(app.Step1Panel);
            app.RollerRadiusLabel.HorizontalAlignment = 'right';
            app.RollerRadiusLabel.Position = [8 68 81 22];
            app.RollerRadiusLabel.Text = 'Roller Radius:';

            % Create RollerRadiusEditField
            app.RollerRadiusEditField = uieditfield(app.Step1Panel, 'numeric');
            app.RollerRadiusEditField.Position = [91 68 39 22];
            app.RollerRadiusEditField.Value = 1;

            % Create RollerLengthLabel
            app.RollerLengthLabel = uilabel(app.Step1Panel);
            app.RollerLengthLabel.HorizontalAlignment = 'right';
            app.RollerLengthLabel.Position = [169 68 80 22];
            app.RollerLengthLabel.Text = 'Roller Length:';

            % Create RollerLengthEditField
            app.RollerLengthEditField = uieditfield(app.Step1Panel, 'numeric');
            app.RollerLengthEditField.Position = [251 68 39 22];
            app.RollerLengthEditField.Value = 0.2;

            % Create RrateLabel
            app.RrateLabel = uilabel(app.Step1Panel);
            app.RrateLabel.HorizontalAlignment = 'right';
            app.RrateLabel.Position = [51 38 38 22];
            app.RrateLabel.Text = 'Rrate:';

            % Create RrateEditField
            app.RrateEditField = uieditfield(app.Step1Panel, 'numeric');
            app.RrateEditField.Position = [91 38 40 22];
            app.RrateEditField.Value = 0.8;

            % Create BallradiusLabel
            app.BallradiusLabel = uilabel(app.Step1Panel);
            app.BallradiusLabel.HorizontalAlignment = 'right';
            app.BallradiusLabel.Position = [184 38 65 22];
            app.BallradiusLabel.Text = 'Ball radius:';

            % Create BallradiusEditField
            app.BallradiusEditField = uieditfield(app.Step1Panel, 'numeric');
            app.BallradiusEditField.Position = [251 38 39 22];
            app.BallradiusEditField.Value = 0.025;

            % Create BuildRollerButton
            app.BuildRollerButton = uibutton(app.Step1Panel, 'push');
            app.BuildRollerButton.ButtonPushedFcn = createCallbackFcn(app, @BuildRollerButtonPushed, true);
            app.BuildRollerButton.Position = [11 8 111 22];
            app.BuildRollerButton.Text = 'Build Roller';

            % Create Step2Panel
            app.Step2Panel = uipanel(app.RollerUIFigure);
            app.Step2Panel.Title = 'Step 2';
            app.Step2Panel.Position = [11 128 310 190];

            % Create TotalCircleLabel
            app.TotalCircleLabel = uilabel(app.Step2Panel);
            app.TotalCircleLabel.HorizontalAlignment = 'right';
            app.TotalCircleLabel.Position = [21 138 65 22];
            app.TotalCircleLabel.Text = 'TotalCircle:';

            % Create TotalCircleEditField
            app.TotalCircleEditField = uieditfield(app.Step2Panel, 'numeric');
            app.TotalCircleEditField.Position = [88 138 39 22];
            app.TotalCircleEditField.Value = 1000;

            % Create StepNumLabel
            app.StepNumLabel = uilabel(app.Step2Panel);
            app.StepNumLabel.HorizontalAlignment = 'right';
            app.StepNumLabel.Position = [191 138 59 22];
            app.StepNumLabel.Text = 'StepNum:';

            % Create StepNumEditField
            app.StepNumEditField = uieditfield(app.Step2Panel, 'numeric');
            app.StepNumEditField.Position = [252 138 40 22];
            app.StepNumEditField.Value = 5;

            % Create SpeeddegreesSliderLabel
            app.SpeeddegreesSliderLabel = uilabel(app.Step2Panel);
            app.SpeeddegreesSliderLabel.HorizontalAlignment = 'right';
            app.SpeeddegreesSliderLabel.Position = [11 108 100 22];
            app.SpeeddegreesSliderLabel.Text = 'Speed (degree/s)';

            % Create SpeeddegreesSlider
            app.SpeeddegreesSlider = uislider(app.Step2Panel);
            app.SpeeddegreesSlider.Limits = [30 180];
            app.SpeeddegreesSlider.ValueChangedFcn = createCallbackFcn(app, @SpeeddegreesSliderValueChanged, true);
            app.SpeeddegreesSlider.Position = [120 117 120 3];
            app.SpeeddegreesSlider.Value = 180;

            % Create ControlPanel
            app.ControlPanel = uipanel(app.Step2Panel);
            app.ControlPanel.Title = 'Simulation control';
            app.ControlPanel.Position = [161 10 130 60];

            % Create Button_Pause
            app.Button_Pause = uibutton(app.ControlPanel, 'push');
            app.Button_Pause.ButtonPushedFcn = createCallbackFcn(app, @Button_PausePushed, true);
            app.Button_Pause.Tooltip = {'Pause'};
            app.Button_Pause.Position = [11 8 30 22];
            app.Button_Pause.Text = '||';

            % Create Button_Continue
            app.Button_Continue = uibutton(app.ControlPanel, 'push');
            app.Button_Continue.ButtonPushedFcn = createCallbackFcn(app, @Button_ContinuePushed, true);
            app.Button_Continue.Tooltip = {'Continue'};
            app.Button_Continue.Position = [51 8 30 22];
            app.Button_Continue.Text = '>';

            % Create Button_Stop
            app.Button_Stop = uibutton(app.ControlPanel, 'push');
            app.Button_Stop.ButtonPushedFcn = createCallbackFcn(app, @Button_StopPushed, true);
            app.Button_Stop.Tooltip = {'Stop'};
            app.Button_Stop.Position = [91 8 30 22];
            app.Button_Stop.Text = '*';

            % Create StartRollingButton
            app.StartRollingButton = uibutton(app.Step2Panel, 'push');
            app.StartRollingButton.ButtonPushedFcn = createCallbackFcn(app, @StartRollingButtonPushed, true);
            app.StartRollingButton.Position = [11 48 110 22];
            app.StartRollingButton.Text = 'Start Rolling';

            % Create SpeedEditField
            app.SpeedEditField = uieditfield(app.Step2Panel, 'numeric');
            app.SpeedEditField.Position = [251 108 40 22];
            app.SpeedEditField.Value = 180;

            % Show the figure after all components are created
            app.RollerUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_Roller_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.RollerUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.RollerUIFigure)
        end
    end
end