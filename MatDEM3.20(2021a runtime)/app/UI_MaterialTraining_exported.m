classdef UI_MaterialTraining_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        MaterialtrainingUIFigure   matlab.ui.Figure
        Button_Open                matlab.ui.control.Button
        Label_CurrentFile          matlab.ui.control.Label
        DataTable_Material         matlab.ui.control.Table
        TrainingSettings           matlab.ui.container.Panel
        AverageradiusLabel         matlab.ui.control.Label
        TextArea_AverageRadius     matlab.ui.control.NumericEditField
        DistributionrateLabel      matlab.ui.control.Label
        TextArea_DistributionRate  matlab.ui.control.NumericEditField
        WidthLabel                 matlab.ui.control.Label
        TextArea_Width             matlab.ui.control.NumericEditField
        LengthLabel                matlab.ui.control.Label
        TextArea_Length            matlab.ui.control.NumericEditField
        HeightLabel                matlab.ui.control.Label
        TextArea_Height            matlab.ui.control.NumericEditField
        TrainingtimeLabel          matlab.ui.control.Label
        Spinner_TrainingTime       matlab.ui.control.Spinner
        Balancetime1050Label       matlab.ui.control.Label
        TextArea_BalanceTime       matlab.ui.control.NumericEditField
        FilesavingLabel            matlab.ui.control.Label
        DropDown_SaveFileLevel     matlab.ui.control.DropDown
        Button_StartTraining       matlab.ui.control.Button
        TextArea_Message           matlab.ui.control.TextArea
        ControlPanel               matlab.ui.container.Panel
        Button_Pause               matlab.ui.control.Button
        Button_Continue            matlab.ui.control.Button
        Button_Stop                matlab.ui.control.Button
        Button_AddMaterial         matlab.ui.control.Button
    end

    
    properties (Access = public)
        Settings % Description
        Box;
        MatName;
        MatFile;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)ÿÿÿÿÿÿÿÿ
            ufs.setUIoutputApp(app,app.TextArea_Message);
            ufs.setIconApp(app.MaterialtrainingUIFigure,'Resources/MatDEMlogo.ico');
        end

        % Button pushed function: Button_Open
        function Button_OpenButtonPushed(app, event)
            [file,path]=uigetfile('*.txt');
            if isequal(file,0)
                fs.disp('File is not imported!');
            else
                app.Label_CurrentFile.Text=['Current file name: ',file];
                app.MatName=erase(file,'.txt');
                app.MatFile=strcat(path,file);
                MatTxt=load(app.MatFile);
                app.DataTable_Material.Data=MatTxt;
                app.Button_StartTraining.Enable='on';
                app.TextArea_Message.Value='*****The file has been imported*****';
            end
        end

        % Value changed function: TextArea_AverageRadius
        function TextArea_AverageRadiusValueChanged(app, event)
            value = app.TextArea_AverageRadius.Value;
            if value<=0
                app.TextArea_AverageRadius.Value=1;
            end
        end

        % Value changed function: TextArea_DistributionRate
        function TextArea_DistributionRateValueChanged(app, event)
            value = app.TextArea_DistributionRate.Value;
            if value<0
                app.TextArea_DistributionRate.Value=0.2;
            end
        end

        % Value changed function: TextArea_Width
        function TextArea_WidthValueChanged(app, event)
            value = app.TextArea_Width.Value;
            if value<=0
                app.TextArea_Width.Value=50;
            end
        end

        % Value changed function: TextArea_Length
        function TextArea_LengthValueChanged(app, event)
            value = app.TextArea_Length.Value;
            if value<=0
                app.TextArea_Length.Value=50;
            end
        end

        % Value changed function: TextArea_Height
        function TextArea_HeightValueChanged(app, event)
            value = app.TextArea_Height.Value;
            if value<=0
                app.TextArea_Height.Value=100;
            end
        end

        % Value changed function: TextArea_BalanceTime
        function TextArea_BalanceTimeValueChanged(app, event)
            value = app.TextArea_BalanceTime.Value;
            if value<1
                app.TextArea_BalanceTime.Value=50;
            end
        end

        % Button pushed function: Button_StartTraining
        function Button_StartTrainingButtonPushed(app, event)
            fs.randSeed(1);
            app.TextArea_Message.Value='*****Start training, calculating...*****';
            B=obj_Box;
            B.name=app.MatName;
            B.GPUstatus='auto';
            B.setUIoutput(app.TextArea_Message);
            levelValue=app.DropDown_SaveFileLevel.Value(1);
            B.saveFileLevel=str2num(levelValue)-2;
            app.Box=B;

            B.SET.uniaxialStressRate=1;
            B.d.SET.StandardBalanceNum=app.TextArea_BalanceTime.Value;
            B=mfs.makeUniaxialTestModel0(B,app.TextArea_Width.Value,app.TextArea_Length.Value,app.TextArea_Height.Value,app.TextArea_AverageRadius.Value,app.TextArea_DistributionRate.Value,1);
            B=mfs.makeUniaxialTestModel1(B);
            B.save(1);
            
            mfs.makeUniaxialTestModel2(B,app.MatFile);
            app.DataTable_Material.RowName=[app.DataTable_Material.RowName;'Initial rate'];
            app.DataTable_Material.Data=[app.DataTable_Material.Data;2.7,0.8,6,6.5,1,1.19];
            mfs.makeUniaxialTest(B);
            
            para1=B.d.Mats{1}.SET.UniaxialPara(end);
            trainedProperty=[para1.Ev.E,para1.Ev.v,para1.Tu,para1.Cu,para1.Mui,para1.den];
            app.DataTable_Material.RowName=[app.DataTable_Material.RowName;'Initial property'];
            app.DataTable_Material.Data=[app.DataTable_Material.Data;trainedProperty];
            for i=1:app.Spinner_TrainingTime.Value
                data=B.d.Mats{1}.calculateRate();
                matSet=B.d.Mats{1}.SET;
                B.load(1);
                mfs.makeUniaxialTestModel2(B,app.MatFile,data.newRate);
                B.d.Mats{1}.SET=matSet;
                mfs.makeUniaxialTest(B);
                
                para1=B.d.Mats{1}.SET.UniaxialPara(end);
                trainedProperty=[para1.Ev.E,para1.Ev.v,para1.Tu,para1.Cu,para1.Mui,para1.den];
                app.DataTable_Material.RowName=[app.DataTable_Material.RowName;['Trained property',num2str(i)]];
                app.DataTable_Material.Data=[app.DataTable_Material.Data;trainedProperty];
            end
            B.d.Mats{1}.setTrainedMat();
            B.d.Mats{1}.save();
            app.DataTable_Material.RowName=[app.DataTable_Material.RowName;'Final rate'];
            finalRate=B.d.Mats{1,1}.rate;
            app.DataTable_Material.Data=[app.DataTable_Material.Data;finalRate];
            app.DataTable_Material.RowName=[app.DataTable_Material.RowName;'Final property'];
            P=B.d.Mats{1}.TAG.UniaxialTest;
            finalProperty=[P.E,P.v,P.Tu,P.Cu,P.Mui,P.den];
            app.DataTable_Material.Data=[app.DataTable_Material.Data;finalProperty];
            
            fs.disp('*****Training is finished*****');
        end

        % Button pushed function: Button_Pause
        function Button_PausePushed(app, event)
            ufs.uiwait(app.MaterialtrainingUIFigure);
        end

        % Button pushed function: Button_Continue
        function Button_ContinuePushed(app, event)
            ufs.uiresume(app.MaterialtrainingUIFigure);
        end

        % Button pushed function: Button_Stop
        function Button_StopPushed(app, event)
            ufs.stopRun(app.MaterialtrainingUIFigure,app.Box);
        end

        % Button pushed function: Button_AddMaterial
        function Button_AddMaterialPushed(app, event)
            file='DefaultSoil.txt';
            path='XMLdata\';
            app.Label_CurrentFile.Text=['Current file name: ',file];
            app.MatName=erase(file,'.txt');
            app.MatFile=strcat(path,file);
            MatTxt=load(app.MatFile);
            app.DataTable_Material.Data=MatTxt;
            app.Button_StartTraining.Enable='on';
            app.TextArea_Message.Value='*****The file has been imported*****';
        end

        % Close request function: MaterialtrainingUIFigure
        function MaterialtrainingUIFigureCloseRequest(app, event)
            ufs.stopRun(app.MaterialtrainingUIFigure,app.Box);
            ufs.delete(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create MaterialtrainingUIFigure and hide until all components are created
            app.MaterialtrainingUIFigure = uifigure('Visible', 'off');
            app.MaterialtrainingUIFigure.Position = [100 100 889 490];
            app.MaterialtrainingUIFigure.Name = 'Material training';
            app.MaterialtrainingUIFigure.CloseRequestFcn = createCallbackFcn(app, @MaterialtrainingUIFigureCloseRequest, true);

            % Create Button_Open
            app.Button_Open = uibutton(app.MaterialtrainingUIFigure, 'push');
            app.Button_Open.ButtonPushedFcn = createCallbackFcn(app, @Button_OpenButtonPushed, true);
            app.Button_Open.Position = [11 451 200 30];
            app.Button_Open.Text = 'Open material txt file';

            % Create Label_CurrentFile
            app.Label_CurrentFile = uilabel(app.MaterialtrainingUIFigure);
            app.Label_CurrentFile.Position = [21 421 230 30];
            app.Label_CurrentFile.Text = 'Current file name:';

            % Create DataTable_Material
            app.DataTable_Material = uitable(app.MaterialtrainingUIFigure);
            app.DataTable_Material.ColumnName = {'Young''s modulus (E)'; 'Poisson''s ratio (v)'; 'Tensile strength (Tu)'; 'Comressive strength (Cu)'; 'Frictional coefficient (Mui)'; 'Density (den)'};
            app.DataTable_Material.RowName = {'Given value'};
            app.DataTable_Material.Position = [11 11 870 180];

            % Create TrainingSettings
            app.TrainingSettings = uipanel(app.MaterialtrainingUIFigure);
            app.TrainingSettings.Title = 'Setting of material training';
            app.TrainingSettings.Position = [11 271 420 150];

            % Create AverageradiusLabel
            app.AverageradiusLabel = uilabel(app.TrainingSettings);
            app.AverageradiusLabel.HorizontalAlignment = 'right';
            app.AverageradiusLabel.Position = [18 98 100 22];
            app.AverageradiusLabel.Text = 'Average radius:';

            % Create TextArea_AverageRadius
            app.TextArea_AverageRadius = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_AverageRadius.ValueChangedFcn = createCallbackFcn(app, @TextArea_AverageRadiusValueChanged, true);
            app.TextArea_AverageRadius.Position = [121 98 39 22];
            app.TextArea_AverageRadius.Value = 2.5;

            % Create DistributionrateLabel
            app.DistributionrateLabel = uilabel(app.TrainingSettings);
            app.DistributionrateLabel.HorizontalAlignment = 'right';
            app.DistributionrateLabel.Position = [267 98 100 22];
            app.DistributionrateLabel.Text = 'Distribution rate:';

            % Create TextArea_DistributionRate
            app.TextArea_DistributionRate = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_DistributionRate.ValueChangedFcn = createCallbackFcn(app, @TextArea_DistributionRateValueChanged, true);
            app.TextArea_DistributionRate.Position = [371 98 39 22];
            app.TextArea_DistributionRate.Value = 0.2;

            % Create WidthLabel
            app.WidthLabel = uilabel(app.TrainingSettings);
            app.WidthLabel.HorizontalAlignment = 'right';
            app.WidthLabel.Position = [58 68 60 22];
            app.WidthLabel.Text = 'Width:';

            % Create TextArea_Width
            app.TextArea_Width = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_Width.ValueChangedFcn = createCallbackFcn(app, @TextArea_WidthValueChanged, true);
            app.TextArea_Width.Position = [121 68 39 22];
            app.TextArea_Width.Value = 50;

            % Create LengthLabel
            app.LengthLabel = uilabel(app.TrainingSettings);
            app.LengthLabel.HorizontalAlignment = 'right';
            app.LengthLabel.Position = [183 68 60 22];
            app.LengthLabel.Text = 'Length:';

            % Create TextArea_Length
            app.TextArea_Length = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_Length.ValueChangedFcn = createCallbackFcn(app, @TextArea_LengthValueChanged, true);
            app.TextArea_Length.Position = [247 68 39 22];
            app.TextArea_Length.Value = 50;

            % Create HeightLabel
            app.HeightLabel = uilabel(app.TrainingSettings);
            app.HeightLabel.HorizontalAlignment = 'right';
            app.HeightLabel.Position = [317 68 50 22];
            app.HeightLabel.Text = 'Height:';

            % Create TextArea_Height
            app.TextArea_Height = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_Height.ValueChangedFcn = createCallbackFcn(app, @TextArea_HeightValueChanged, true);
            app.TextArea_Height.Position = [371 68 39 22];
            app.TextArea_Height.Value = 100;

            % Create TrainingtimeLabel
            app.TrainingtimeLabel = uilabel(app.TrainingSettings);
            app.TrainingtimeLabel.HorizontalAlignment = 'right';
            app.TrainingtimeLabel.Position = [15 38 90 22];
            app.TrainingtimeLabel.Text = 'Training time:';

            % Create Spinner_TrainingTime
            app.Spinner_TrainingTime = uispinner(app.TrainingSettings);
            app.Spinner_TrainingTime.Limits = [3 6];
            app.Spinner_TrainingTime.Position = [107 38 53 22];
            app.Spinner_TrainingTime.Value = 4;

            % Create Balancetime1050Label
            app.Balancetime1050Label = uilabel(app.TrainingSettings);
            app.Balancetime1050Label.HorizontalAlignment = 'right';
            app.Balancetime1050Label.Position = [244 38 123 22];
            app.Balancetime1050Label.Text = 'Balance time (10~50):';

            % Create TextArea_BalanceTime
            app.TextArea_BalanceTime = uieditfield(app.TrainingSettings, 'numeric');
            app.TextArea_BalanceTime.ValueChangedFcn = createCallbackFcn(app, @TextArea_BalanceTimeValueChanged, true);
            app.TextArea_BalanceTime.Position = [371 38 39 22];
            app.TextArea_BalanceTime.Value = 20;

            % Create FilesavingLabel
            app.FilesavingLabel = uilabel(app.TrainingSettings);
            app.FilesavingLabel.HorizontalAlignment = 'right';
            app.FilesavingLabel.Position = [25 8 80 22];
            app.FilesavingLabel.Text = 'File saving:';

            % Create DropDown_SaveFileLevel
            app.DropDown_SaveFileLevel = uidropdown(app.TrainingSettings);
            app.DropDown_SaveFileLevel.Items = {'4. All files', '3. Important files', '2. Result files', '1. None'};
            app.DropDown_SaveFileLevel.Position = [106 8 164 22];
            app.DropDown_SaveFileLevel.Value = '3. Important files';

            % Create Button_StartTraining
            app.Button_StartTraining = uibutton(app.TrainingSettings, 'push');
            app.Button_StartTraining.ButtonPushedFcn = createCallbackFcn(app, @Button_StartTrainingButtonPushed, true);
            app.Button_StartTraining.Enable = 'off';
            app.Button_StartTraining.Position = [291 6 118 24];
            app.Button_StartTraining.Text = 'Start training';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.MaterialtrainingUIFigure);
            app.TextArea_Message.Position = [445 221 436 260];
            app.TextArea_Message.Value = {'1. Open a material file (*.txt ) in the folder "Mats". E, v, Tu, Cu, Mui, den are recorded in the file'; '2. Click ''Start training'', for default setting, it may take over 20 minutes to finish one training'; '3. Trained material will be saved in the folder "Mats" with the file name "Mat_*.mat"'};

            % Create ControlPanel
            app.ControlPanel = uipanel(app.MaterialtrainingUIFigure);
            app.ControlPanel.Title = 'Simulation control';
            app.ControlPanel.Position = [11 201 130 60];

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

            % Create Button_AddMaterial
            app.Button_AddMaterial = uibutton(app.MaterialtrainingUIFigure, 'push');
            app.Button_AddMaterial.ButtonPushedFcn = createCallbackFcn(app, @Button_AddMaterialPushed, true);
            app.Button_AddMaterial.Position = [231 451 200 30];
            app.Button_AddMaterial.Text = 'Add tested material';

            % Show the figure after all components are created
            app.MaterialtrainingUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_MaterialTraining_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.MaterialtrainingUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.MaterialtrainingUIFigure)
        end
    end
end