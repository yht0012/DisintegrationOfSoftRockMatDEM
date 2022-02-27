classdef UI_Aerolite_exported< matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        WinMain                      matlab.ui.Figure
        Panel_ParameterSettings      matlab.ui.container.Panel
        Label                        matlab.ui.control.Label
        Slider_AeroliteRadius        matlab.ui.control.Slider
        Label_2                      matlab.ui.control.Label
        Slider_AeroliteHeight        matlab.ui.control.Slider
        Label_3                      matlab.ui.control.Label
        Slider_GroundHeight          matlab.ui.control.Slider
        Label_4                      matlab.ui.control.Label
        Slider_InitialSpeed          matlab.ui.control.Slider
        Panel_NumericalSimulation    matlab.ui.container.Panel
        Button_BuildGeometricModel   matlab.ui.control.Button
        Button_ImportMaterials       matlab.ui.control.Button
        Button_SetMaterials          matlab.ui.control.Button
        Label_5                      matlab.ui.control.Label
        EditField_SimulationTime     matlab.ui.control.NumericEditField
        Button_StartSimulation       matlab.ui.control.Button
        Button_PostProcessingModule  matlab.ui.control.Button
        UIAxes_PlottingArea          matlab.ui.control.UIAxes
        TextArea_Message             matlab.ui.control.TextArea
    end

    
    properties (Access = public)
        Settings;
        Box;
        DataCenter;
        Graphs;
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Settings.PlottingAreaParentHandle=app.WinMain;
            app.Settings.PlottingAreaParentPosition=app.WinMain.Position;
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingArea;
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingArea.Position;
            app.Settings.OutputFocus=app.TextArea_Message;
            setappdata(0,'app',app);
            setappdata(0,'CurrentWindow',1);
            
            hold(app.UIAxes_PlottingArea,'on');
            axis(app.UIAxes_PlottingArea,'equal');
            
            rho=app.Slider_AeroliteRadius.Value;
            theta=0:pi/18:2*pi;
            x=rho*cos(theta)+50;
            y=rho*sin(theta)+app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value;
            app.Graphs.AeroliteRadius_circle=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteRadius_radius=plot(app.UIAxes_PlottingArea,[50,50+rho*cos(pi/4)],[app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)],'.-b');
            app.Graphs.AeroliteRadius_text=text(app.UIAxes_PlottingArea,50+rho*cos(pi/4)/2,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)/2,['R = ',num2str(rho)]);
            
            x=[30,30];
            y=[app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value,app.Slider_GroundHeight.Value];
            app.Graphs.AeroliteHeight_top=plot(app.UIAxes_PlottingArea,[25,35],[y(1),y(1)],'-b');
            app.Graphs.AeroliteHeight_height=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteHeight_text=text(app.UIAxes_PlottingArea,15,(y(1)+y(2))/2,['H = ',num2str(app.Slider_AeroliteHeight.Value)]);
            
            x=[0,100];
            y=[app.Slider_GroundHeight.Value,app.Slider_GroundHeight.Value];
            app.Graphs.GroundHeight_surface=plot(app.UIAxes_PlottingArea,x,y,'.-b');
            app.Graphs.GroundHeight_text=text(app.UIAxes_PlottingArea,43,y(1)+3,['h = ',num2str(y(1))]);
            
            x=[70,70];
            y=[app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value-0.1*(app.Slider_InitialSpeed.Value+10)];
            app.Graphs.InitialSpeed_body=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.InitialSpeed_head=plot(app.UIAxes_PlottingArea,x(2),y(2),'v-b');
            app.Graphs.InitialSpeed_text=text(app.UIAxes_PlottingArea,70,(y(1)+y(2))/2,['v = ',num2str(app.Slider_InitialSpeed.Value)]);
        end

        % Close request function: WinMain
        function WinMainCloseRequest(app, event)
            delete(app);
            try
                rmappdata(0,'app');
                rmappdata(0,'CurrentWindow');
            catch
                %不做任何处理。
            end
        end

        % Value changing function: Slider_AeroliteRadius
        function Slider_AeroliteRadiusValueChanging(app, event)
            changingValue = event.Value;
            
            delete(app.Graphs.AeroliteRadius_circle);
            delete(app.Graphs.AeroliteRadius_radius);
            delete(app.Graphs.AeroliteRadius_text);
            
            rho=changingValue;
            theta=0:pi/18:2*pi;
            x=rho*cos(theta)+50;
            y=rho*sin(theta)+app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value;
            app.Graphs.AeroliteRadius_circle=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteRadius_radius=plot(app.UIAxes_PlottingArea,[50,50+rho*cos(pi/4)],[app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)],'.-b');
            app.Graphs.AeroliteRadius_text=text(app.UIAxes_PlottingArea,50+rho*cos(pi/4)/2,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)/2,['R = ',num2str(rho)]);
        end

        % Value changing function: Slider_AeroliteHeight
        function Slider_AeroliteHeightValueChanging(app, event)
            changingValue = event.Value;
            
            delete(app.Graphs.AeroliteRadius_circle);
            delete(app.Graphs.AeroliteRadius_radius);
            delete(app.Graphs.AeroliteRadius_text);
            
            delete(app.Graphs.AeroliteHeight_top);
            delete(app.Graphs.AeroliteHeight_height);
            delete(app.Graphs.AeroliteHeight_text);
            
            delete(app.Graphs.InitialSpeed_body);
            delete(app.Graphs.InitialSpeed_head);
            delete(app.Graphs.InitialSpeed_text);
            
            rho=app.Slider_AeroliteRadius.Value;
            theta=0:pi/18:2*pi;
            x=rho*cos(theta)+50;
            y=rho*sin(theta)+app.Slider_GroundHeight.Value+changingValue;
            app.Graphs.AeroliteRadius_circle=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteRadius_radius=plot(app.UIAxes_PlottingArea,[50,50+rho*cos(pi/4)],[app.Slider_GroundHeight.Value+changingValue,app.Slider_GroundHeight.Value+changingValue+rho*sin(pi/4)],'.-b');
            app.Graphs.AeroliteRadius_text=text(app.UIAxes_PlottingArea,50+rho*cos(pi/4)/2,app.Slider_GroundHeight.Value+changingValue+rho*sin(pi/4)/2,['R = ',num2str(rho)]);
            
            x=[30,30];
            y=[app.Slider_GroundHeight.Value+changingValue,app.Slider_GroundHeight.Value];
            app.Graphs.AeroliteHeight_top=plot(app.UIAxes_PlottingArea,[25,35],[y(1),y(1)],'-b');
            app.Graphs.AeroliteHeight_height=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteHeight_text=text(app.UIAxes_PlottingArea,15,(y(1)+y(2))/2,['H = ',num2str(changingValue)]);
            
            x=[70,70];
            y=[app.Slider_GroundHeight.Value+changingValue,app.Slider_GroundHeight.Value+changingValue-0.1*(app.Slider_InitialSpeed.Value+10)];
            app.Graphs.InitialSpeed_body=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.InitialSpeed_head=plot(app.UIAxes_PlottingArea,x(2),y(2),'v-b');
            app.Graphs.InitialSpeed_text=text(app.UIAxes_PlottingArea,70,(y(1)+y(2))/2,['v = ',num2str(app.Slider_InitialSpeed.Value)]);
        end

        % Value changing function: Slider_GroundHeight
        function Slider_GroundHeightValueChanging(app, event)
            changingValue = event.Value;
            
            delete(app.Graphs.AeroliteRadius_circle);
            delete(app.Graphs.AeroliteRadius_radius);
            delete(app.Graphs.AeroliteRadius_text);
            
            delete(app.Graphs.AeroliteHeight_top);
            delete(app.Graphs.AeroliteHeight_height);
            delete(app.Graphs.AeroliteHeight_text);
            
            delete(app.Graphs.GroundHeight_surface);
            delete(app.Graphs.GroundHeight_text);
            
            delete(app.Graphs.InitialSpeed_body);
            delete(app.Graphs.InitialSpeed_head);
            delete(app.Graphs.InitialSpeed_text);
            
            rho=app.Slider_AeroliteRadius.Value;
            theta=0:pi/18:2*pi;
            x=rho*cos(theta)+50;
            y=rho*sin(theta)+changingValue+app.Slider_AeroliteHeight.Value;
            app.Graphs.AeroliteRadius_circle=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteRadius_radius=plot(app.UIAxes_PlottingArea,[50,50+rho*cos(pi/4)],[changingValue+app.Slider_AeroliteHeight.Value,changingValue+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)],'.-b');
            app.Graphs.AeroliteRadius_text=text(app.UIAxes_PlottingArea,50+rho*cos(pi/4)/2,changingValue+app.Slider_AeroliteHeight.Value+rho*sin(pi/4)/2,['R = ',num2str(rho)]);
            
            x=[30,30];
            y=[changingValue+app.Slider_AeroliteHeight.Value,changingValue];
            app.Graphs.AeroliteHeight_top=plot(app.UIAxes_PlottingArea,[25,35],[y(1),y(1)],'-b');
            app.Graphs.AeroliteHeight_height=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.AeroliteHeight_text=text(app.UIAxes_PlottingArea,15,(y(1)+y(2))/2,['H = ',num2str(app.Slider_AeroliteHeight.Value)]);
            
            x=[0,100];
            y=[changingValue,changingValue];
            app.Graphs.GroundHeight_surface=plot(app.UIAxes_PlottingArea,x,y,'.-b');
            app.Graphs.GroundHeight_text=text(app.UIAxes_PlottingArea,43,y(1)+3,['h = ',num2str(y(1))]);
            
            x=[70,70];
            y=[changingValue+app.Slider_AeroliteHeight.Value,changingValue+app.Slider_AeroliteHeight.Value-0.1*(app.Slider_InitialSpeed.Value+10)];
            app.Graphs.InitialSpeed_body=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.InitialSpeed_head=plot(app.UIAxes_PlottingArea,x(2),y(2),'v-b');
            app.Graphs.InitialSpeed_text=text(app.UIAxes_PlottingArea,70,(y(1)+y(2))/2,['v = ',num2str(app.Slider_InitialSpeed.Value)]);
        end

        % Value changing function: Slider_InitialSpeed
        function Slider_InitialSpeedValueChanging(app, event)
            changingValue = event.Value;
            
            delete(app.Graphs.InitialSpeed_body);
            delete(app.Graphs.InitialSpeed_head);
            delete(app.Graphs.InitialSpeed_text);
            
            x=[70,70];
            y=[app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value,app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value-0.1*(changingValue+10)];
            app.Graphs.InitialSpeed_body=plot(app.UIAxes_PlottingArea,x,y,'-b');
            app.Graphs.InitialSpeed_head=plot(app.UIAxes_PlottingArea,x(2),y(2),'v-b');
            app.Graphs.InitialSpeed_text=text(app.UIAxes_PlottingArea,70,(y(1)+y(2))/2,['v = ',num2str(changingValue)]);
        end

        % Button pushed function: Button_BuildGeometricModel
        function Button_BuildGeometricModelButtonPushed(app, event)
            fs.randSeed(1);
            B=obj_Box;
            B.name='Aerolite';
            B.GPUstatus='auto';
            B.ballR=1;
            B.distriRate=0.2;
            B.isClump=0;
            B.sampleW=100;
            B.sampleL=0;
            B.sampleH=100;
            B.type='topPlaten';
            B.setType();
            B.buildInitialModel();
            d=B.d;
            
            app.Box=B;
            app.DataCenter=d;
            d.mo.setGPU('auto');
            B.gravitySediment(1);
            %B.compactSample(3);
            d.mo.setGPU('off');
            sampleID=d.GROUP.sample;
            AeroliteFilter=sqrt((d.mo.aX(sampleID)-50).^2+(d.mo.aZ(sampleID)-(app.Slider_GroundHeight.Value+app.Slider_AeroliteHeight.Value)).^2)<=app.Slider_AeroliteRadius.Value;
            d.addGroup('Aerolite',sampleID(AeroliteFilter));
            d.setClump('Aerolite');
            GroundFilter=d.mo.aZ(sampleID)<=app.Slider_GroundHeight.Value;
            d.addGroup('Ground',sampleID(GroundFilter));
            d.delElement(d.GROUP.topPlaten);
            d.delElement(sampleID((~AeroliteFilter)&(~GroundFilter)));
            
            d.clearData(1);
            d.recordCalHour([B.name,'1Finish']);
            save(['TempModel\',B.name,'1.mat'],'B','d');
            save(['TempModel\',B.name,'1_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.showB=2;
            d.show('aR');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_ImportMaterials
        function Button_ImportMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            UI_Material(d,B.ballR);
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_SetMaterials
        function Button_SetMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            d.GROUP=UI_Group(d);
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            d.addFixId('X',d.GROUP.Aerolite);
            d.addFixId('Z',d.GROUP.Aerolite);
            d.mo.setGPU('auto');
            d.balanceBondedModel0(1);
            d.mo.setGPU('off');
            d.removeFixId('X',d.GROUP.Aerolite);
            d.removeFixId('Z',d.GROUP.Aerolite);
            d.breakGroup('Ground');
            d.breakGroupOuter({'Ground'});
            
            d.clearData(1);
            d.recordCalHour([B.name,'2Finish']);
            save(['TempModel\',B.name,'2.mat'],'B','d');
            save(['TempModel\',B.name,'2_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.show('aMatId');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_StartSimulation
        function Button_StartSimulationButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.getModel();
            d.resetStatus();
            d.setStandarddT();
            d.setStandardVis();
            d.mo.mVis=0;
            d.mo.mVZ(d.GROUP.Aerolite)=-app.Slider_InitialSpeed.Value;
            TempFileName=['data\step\',B.name,'temp_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_loopNum'];
            save([TempFileName,'0.mat']);
            TempFileNumber=round(app.EditField_SimulationTime.Value/(10000*d.mo.dT));
            d.tic(TempFileNumber);
            for i=1:TempFileNumber
                d.mo.setGPU('auto');
                d.balance(10000);
                d.mo.setGPU('off');
                d.clearData(1);
                save([TempFileName,num2str(i),'.mat'],'B','d');
                d.calculateData();
                d.toc();
                fs.disp(['t = ',num2str(d.mo.totalT),' s.']);
            end
            
            d.clearData(1);
            d.recordCalHour([B.name,'3Finish']);
            save(['TempModel\',B.name,'3.mat'],'B','d');
            save(['TempModel\',B.name,'3_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.show('aR');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_PostProcessingModule
        function Button_PostProcessingModuleButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.showB=2;
            d.showFilter();
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_PostProcess(d);
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.Box=B;
            app.DataCenter=d;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create WinMain and hide until all components are created
            app.WinMain = uifigure('Visible', 'off');
            app.WinMain.Position = [100 100 640 480];
            app.WinMain.Name = 'Aerolite';
            app.WinMain.Resize = 'off';
            app.WinMain.CloseRequestFcn = createCallbackFcn(app, @WinMainCloseRequest, true);

            % Create Panel_ParameterSettings
            app.Panel_ParameterSettings = uipanel(app.WinMain);
            app.Panel_ParameterSettings.Title = '参数设置';
            app.Panel_ParameterSettings.Position = [21 221 210 240];

            % Create Label
            app.Label = uilabel(app.Panel_ParameterSettings);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [11 186 53 22];
            app.Label.Text = '陨石半径';

            % Create Slider_AeroliteRadius
            app.Slider_AeroliteRadius = uislider(app.Panel_ParameterSettings);
            app.Slider_AeroliteRadius.Limits = [5 10];
            app.Slider_AeroliteRadius.ValueChangingFcn = createCallbackFcn(app, @Slider_AeroliteRadiusValueChanging, true);
            app.Slider_AeroliteRadius.Position = [85 195 105 3];
            app.Slider_AeroliteRadius.Value = 10;

            % Create Label_2
            app.Label_2 = uilabel(app.Panel_ParameterSettings);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [11 136 53 22];
            app.Label_2.Text = '陨石高度';

            % Create Slider_AeroliteHeight
            app.Slider_AeroliteHeight = uislider(app.Panel_ParameterSettings);
            app.Slider_AeroliteHeight.Limits = [15 30];
            app.Slider_AeroliteHeight.ValueChangingFcn = createCallbackFcn(app, @Slider_AeroliteHeightValueChanging, true);
            app.Slider_AeroliteHeight.Position = [85 145 105 3];
            app.Slider_AeroliteHeight.Value = 30;

            % Create Label_3
            app.Label_3 = uilabel(app.Panel_ParameterSettings);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [11 86 53 22];
            app.Label_3.Text = '地面高度';

            % Create Slider_GroundHeight
            app.Slider_GroundHeight = uislider(app.Panel_ParameterSettings);
            app.Slider_GroundHeight.Limits = [20 50];
            app.Slider_GroundHeight.ValueChangingFcn = createCallbackFcn(app, @Slider_GroundHeightValueChanging, true);
            app.Slider_GroundHeight.Position = [85 95 105 3];
            app.Slider_GroundHeight.Value = 50;

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_ParameterSettings);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [11 36 53 22];
            app.Label_4.Text = '初始速度';

            % Create Slider_InitialSpeed
            app.Slider_InitialSpeed = uislider(app.Panel_ParameterSettings);
            app.Slider_InitialSpeed.Limits = [50 100];
            app.Slider_InitialSpeed.ValueChangingFcn = createCallbackFcn(app, @Slider_InitialSpeedValueChanging, true);
            app.Slider_InitialSpeed.Position = [85 45 105 3];
            app.Slider_InitialSpeed.Value = 100;

            % Create Panel_NumericalSimulation
            app.Panel_NumericalSimulation = uipanel(app.WinMain);
            app.Panel_NumericalSimulation.Title = '数值模拟';
            app.Panel_NumericalSimulation.Position = [21 21 210 180];

            % Create Button_BuildGeometricModel
            app.Button_BuildGeometricModel = uibutton(app.Panel_NumericalSimulation, 'push');
            app.Button_BuildGeometricModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BuildGeometricModelButtonPushed, true);
            app.Button_BuildGeometricModel.Position = [11 124 190 24];
            app.Button_BuildGeometricModel.Text = '几何建模';

            % Create Button_ImportMaterials
            app.Button_ImportMaterials = uibutton(app.Panel_NumericalSimulation, 'push');
            app.Button_ImportMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_ImportMaterialsButtonPushed, true);
            app.Button_ImportMaterials.Position = [11 94 90 24];
            app.Button_ImportMaterials.Text = '导入材料';

            % Create Button_SetMaterials
            app.Button_SetMaterials = uibutton(app.Panel_NumericalSimulation, 'push');
            app.Button_SetMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_SetMaterialsButtonPushed, true);
            app.Button_SetMaterials.Position = [111 94 90 24];
            app.Button_SetMaterials.Text = '材料设置';

            % Create Label_5
            app.Label_5 = uilabel(app.Panel_NumericalSimulation);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [12 57 53 22];
            app.Label_5.Text = '模拟时间';

            % Create EditField_SimulationTime
            app.EditField_SimulationTime = uieditfield(app.Panel_NumericalSimulation, 'numeric');
            app.EditField_SimulationTime.Limits = [0 Inf];
            app.EditField_SimulationTime.Position = [80 57 50 22];
            app.EditField_SimulationTime.Value = 3;

            % Create Button_StartSimulation
            app.Button_StartSimulation = uibutton(app.Panel_NumericalSimulation, 'push');
            app.Button_StartSimulation.ButtonPushedFcn = createCallbackFcn(app, @Button_StartSimulationButtonPushed, true);
            app.Button_StartSimulation.Position = [151 48 48 40];
            app.Button_StartSimulation.Text = {'开始'; '模拟'};

            % Create Button_PostProcessingModule
            app.Button_PostProcessingModule = uibutton(app.Panel_NumericalSimulation, 'push');
            app.Button_PostProcessingModule.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModuleButtonPushed, true);
            app.Button_PostProcessingModule.Position = [11 14 190 24];
            app.Button_PostProcessingModule.Text = '后处理模块';

            % Create UIAxes_PlottingArea
            app.UIAxes_PlottingArea = uiaxes(app.WinMain);
            title(app.UIAxes_PlottingArea, '绘图区')
            xlabel(app.UIAxes_PlottingArea, 'X')
            ylabel(app.UIAxes_PlottingArea, 'Y')
            app.UIAxes_PlottingArea.XLim = [0 100];
            app.UIAxes_PlottingArea.YLim = [0 100];
            app.UIAxes_PlottingArea.NextPlot = 'add';
            app.UIAxes_PlottingArea.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea.Position = [251 161 370 300];

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.WinMain);
            app.TextArea_Message.Position = [251 21 370 120];

            % Show the figure after all components are created
            app.WinMain.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_Aerolite_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.WinMain)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.WinMain)
        end
    end
end