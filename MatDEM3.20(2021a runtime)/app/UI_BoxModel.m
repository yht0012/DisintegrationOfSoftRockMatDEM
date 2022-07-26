classdef UI_BoxModel < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        WinMain                         matlab.ui.Figure
        Panel_Step1                     matlab.ui.container.Panel
        Label                           matlab.ui.control.Label
        NumericEditField_Width          matlab.ui.control.NumericEditField
        Label_2                         matlab.ui.control.Label
        NumericEditField_Length         matlab.ui.control.NumericEditField
        Label_3                         matlab.ui.control.Label
        NumericEditField_Height         matlab.ui.control.NumericEditField
        Label_4                         matlab.ui.control.Label
        NumericEditField_AverageRadius  matlab.ui.control.NumericEditField
        Label_5                         matlab.ui.control.Label
        NumericEditField_DistributionRate  matlab.ui.control.NumericEditField
        CheckBox_UseClump               matlab.ui.control.CheckBox
        Panel_Platens                   matlab.ui.container.Panel
        CheckBox_LeftPlaten             matlab.ui.control.CheckBox
        CheckBox_RightPlaten            matlab.ui.control.CheckBox
        CheckBox_FrontPlaten            matlab.ui.control.CheckBox
        CheckBox_BackPlaten             matlab.ui.control.CheckBox
        CheckBox_BottomPlaten           matlab.ui.control.CheckBox
        CheckBox_TopPlaten              matlab.ui.control.CheckBox
        Button_BuildInitialModel        matlab.ui.control.Button
        Label_6                         matlab.ui.control.Label
        NumericEditField_TimeRate       matlab.ui.control.NumericEditField
        Button_GravitySediment          matlab.ui.control.Button
        Label_7                         matlab.ui.control.Label
        NumericEditField_CompactionTime  matlab.ui.control.NumericEditField
        Button_CompactSample            matlab.ui.control.Button
        Panel_Step2                     matlab.ui.container.Panel
        Button_ImportMaterials          matlab.ui.control.Button
        Button_SetGroupsAndMaterials    matlab.ui.control.Button
        Button_EditConnections          matlab.ui.control.Button
        CheckBox_ConsiderFriction       matlab.ui.control.CheckBox
        Label_8                         matlab.ui.control.Label
        NumericEditField_StandardBalanceTime  matlab.ui.control.NumericEditField
        Button_BalanceBondedModel       matlab.ui.control.Button
        Panel_Step3                     matlab.ui.container.Panel
        CheckBox_CalculateHeat          matlab.ui.control.CheckBox
        CheckBox_ConsiderShearForce     matlab.ui.control.CheckBox
        Label_9                         matlab.ui.control.Label
        NumericEditField_MajorCycle     matlab.ui.control.NumericEditField
        Label_10                        matlab.ui.control.Label
        NumericEditField_MinorCycle     matlab.ui.control.NumericEditField
        Button_EquilibriumIteration     matlab.ui.control.Button
        Button_PostProcessingModule     matlab.ui.control.Button
        Button_GenerateGIF              matlab.ui.control.Button
        UIAxes_PlottingArea             matlab.ui.control.UIAxes
        Label_11                        matlab.ui.control.Label
        EditField_CommandLine           matlab.ui.control.EditField
        Button_Run                      matlab.ui.control.Button
        TextArea_Message                matlab.ui.control.TextArea
    end

    
    properties (Access = public)
        %关于定义类的属性的几点说明：
        %1、建议使用者在开发和测试窗口应用时定义属性Setting、Box以及DataCenter并严格遵守其命名规则，以免部分功能无法正常使用。
        %2、当有可能在类外访问某属性（如Settings）时，需将其权限设为public。
        %3、由于通过指令f.runWinApp(...)运行窗口应用时MatDEM并不会检索类的属性的定义部分，因此只能在函数startupFcn中为类的属性赋初值。
        Settings; %窗口应用的设置信息。
        Box; %即类obj_Box的对象B。
        DataCenter; %即类build的对象d。
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %各项初始化工作均应在函数startupFcn中完成，尽管该函数并不是必需的。
            %为类的属性赋初值形如：
            app.Settings=[]; %为属性Settings赋初值。
            app.Box=[]; %为属性Box赋初值。
            app.DataCenter=[]; %为属性DataCenter赋初值。
            %为在App Designer中或通过直接运行导出的.m文件的方式测试窗口应用，本例在函数startupFcn中添加了如下代码。
            %实际上，若在外部通过指令f.runWinApp(...)运行窗口应用，则MatDEM已自动执行相应的代码。
            app.Settings.PlottingAreaParentHandle=app.WinMain; %声明绘图区所在父窗口（或控件）的句柄。
            app.Settings.PlottingAreaParentPosition=app.WinMain.Position; %声明绘图区所在父窗口（或控件）的位置。
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingArea; %声明绘图区的句柄。
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingArea.Position; %声明绘图区的位置。
            %若在使用者开发的窗口应用中存在多个绘图区，则可通过函数f.ChangePlottingAreaParent与f.ChangePlottingArea切换当前绘图区。
            %例如：f.ChangePlottingAreaParent(app.Panel2); f.ChangePlottingArea(app.UIAxes2);
            app.Settings.OutputFocus=app.TextArea_Message; %声明消息输出焦点。
            %若在使用者开发的窗口应用中存在多个消息输出焦点，则可通过函数f.ChangeOutputFocus切换当前消息输出焦点。
            %例如：f.ChangeOutputFocus(app.TextArea2);
            setappdata(0,'app',app); %将app设为全局变量。
            setappdata(0,'CurrentWindow',1); %将全局变量CurrentWindow设为1。
        end

        % Button pushed function: Button_BuildInitialModel
        function Button_BuildInitialModelButtonPushed(app, event)
            fs.randSeed(1);
            B=obj_Box;
            B.name='UI_BoxModel';
            B.GPUstatus='auto';
            B.ballR=app.NumericEditField_AverageRadius.Value;
            B.distriRate=app.NumericEditField_DistributionRate.Value;
            B.isClump=app.CheckBox_UseClump.Value;
            B.sampleW=app.NumericEditField_Width.Value;
            B.sampleL=app.NumericEditField_Length.Value;
            B.sampleH=app.NumericEditField_Height.Value;
            B.platenStatus=[app.CheckBox_LeftPlaten.Value,app.CheckBox_RightPlaten.Value,app.CheckBox_FrontPlaten.Value,app.CheckBox_BackPlaten.Value,app.CheckBox_BottomPlaten.Value,app.CheckBox_TopPlaten.Value];
            B.buildInitialModel();
            %无需再通过指令B.setUIoutput(...)声明消息输出焦点。
            d=B.d;
            d.showB=2;
            d.show('aR');
            fs.disp('*****已建立初始模型*****');
            app.Box=B; %将B存储为app.Box。
            app.DataCenter=d; %将d存储为app.DataCenter。
        end

        % Button pushed function: Button_GravitySediment
        function Button_GravitySedimentButtonPushed(app, event)
            %在大多数控件的事件响应函数的开头和结尾均应通过B<->app.Box以及d<->app.DataCenter之间相互赋值传递数据。
            %其他重要参数，如切割工具对象C，均应通过存储在B.SET中从而在各个控件的事件响应函数之间传递。
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            B.gravitySediment(app.NumericEditField_TimeRate.Value);
            d.mo.setGPU('off');
            d.show('aR');
            fs.disp('*****已重力沉积*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_CompactSample
        function Button_CompactSampleButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            B.compactSample(round(app.NumericEditField_CompactionTime.Value));
            d.mo.setGPU('off');
            d.clearData(1);
            d.recordCalHour([B.name,'1Finish']);
            save(['TempModel\',B.name,'1.mat'],'B','d');
            save(['TempModel\',B.name,'1_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.show('aR');
            fs.disp('*****已压实样品*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_ImportMaterials
        function Button_ImportMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            UI_Material(d,B.ballR); %调用MatDEM提供的导入材料模块。
            fs.disp('*****已导入材料*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_SetGroupsAndMaterials
        function Button_SetGroupsAndMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            %由于MatDEM提供的部分模块采用GUIDE开发，因此无法通过函数f.ChangePlottingAreaParent或f.ChangePlottingArea切换当前绘图区。
            PlottingAreaPosition=app.Settings.PlottingAreaPosition; %为此，可先以一变量暂存当前绘图区位置。
            app.Settings.PlottingAreaPosition=[]; %然后将当前绘图区位置临时置空。
            setappdata(0,'app',app); %及时更新全局变量app。
            d.GROUP=UI_Group(d); %调用MatDEM提供的分组并赋材料模块。
            app.Settings.PlottingAreaPosition=PlottingAreaPosition; %最后再恢复原有绘图区位置。
            setappdata(0,'app',app); %及时更新全局变量app。
            d.show('aMatId');
            fs.disp('*****已分组并赋材料*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_EditConnections
        function Button_EditConnectionsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_Bond(d); %调用MatDEM提供的编辑连接模块。
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            d.show('--');
            fs.disp('*****已编辑连接*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_BalanceBondedModel
        function Button_BalanceBondedModelButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            if app.CheckBox_ConsiderFriction.Value==1
                d.balanceBondedModel(app.NumericEditField_StandardBalanceTime.Value);
            else
                d.balanceBondedModel0(app.NumericEditField_StandardBalanceTime.Value);
            end
            d.mo.setGPU('off');
            d.clearData(1);
            d.recordCalHour([B.name,'2Finish']);
            save(['TempModel\',B.name,'2.mat'],'B','d');
            save(['TempModel\',B.name,'2_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.show('aR');
            fs.disp('*****已平衡胶结模型*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_EquilibriumIteration
        function Button_EquilibriumIterationButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.getModel();
            d.status=modelStatus(d);
            d.setStandarddT();
            if app.CheckBox_CalculateHeat.Value==1
                d.mo.isHeat=1;
            else
                d.mo.isHeat=0;
            end
            if app.CheckBox_ConsiderShearForce.Value==1
                d.mo.isShear=1;
            else
                d.mo.isShear=0;
            end
            TempFileName=['data\step\',B.name,'temp_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_loopNum'];
            save([TempFileName,'0.mat']);
            d.tic(app.NumericEditField_MajorCycle.Value);
            for i=1:app.NumericEditField_MajorCycle.Value
                d.mo.setGPU('auto');
                for j=1:app.NumericEditField_MinorCycle.Value
                    d.balance('Standard');
                    fs.disp(['i = ',num2str(i),' , j = ',num2str(j)]);
                end
                d.mo.setGPU('off');
                d.clearData(1);
                save([TempFileName,num2str(i),'.mat'],'B','d');
                d.calculateData();
                d.toc();
            end
            d.clearData(1);
            d.recordCalHour([B.name,'3Finish']);
            save(['TempModel\',B.name,'3.mat'],'B','d');
            save(['TempModel\',B.name,'3_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_aNum',num2str(d.aNum),'.mat']);
            d.calculateData();
            d.show('XDisplacement');
            fs.disp('*****已平衡迭代*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_PostProcessingModule
        function Button_PostProcessingModuleButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.showB=0;
            d.showFilter();
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            UI_PostProcess(d); %调用MatDEM提供的后处理模块。
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_GenerateGIF
        function Button_GenerateGIFButtonPushed(app, event)
            %生成GIF，仅供参考。
            PlottingAreaPosition=app.Settings.PlottingAreaPosition;
            app.Settings.PlottingAreaPosition=[];
            setappdata(0,'app',app);
            B=app.Box;
            d=app.DataCenter;
            name=B.name;
            IntervalPerFrame=0.5;
            IndexBeg=1;
            IndexEnd=app.NumericEditField_MajorCycle.Value;
            num=IndexEnd-IndexBeg+1;
            mov=moviein(num);
            TempFileName=['data\step\',B.name,'temp_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_loopNum'];
            load([TempFileName,num2str(IndexEnd),'.mat']);
            d.calculateData();
            d.show('aR');
            close;
            d.data.TotalDisplacement=sqrt((d.data.XDisplacement).^2+(d.data.YDisplacement).^2+(d.data.ZDisplacement).^2);
            MaxTotalDisplacement=max(d.data.TotalDisplacement);
            for i=IndexBeg:IndexEnd
                TempFileName=['data\step\',B.name,'temp_ballR',num2str(B.ballR),'_distriRate',num2str(B.distriRate),'_loopNum'];
                load([TempFileName,num2str(i),'.mat']);
                d.calculateData();
                d.showB=2;
                if B.sampleL~=0
                    d.showFilter('SlideY',0.3,0.7);
                end
                d.show('aR');
                close;
                d.data.TotalDisplacement=sqrt((d.data.XDisplacement).^2+(d.data.YDisplacement).^2+(d.data.ZDisplacement).^2);
                d.data.TotalDisplacement(1)=MaxTotalDisplacement;
                d.show('TotalDisplacement');
                if B.sampleL~=0
                    view(30,60);
                end
                set(gcf,'Position',[10,10,1000,600]);
                mov(i+1)=getframe(gcf);
                im=frame2im(mov(i+1));
                [A,map]=rgb2ind(im,256);
                if i==IndexBeg
                    imwrite(A,map,['gif\',name,'.gif'],'gif', 'Loopcount',inf,'DelayTime',IntervalPerFrame);
                else
                    imwrite(A,map,['gif\',name,'.gif'],'gif','WriteMode','append','DelayTime',IntervalPerFrame);
                end
                close;
            end
            fs.disp('*****已生成GIF*****');
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
        end

        % Button pushed function: Button_Run
        function Button_RunButtonPushed(app, event)
            %执行命令行指令，仅供参考。
            B=app.Box;
            d=app.DataCenter;
            app.TextArea_Message.Value=[app.EditField_CommandLine.Value;app.TextArea_Message.Value];
            try
                eval(app.EditField_CommandLine.Value);
            catch ME
                app.TextArea_Message.Value=[ME.identifier;app.TextArea_Message.Value];
            end
            app.EditField_CommandLine.Value='';
            %由于仅更新B和d，因此使用者自行声明的变量应为B.SET.XXX的形式（仅在本次调用函数时有用的临时变量除外）。
            app.Box=B;
            app.DataCenter=d;
        end

        % Close request function: WinMain
        function WinMainCloseRequest(app, event)
            delete(app)
            %建议使用者在函数WinMainCloseRequest中添加如下代码，尽管该函数也不是必需的。。
            try
                %在关闭窗口应用前清除全局变量app和CurrentWindow。
                rmappdata(0,'app');
                rmappdata(0,'CurrentWindow');
            catch
                %不做任何处理。
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create WinMain and hide until all components are created
            app.WinMain = uifigure('Visible', 'off');
            app.WinMain.Position = [100 100 720 480];
            app.WinMain.Name = 'MatDEM自定义窗口示例-简单滑坡';
            app.WinMain.Resize = 'off';
            app.WinMain.CloseRequestFcn = createCallbackFcn(app, @WinMainCloseRequest, true);

            % Create Panel_Step1
            app.Panel_Step1 = uipanel(app.WinMain);
            app.Panel_Step1.Title = '第一步：几何建模';
            app.Panel_Step1.Position = [20 260 330 200];

            % Create Label
            app.Label = uilabel(app.Panel_Step1);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [11 145 25 22];
            app.Label.Text = '宽';

            % Create NumericEditField_Width
            app.NumericEditField_Width = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Width.Limits = [0 Inf];
            app.NumericEditField_Width.Position = [50 145 40 22];
            app.NumericEditField_Width.Value = 50;

            % Create Label_2
            app.Label_2 = uilabel(app.Panel_Step1);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [121 144 25 22];
            app.Label_2.Text = '长';

            % Create NumericEditField_Length
            app.NumericEditField_Length = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Length.Limits = [0 Inf];
            app.NumericEditField_Length.Position = [160 145 40 22];

            % Create Label_3
            app.Label_3 = uilabel(app.Panel_Step1);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [231 144 25 22];
            app.Label_3.Text = '高';

            % Create NumericEditField_Height
            app.NumericEditField_Height = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Height.Limits = [0 Inf];
            app.NumericEditField_Height.Position = [270 145 40 22];
            app.NumericEditField_Height.Value = 30;

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_Step1);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [11 115 53 22];
            app.Label_4.Text = '平均半径';

            % Create NumericEditField_AverageRadius
            app.NumericEditField_AverageRadius = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_AverageRadius.Limits = [0 Inf];
            app.NumericEditField_AverageRadius.Position = [80 115 40 22];
            app.NumericEditField_AverageRadius.Value = 0.5;

            % Create Label_5
            app.Label_5 = uilabel(app.Panel_Step1);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [131 115 53 22];
            app.Label_5.Text = '分散系数';

            % Create NumericEditField_DistributionRate
            app.NumericEditField_DistributionRate = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_DistributionRate.Limits = [0 Inf];
            app.NumericEditField_DistributionRate.Position = [200 115 40 22];
            app.NumericEditField_DistributionRate.Value = 0.2;

            % Create CheckBox_UseClump
            app.CheckBox_UseClump = uicheckbox(app.Panel_Step1);
            app.CheckBox_UseClump.Text = '团簇';
            app.CheckBox_UseClump.Position = [260 115 50 22];

            % Create Panel_Platens
            app.Panel_Platens = uipanel(app.Panel_Step1);
            app.Panel_Platens.Title = '压力板';
            app.Panel_Platens.Position = [10 46 250 60];

            % Create CheckBox_LeftPlaten
            app.CheckBox_LeftPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_LeftPlaten.Text = '左';
            app.CheckBox_LeftPlaten.Position = [10 10 40 22];

            % Create CheckBox_RightPlaten
            app.CheckBox_RightPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_RightPlaten.Text = '右';
            app.CheckBox_RightPlaten.Position = [50 10 40 22];

            % Create CheckBox_FrontPlaten
            app.CheckBox_FrontPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_FrontPlaten.Text = '前';
            app.CheckBox_FrontPlaten.Position = [90 10 40 22];

            % Create CheckBox_BackPlaten
            app.CheckBox_BackPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_BackPlaten.Text = '后';
            app.CheckBox_BackPlaten.Position = [130 10 40 22];

            % Create CheckBox_BottomPlaten
            app.CheckBox_BottomPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_BottomPlaten.Text = '下';
            app.CheckBox_BottomPlaten.Position = [170 10 40 22];

            % Create CheckBox_TopPlaten
            app.CheckBox_TopPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_TopPlaten.Text = '上';
            app.CheckBox_TopPlaten.Position = [210 10 40 22];
            app.CheckBox_TopPlaten.Value = true;

            % Create Button_BuildInitialModel
            app.Button_BuildInitialModel = uibutton(app.Panel_Step1, 'push');
            app.Button_BuildInitialModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BuildInitialModelButtonPushed, true);
            app.Button_BuildInitialModel.Position = [270 46 50 60];
            app.Button_BuildInitialModel.Text = {'建立'; '初始'; '模型'};

            % Create Label_6
            app.Label_6 = uilabel(app.Panel_Step1);
            app.Label_6.HorizontalAlignment = 'right';
            app.Label_6.Position = [11 14 53 22];
            app.Label_6.Text = '时间系数';

            % Create NumericEditField_TimeRate
            app.NumericEditField_TimeRate = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_TimeRate.Limits = [1 Inf];
            app.NumericEditField_TimeRate.Position = [70 14 20 22];
            app.NumericEditField_TimeRate.Value = 1;

            % Create Button_GravitySediment
            app.Button_GravitySediment = uibutton(app.Panel_Step1, 'push');
            app.Button_GravitySediment.ButtonPushedFcn = createCallbackFcn(app, @Button_GravitySedimentButtonPushed, true);
            app.Button_GravitySediment.Position = [100 14 60 24];
            app.Button_GravitySediment.Text = '重力沉积';

            % Create Label_7
            app.Label_7 = uilabel(app.Panel_Step1);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.Position = [171 15 53 22];
            app.Label_7.Text = '压实次数';

            % Create NumericEditField_CompactionTime
            app.NumericEditField_CompactionTime = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_CompactionTime.Limits = [1 Inf];
            app.NumericEditField_CompactionTime.Position = [230 14 20 22];
            app.NumericEditField_CompactionTime.Value = 3;

            % Create Button_CompactSample
            app.Button_CompactSample = uibutton(app.Panel_Step1, 'push');
            app.Button_CompactSample.ButtonPushedFcn = createCallbackFcn(app, @Button_CompactSampleButtonPushed, true);
            app.Button_CompactSample.Position = [260 14 60 24];
            app.Button_CompactSample.Text = '压实样品';

            % Create Panel_Step2
            app.Panel_Step2 = uipanel(app.WinMain);
            app.Panel_Step2.Title = '第二步：分组赋材料';
            app.Panel_Step2.Position = [20 150 330 100];

            % Create Button_ImportMaterials
            app.Button_ImportMaterials = uibutton(app.Panel_Step2, 'push');
            app.Button_ImportMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_ImportMaterialsButtonPushed, true);
            app.Button_ImportMaterials.Position = [10 45 90 24];
            app.Button_ImportMaterials.Text = '导入材料';

            % Create Button_SetGroupsAndMaterials
            app.Button_SetGroupsAndMaterials = uibutton(app.Panel_Step2, 'push');
            app.Button_SetGroupsAndMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_SetGroupsAndMaterialsButtonPushed, true);
            app.Button_SetGroupsAndMaterials.Position = [120 45 90 24];
            app.Button_SetGroupsAndMaterials.Text = '分组并赋材料';

            % Create Button_EditConnections
            app.Button_EditConnections = uibutton(app.Panel_Step2, 'push');
            app.Button_EditConnections.ButtonPushedFcn = createCallbackFcn(app, @Button_EditConnectionsButtonPushed, true);
            app.Button_EditConnections.Position = [230 45 90 24];
            app.Button_EditConnections.Text = '编辑连接';

            % Create CheckBox_ConsiderFriction
            app.CheckBox_ConsiderFriction = uicheckbox(app.Panel_Step2);
            app.CheckBox_ConsiderFriction.Text = {'是否考虑单元'; '之间的摩擦力'};
            app.CheckBox_ConsiderFriction.Position = [10 7 90 32];

            % Create Label_8
            app.Label_8 = uilabel(app.Panel_Step2);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.Position = [121 7 41 32];
            app.Label_8.Text = {'标准平'; '衡次数'};

            % Create NumericEditField_StandardBalanceTime
            app.NumericEditField_StandardBalanceTime = uieditfield(app.Panel_Step2, 'numeric');
            app.NumericEditField_StandardBalanceTime.Limits = [1 Inf];
            app.NumericEditField_StandardBalanceTime.Position = [177 12 34 22];
            app.NumericEditField_StandardBalanceTime.Value = 3;

            % Create Button_BalanceBondedModel
            app.Button_BalanceBondedModel = uibutton(app.Panel_Step2, 'push');
            app.Button_BalanceBondedModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BalanceBondedModelButtonPushed, true);
            app.Button_BalanceBondedModel.Position = [230 11 90 24];
            app.Button_BalanceBondedModel.Text = '平衡胶结模型';

            % Create Panel_Step3
            app.Panel_Step3 = uipanel(app.WinMain);
            app.Panel_Step3.Title = '第三步：数值模拟';
            app.Panel_Step3.Position = [21 51 330 90];

            % Create CheckBox_CalculateHeat
            app.CheckBox_CalculateHeat = uicheckbox(app.Panel_Step3);
            app.CheckBox_CalculateHeat.Text = '是否计算热量';
            app.CheckBox_CalculateHeat.Position = [10 39 100 22];
            app.CheckBox_CalculateHeat.Value = true;

            % Create CheckBox_ConsiderShearForce
            app.CheckBox_ConsiderShearForce = uicheckbox(app.Panel_Step3);
            app.CheckBox_ConsiderShearForce.Text = {'是否考虑单元'; '之间的切向力'};
            app.CheckBox_ConsiderShearForce.Position = [10 9 100 32];

            % Create Label_9
            app.Label_9 = uilabel(app.Panel_Step3);
            app.Label_9.HorizontalAlignment = 'right';
            app.Label_9.Position = [118 39 77 22];
            app.Label_9.Text = '中间文件个数';

            % Create NumericEditField_MajorCycle
            app.NumericEditField_MajorCycle = uieditfield(app.Panel_Step3, 'numeric');
            app.NumericEditField_MajorCycle.Limits = [1 Inf];
            app.NumericEditField_MajorCycle.Position = [210 39 30 22];
            app.NumericEditField_MajorCycle.Value = 10;

            % Create Label_10
            app.Label_10 = uilabel(app.Panel_Step3);
            app.Label_10.HorizontalAlignment = 'right';
            app.Label_10.Position = [118 9 77 22];
            app.Label_10.Text = '中间文件间隔';

            % Create NumericEditField_MinorCycle
            app.NumericEditField_MinorCycle = uieditfield(app.Panel_Step3, 'numeric');
            app.NumericEditField_MinorCycle.Limits = [1 Inf];
            app.NumericEditField_MinorCycle.Position = [210 9 30 22];
            app.NumericEditField_MinorCycle.Value = 5;

            % Create Button_EquilibriumIteration
            app.Button_EquilibriumIteration = uibutton(app.Panel_Step3, 'push');
            app.Button_EquilibriumIteration.ButtonPushedFcn = createCallbackFcn(app, @Button_EquilibriumIterationButtonPushed, true);
            app.Button_EquilibriumIteration.Position = [250 15 70 40];
            app.Button_EquilibriumIteration.Text = '平衡迭代';

            % Create Button_PostProcessingModule
            app.Button_PostProcessingModule = uibutton(app.WinMain, 'push');
            app.Button_PostProcessingModule.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModuleButtonPushed, true);
            app.Button_PostProcessingModule.Position = [20 17 150 24];
            app.Button_PostProcessingModule.Text = '后处理模块';

            % Create Button_GenerateGIF
            app.Button_GenerateGIF = uibutton(app.WinMain, 'push');
            app.Button_GenerateGIF.ButtonPushedFcn = createCallbackFcn(app, @Button_GenerateGIFButtonPushed, true);
            app.Button_GenerateGIF.Position = [200 17 150 24];
            app.Button_GenerateGIF.Text = '生成GIF';

            % Create UIAxes_PlottingArea
            app.UIAxes_PlottingArea = uiaxes(app.WinMain);
            title(app.UIAxes_PlottingArea, '缩略图')
            xlabel(app.UIAxes_PlottingArea, 'X')
            ylabel(app.UIAxes_PlottingArea, 'Y')
            app.UIAxes_PlottingArea.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea.Position = [360 210 340 250];

            % Create Label_11
            app.Label_11 = uilabel(app.WinMain);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.Position = [371 179 41 22];
            app.Label_11.Text = '命令行';

            % Create EditField_CommandLine
            app.EditField_CommandLine = uieditfield(app.WinMain, 'text');
            app.EditField_CommandLine.Position = [426 179 225 22];

            % Create Button_Run
            app.Button_Run = uibutton(app.WinMain, 'push');
            app.Button_Run.ButtonPushedFcn = createCallbackFcn(app, @Button_RunButtonPushed, true);
            app.Button_Run.Position = [660 177 40 24];
            app.Button_Run.Text = '运行';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.WinMain);
            app.TextArea_Message.Position = [370 20 330 150];
            app.TextArea_Message.Value = {'*****此处显示消息与历史纪录*****'};

            % Show the figure after all components are created
            app.WinMain.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_BoxModel

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