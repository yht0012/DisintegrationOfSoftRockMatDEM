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
        %���ڶ���������Եļ���˵����
        %1������ʹ�����ڿ����Ͳ��Դ���Ӧ��ʱ��������Setting��Box�Լ�DataCenter���ϸ������������������ⲿ�ֹ����޷�����ʹ�á�
        %2�����п������������ĳ���ԣ���Settings��ʱ���轫��Ȩ����Ϊpublic��
        %3������ͨ��ָ��f.runWinApp(...)���д���Ӧ��ʱMatDEM���������������ԵĶ��岿�֣����ֻ���ں���startupFcn��Ϊ������Ը���ֵ��
        Settings; %����Ӧ�õ�������Ϣ��
        Box; %����obj_Box�Ķ���B��
        DataCenter; %����build�Ķ���d��
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            %�����ʼ��������Ӧ�ں���startupFcn����ɣ����ܸú��������Ǳ���ġ�
            %Ϊ������Ը���ֵ���磺
            app.Settings=[]; %Ϊ����Settings����ֵ��
            app.Box=[]; %Ϊ����Box����ֵ��
            app.DataCenter=[]; %Ϊ����DataCenter����ֵ��
            %Ϊ��App Designer�л�ͨ��ֱ�����е�����.m�ļ��ķ�ʽ���Դ���Ӧ�ã������ں���startupFcn����������´��롣
            %ʵ���ϣ������ⲿͨ��ָ��f.runWinApp(...)���д���Ӧ�ã���MatDEM���Զ�ִ����Ӧ�Ĵ��롣
            app.Settings.PlottingAreaParentHandle=app.WinMain; %������ͼ�����ڸ����ڣ���ؼ����ľ����
            app.Settings.PlottingAreaParentPosition=app.WinMain.Position; %������ͼ�����ڸ����ڣ���ؼ�����λ�á�
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingArea; %������ͼ���ľ����
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingArea.Position; %������ͼ����λ�á�
            %����ʹ���߿����Ĵ���Ӧ���д��ڶ����ͼ�������ͨ������f.ChangePlottingAreaParent��f.ChangePlottingArea�л���ǰ��ͼ����
            %���磺f.ChangePlottingAreaParent(app.Panel2); f.ChangePlottingArea(app.UIAxes2);
            app.Settings.OutputFocus=app.TextArea_Message; %������Ϣ������㡣
            %����ʹ���߿����Ĵ���Ӧ���д��ڶ����Ϣ������㣬���ͨ������f.ChangeOutputFocus�л���ǰ��Ϣ������㡣
            %���磺f.ChangeOutputFocus(app.TextArea2);
            setappdata(0,'app',app); %��app��Ϊȫ�ֱ�����
            setappdata(0,'CurrentWindow',1); %��ȫ�ֱ���CurrentWindow��Ϊ1��
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
            %������ͨ��ָ��B.setUIoutput(...)������Ϣ������㡣
            d=B.d;
            d.showB=2;
            d.show('aR');
            fs.disp('*****�ѽ�����ʼģ��*****');
            app.Box=B; %��B�洢Ϊapp.Box��
            app.DataCenter=d; %��d�洢Ϊapp.DataCenter��
        end

        % Button pushed function: Button_GravitySediment
        function Button_GravitySedimentButtonPushed(app, event)
            %�ڴ�����ؼ����¼���Ӧ�����Ŀ�ͷ�ͽ�β��Ӧͨ��B<->app.Box�Լ�d<->app.DataCenter֮���໥��ֵ�������ݡ�
            %������Ҫ���������и�߶���C����Ӧͨ���洢��B.SET�дӶ��ڸ����ؼ����¼���Ӧ����֮�䴫�ݡ�
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            B.gravitySediment(app.NumericEditField_TimeRate.Value);
            d.mo.setGPU('off');
            d.show('aR');
            fs.disp('*****����������*****');
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
            fs.disp('*****��ѹʵ��Ʒ*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_ImportMaterials
        function Button_ImportMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            UI_Material(d,B.ballR); %����MatDEM�ṩ�ĵ������ģ�顣
            fs.disp('*****�ѵ������*****');
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_SetGroupsAndMaterials
        function Button_SetGroupsAndMaterialsButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            %����MatDEM�ṩ�Ĳ���ģ�����GUIDE����������޷�ͨ������f.ChangePlottingAreaParent��f.ChangePlottingArea�л���ǰ��ͼ����
            PlottingAreaPosition=app.Settings.PlottingAreaPosition; %Ϊ�ˣ�������һ�����ݴ浱ǰ��ͼ��λ�á�
            app.Settings.PlottingAreaPosition=[]; %Ȼ�󽫵�ǰ��ͼ��λ����ʱ�ÿա�
            setappdata(0,'app',app); %��ʱ����ȫ�ֱ���app��
            d.GROUP=UI_Group(d); %����MatDEM�ṩ�ķ��鲢������ģ�顣
            app.Settings.PlottingAreaPosition=PlottingAreaPosition; %����ٻָ�ԭ�л�ͼ��λ�á�
            setappdata(0,'app',app); %��ʱ����ȫ�ֱ���app��
            d.show('aMatId');
            fs.disp('*****�ѷ��鲢������*****');
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
            UI_Bond(d); %����MatDEM�ṩ�ı༭����ģ�顣
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            d.show('--');
            fs.disp('*****�ѱ༭����*****');
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
            fs.disp('*****��ƽ�⽺��ģ��*****');
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
            fs.disp('*****��ƽ�����*****');
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
            UI_PostProcess(d); %����MatDEM�ṩ�ĺ���ģ�顣
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
            app.Box=B;
            app.DataCenter=d;
        end

        % Button pushed function: Button_GenerateGIF
        function Button_GenerateGIFButtonPushed(app, event)
            %����GIF�������ο���
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
            fs.disp('*****������GIF*****');
            app.Settings.PlottingAreaPosition=PlottingAreaPosition;
            setappdata(0,'app',app);
        end

        % Button pushed function: Button_Run
        function Button_RunButtonPushed(app, event)
            %ִ��������ָ������ο���
            B=app.Box;
            d=app.DataCenter;
            app.TextArea_Message.Value=[app.EditField_CommandLine.Value;app.TextArea_Message.Value];
            try
                eval(app.EditField_CommandLine.Value);
            catch ME
                app.TextArea_Message.Value=[ME.identifier;app.TextArea_Message.Value];
            end
            app.EditField_CommandLine.Value='';
            %���ڽ�����B��d�����ʹ�������������ı���ӦΪB.SET.XXX����ʽ�����ڱ��ε��ú���ʱ���õ���ʱ�������⣩��
            app.Box=B;
            app.DataCenter=d;
        end

        % Close request function: WinMain
        function WinMainCloseRequest(app, event)
            delete(app)
            %����ʹ�����ں���WinMainCloseRequest��������´��룬���ܸú���Ҳ���Ǳ���ġ���
            try
                %�ڹرմ���Ӧ��ǰ���ȫ�ֱ���app��CurrentWindow��
                rmappdata(0,'app');
                rmappdata(0,'CurrentWindow');
            catch
                %�����κδ���
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
            app.WinMain.Name = 'MatDEM�Զ��崰��ʾ��-�򵥻���';
            app.WinMain.Resize = 'off';
            app.WinMain.CloseRequestFcn = createCallbackFcn(app, @WinMainCloseRequest, true);

            % Create Panel_Step1
            app.Panel_Step1 = uipanel(app.WinMain);
            app.Panel_Step1.Title = '��һ�������ν�ģ';
            app.Panel_Step1.Position = [20 260 330 200];

            % Create Label
            app.Label = uilabel(app.Panel_Step1);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [11 145 25 22];
            app.Label.Text = '��';

            % Create NumericEditField_Width
            app.NumericEditField_Width = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Width.Limits = [0 Inf];
            app.NumericEditField_Width.Position = [50 145 40 22];
            app.NumericEditField_Width.Value = 50;

            % Create Label_2
            app.Label_2 = uilabel(app.Panel_Step1);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [121 144 25 22];
            app.Label_2.Text = '��';

            % Create NumericEditField_Length
            app.NumericEditField_Length = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Length.Limits = [0 Inf];
            app.NumericEditField_Length.Position = [160 145 40 22];

            % Create Label_3
            app.Label_3 = uilabel(app.Panel_Step1);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [231 144 25 22];
            app.Label_3.Text = '��';

            % Create NumericEditField_Height
            app.NumericEditField_Height = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_Height.Limits = [0 Inf];
            app.NumericEditField_Height.Position = [270 145 40 22];
            app.NumericEditField_Height.Value = 30;

            % Create Label_4
            app.Label_4 = uilabel(app.Panel_Step1);
            app.Label_4.HorizontalAlignment = 'right';
            app.Label_4.Position = [11 115 53 22];
            app.Label_4.Text = 'ƽ���뾶';

            % Create NumericEditField_AverageRadius
            app.NumericEditField_AverageRadius = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_AverageRadius.Limits = [0 Inf];
            app.NumericEditField_AverageRadius.Position = [80 115 40 22];
            app.NumericEditField_AverageRadius.Value = 0.5;

            % Create Label_5
            app.Label_5 = uilabel(app.Panel_Step1);
            app.Label_5.HorizontalAlignment = 'right';
            app.Label_5.Position = [131 115 53 22];
            app.Label_5.Text = '��ɢϵ��';

            % Create NumericEditField_DistributionRate
            app.NumericEditField_DistributionRate = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_DistributionRate.Limits = [0 Inf];
            app.NumericEditField_DistributionRate.Position = [200 115 40 22];
            app.NumericEditField_DistributionRate.Value = 0.2;

            % Create CheckBox_UseClump
            app.CheckBox_UseClump = uicheckbox(app.Panel_Step1);
            app.CheckBox_UseClump.Text = '�Ŵ�';
            app.CheckBox_UseClump.Position = [260 115 50 22];

            % Create Panel_Platens
            app.Panel_Platens = uipanel(app.Panel_Step1);
            app.Panel_Platens.Title = 'ѹ����';
            app.Panel_Platens.Position = [10 46 250 60];

            % Create CheckBox_LeftPlaten
            app.CheckBox_LeftPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_LeftPlaten.Text = '��';
            app.CheckBox_LeftPlaten.Position = [10 10 40 22];

            % Create CheckBox_RightPlaten
            app.CheckBox_RightPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_RightPlaten.Text = '��';
            app.CheckBox_RightPlaten.Position = [50 10 40 22];

            % Create CheckBox_FrontPlaten
            app.CheckBox_FrontPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_FrontPlaten.Text = 'ǰ';
            app.CheckBox_FrontPlaten.Position = [90 10 40 22];

            % Create CheckBox_BackPlaten
            app.CheckBox_BackPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_BackPlaten.Text = '��';
            app.CheckBox_BackPlaten.Position = [130 10 40 22];

            % Create CheckBox_BottomPlaten
            app.CheckBox_BottomPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_BottomPlaten.Text = '��';
            app.CheckBox_BottomPlaten.Position = [170 10 40 22];

            % Create CheckBox_TopPlaten
            app.CheckBox_TopPlaten = uicheckbox(app.Panel_Platens);
            app.CheckBox_TopPlaten.Text = '��';
            app.CheckBox_TopPlaten.Position = [210 10 40 22];
            app.CheckBox_TopPlaten.Value = true;

            % Create Button_BuildInitialModel
            app.Button_BuildInitialModel = uibutton(app.Panel_Step1, 'push');
            app.Button_BuildInitialModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BuildInitialModelButtonPushed, true);
            app.Button_BuildInitialModel.Position = [270 46 50 60];
            app.Button_BuildInitialModel.Text = {'����'; '��ʼ'; 'ģ��'};

            % Create Label_6
            app.Label_6 = uilabel(app.Panel_Step1);
            app.Label_6.HorizontalAlignment = 'right';
            app.Label_6.Position = [11 14 53 22];
            app.Label_6.Text = 'ʱ��ϵ��';

            % Create NumericEditField_TimeRate
            app.NumericEditField_TimeRate = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_TimeRate.Limits = [1 Inf];
            app.NumericEditField_TimeRate.Position = [70 14 20 22];
            app.NumericEditField_TimeRate.Value = 1;

            % Create Button_GravitySediment
            app.Button_GravitySediment = uibutton(app.Panel_Step1, 'push');
            app.Button_GravitySediment.ButtonPushedFcn = createCallbackFcn(app, @Button_GravitySedimentButtonPushed, true);
            app.Button_GravitySediment.Position = [100 14 60 24];
            app.Button_GravitySediment.Text = '��������';

            % Create Label_7
            app.Label_7 = uilabel(app.Panel_Step1);
            app.Label_7.HorizontalAlignment = 'right';
            app.Label_7.Position = [171 15 53 22];
            app.Label_7.Text = 'ѹʵ����';

            % Create NumericEditField_CompactionTime
            app.NumericEditField_CompactionTime = uieditfield(app.Panel_Step1, 'numeric');
            app.NumericEditField_CompactionTime.Limits = [1 Inf];
            app.NumericEditField_CompactionTime.Position = [230 14 20 22];
            app.NumericEditField_CompactionTime.Value = 3;

            % Create Button_CompactSample
            app.Button_CompactSample = uibutton(app.Panel_Step1, 'push');
            app.Button_CompactSample.ButtonPushedFcn = createCallbackFcn(app, @Button_CompactSampleButtonPushed, true);
            app.Button_CompactSample.Position = [260 14 60 24];
            app.Button_CompactSample.Text = 'ѹʵ��Ʒ';

            % Create Panel_Step2
            app.Panel_Step2 = uipanel(app.WinMain);
            app.Panel_Step2.Title = '�ڶ��������鸳����';
            app.Panel_Step2.Position = [20 150 330 100];

            % Create Button_ImportMaterials
            app.Button_ImportMaterials = uibutton(app.Panel_Step2, 'push');
            app.Button_ImportMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_ImportMaterialsButtonPushed, true);
            app.Button_ImportMaterials.Position = [10 45 90 24];
            app.Button_ImportMaterials.Text = '�������';

            % Create Button_SetGroupsAndMaterials
            app.Button_SetGroupsAndMaterials = uibutton(app.Panel_Step2, 'push');
            app.Button_SetGroupsAndMaterials.ButtonPushedFcn = createCallbackFcn(app, @Button_SetGroupsAndMaterialsButtonPushed, true);
            app.Button_SetGroupsAndMaterials.Position = [120 45 90 24];
            app.Button_SetGroupsAndMaterials.Text = '���鲢������';

            % Create Button_EditConnections
            app.Button_EditConnections = uibutton(app.Panel_Step2, 'push');
            app.Button_EditConnections.ButtonPushedFcn = createCallbackFcn(app, @Button_EditConnectionsButtonPushed, true);
            app.Button_EditConnections.Position = [230 45 90 24];
            app.Button_EditConnections.Text = '�༭����';

            % Create CheckBox_ConsiderFriction
            app.CheckBox_ConsiderFriction = uicheckbox(app.Panel_Step2);
            app.CheckBox_ConsiderFriction.Text = {'�Ƿ��ǵ�Ԫ'; '֮���Ħ����'};
            app.CheckBox_ConsiderFriction.Position = [10 7 90 32];

            % Create Label_8
            app.Label_8 = uilabel(app.Panel_Step2);
            app.Label_8.HorizontalAlignment = 'right';
            app.Label_8.Position = [121 7 41 32];
            app.Label_8.Text = {'��׼ƽ'; '�����'};

            % Create NumericEditField_StandardBalanceTime
            app.NumericEditField_StandardBalanceTime = uieditfield(app.Panel_Step2, 'numeric');
            app.NumericEditField_StandardBalanceTime.Limits = [1 Inf];
            app.NumericEditField_StandardBalanceTime.Position = [177 12 34 22];
            app.NumericEditField_StandardBalanceTime.Value = 3;

            % Create Button_BalanceBondedModel
            app.Button_BalanceBondedModel = uibutton(app.Panel_Step2, 'push');
            app.Button_BalanceBondedModel.ButtonPushedFcn = createCallbackFcn(app, @Button_BalanceBondedModelButtonPushed, true);
            app.Button_BalanceBondedModel.Position = [230 11 90 24];
            app.Button_BalanceBondedModel.Text = 'ƽ�⽺��ģ��';

            % Create Panel_Step3
            app.Panel_Step3 = uipanel(app.WinMain);
            app.Panel_Step3.Title = '����������ֵģ��';
            app.Panel_Step3.Position = [21 51 330 90];

            % Create CheckBox_CalculateHeat
            app.CheckBox_CalculateHeat = uicheckbox(app.Panel_Step3);
            app.CheckBox_CalculateHeat.Text = '�Ƿ��������';
            app.CheckBox_CalculateHeat.Position = [10 39 100 22];
            app.CheckBox_CalculateHeat.Value = true;

            % Create CheckBox_ConsiderShearForce
            app.CheckBox_ConsiderShearForce = uicheckbox(app.Panel_Step3);
            app.CheckBox_ConsiderShearForce.Text = {'�Ƿ��ǵ�Ԫ'; '֮���������'};
            app.CheckBox_ConsiderShearForce.Position = [10 9 100 32];

            % Create Label_9
            app.Label_9 = uilabel(app.Panel_Step3);
            app.Label_9.HorizontalAlignment = 'right';
            app.Label_9.Position = [118 39 77 22];
            app.Label_9.Text = '�м��ļ�����';

            % Create NumericEditField_MajorCycle
            app.NumericEditField_MajorCycle = uieditfield(app.Panel_Step3, 'numeric');
            app.NumericEditField_MajorCycle.Limits = [1 Inf];
            app.NumericEditField_MajorCycle.Position = [210 39 30 22];
            app.NumericEditField_MajorCycle.Value = 10;

            % Create Label_10
            app.Label_10 = uilabel(app.Panel_Step3);
            app.Label_10.HorizontalAlignment = 'right';
            app.Label_10.Position = [118 9 77 22];
            app.Label_10.Text = '�м��ļ����';

            % Create NumericEditField_MinorCycle
            app.NumericEditField_MinorCycle = uieditfield(app.Panel_Step3, 'numeric');
            app.NumericEditField_MinorCycle.Limits = [1 Inf];
            app.NumericEditField_MinorCycle.Position = [210 9 30 22];
            app.NumericEditField_MinorCycle.Value = 5;

            % Create Button_EquilibriumIteration
            app.Button_EquilibriumIteration = uibutton(app.Panel_Step3, 'push');
            app.Button_EquilibriumIteration.ButtonPushedFcn = createCallbackFcn(app, @Button_EquilibriumIterationButtonPushed, true);
            app.Button_EquilibriumIteration.Position = [250 15 70 40];
            app.Button_EquilibriumIteration.Text = 'ƽ�����';

            % Create Button_PostProcessingModule
            app.Button_PostProcessingModule = uibutton(app.WinMain, 'push');
            app.Button_PostProcessingModule.ButtonPushedFcn = createCallbackFcn(app, @Button_PostProcessingModuleButtonPushed, true);
            app.Button_PostProcessingModule.Position = [20 17 150 24];
            app.Button_PostProcessingModule.Text = '����ģ��';

            % Create Button_GenerateGIF
            app.Button_GenerateGIF = uibutton(app.WinMain, 'push');
            app.Button_GenerateGIF.ButtonPushedFcn = createCallbackFcn(app, @Button_GenerateGIFButtonPushed, true);
            app.Button_GenerateGIF.Position = [200 17 150 24];
            app.Button_GenerateGIF.Text = '����GIF';

            % Create UIAxes_PlottingArea
            app.UIAxes_PlottingArea = uiaxes(app.WinMain);
            title(app.UIAxes_PlottingArea, '����ͼ')
            xlabel(app.UIAxes_PlottingArea, 'X')
            ylabel(app.UIAxes_PlottingArea, 'Y')
            app.UIAxes_PlottingArea.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea.Position = [360 210 340 250];

            % Create Label_11
            app.Label_11 = uilabel(app.WinMain);
            app.Label_11.HorizontalAlignment = 'right';
            app.Label_11.Position = [371 179 41 22];
            app.Label_11.Text = '������';

            % Create EditField_CommandLine
            app.EditField_CommandLine = uieditfield(app.WinMain, 'text');
            app.EditField_CommandLine.Position = [426 179 225 22];

            % Create Button_Run
            app.Button_Run = uibutton(app.WinMain, 'push');
            app.Button_Run.ButtonPushedFcn = createCallbackFcn(app, @Button_RunButtonPushed, true);
            app.Button_Run.Position = [660 177 40 24];
            app.Button_Run.Text = '����';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.WinMain);
            app.TextArea_Message.Position = [370 20 330 150];
            app.TextArea_Message.Value = {'*****�˴���ʾ��Ϣ����ʷ��¼*****'};

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