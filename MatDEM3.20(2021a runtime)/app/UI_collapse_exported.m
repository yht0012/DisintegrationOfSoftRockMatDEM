classdef GoafCollapse_lab_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        GoafCollapse                    matlab.ui.Figure
        TabGroup                        matlab.ui.container.TabGroup
        Step0InitialmodelTab            matlab.ui.container.Tab
        Panel_2                         matlab.ui.container.Panel
        InitialwidthEditFieldLabel      matlab.ui.control.Label
        InitialwidthEditField           matlab.ui.control.NumericEditField
        InitialheightEditFieldLabel     matlab.ui.control.Label
        InitialheightEditField          matlab.ui.control.NumericEditField
        ParticleradiusEditFieldLabel    matlab.ui.control.Label
        ParticleradiusEditField         matlab.ui.control.NumericEditField
        DistriRateEditFieldLabel        matlab.ui.control.Label
        DistriRateEditField             matlab.ui.control.NumericEditField
        GenerateinitialmodelButton      matlab.ui.control.Button
        RandSeedEditFieldLabel          matlab.ui.control.Label
        RandSeedEditField               matlab.ui.control.NumericEditField
        GravitySedimentEditFieldLabel   matlab.ui.control.Label
        GravitySedimentEditField        matlab.ui.control.NumericEditField
        CompactSampleEditFieldLabel     matlab.ui.control.Label
        CompactSampleEditField          matlab.ui.control.NumericEditField
        BegintosedimentateButton        matlab.ui.control.Button
        BegintoCompactButton            matlab.ui.control.Button
        mLabel                          matlab.ui.control.Label
        mLabel_2                        matlab.ui.control.Label
        mLabel_3                        matlab.ui.control.Label
        timesLabel                      matlab.ui.control.Label
        timesLabel_2                    matlab.ui.control.Label
        NameofModelEditFieldLabel       matlab.ui.control.Label
        NameofModelEditField            matlab.ui.control.EditField
        UIAxes_PlottingArea1            matlab.ui.control.UIAxes
        Step1SetMaterialsbyLayersTab    matlab.ui.container.Tab
        GeneratethelayersButtonGroup    matlab.ui.container.ButtonGroup
        YesButton                       matlab.ui.control.RadioButton
        NoButton                        matlab.ui.control.RadioButton
        PleaseenterthelayerpositioninturnPanel  matlab.ui.container.Panel
        GeneratethelayersButton         matlab.ui.control.Button
        Text_EditField                  matlab.ui.control.EditField
        LayerMax_Label                  matlab.ui.control.Label
        ThemaximumvalueshouldbelessthanLabel  matlab.ui.control.Label
        SaveLayerButton                 matlab.ui.control.Button
        SetMaterialsbyLayersPanel       matlab.ui.container.Panel
        ImportMaterialsButton           matlab.ui.control.Button
        GiveMaterialsButton             matlab.ui.control.Button
        UIAxes_PlottingArea2            matlab.ui.control.UIAxes
        NaturalbalancePanel             matlab.ui.container.Panel
        NaturalbalanceEditFieldLabel    matlab.ui.control.Label
        NaturalbalanceEditField         matlab.ui.control.NumericEditField
        timesLabel_3                    matlab.ui.control.Label
        BegintoNaturalBalanceButton     matlab.ui.control.Button
        Step2GoafmodelTab               matlab.ui.container.Tab
        Panel_3                         matlab.ui.container.Panel
        GoafheightSliderLabel           matlab.ui.control.Label
        GoafheightSlider                matlab.ui.control.Slider
        GoafwidthSliderLabel            matlab.ui.control.Label
        GoafwidthSlider                 matlab.ui.control.Slider
        PillarwidthSliderLabel          matlab.ui.control.Label
        PillarwidthSlider               matlab.ui.control.Slider
        RoofthicknessSliderLabel        matlab.ui.control.Label
        RoofthicknessSlider             matlab.ui.control.Slider
        GenerategoafmodelButton         matlab.ui.control.Button
        UIAxes_PlottingArea3            matlab.ui.control.UIAxes
        Step3SimulationTab              matlab.ui.container.Tab
        Panel                           matlab.ui.container.Panel
        TotalCircleEditFieldLabel       matlab.ui.control.Label
        TotalCircleEditField            matlab.ui.control.NumericEditField
        StepNumEditFieldLabel           matlab.ui.control.Label
        StepNumEditField                matlab.ui.control.NumericEditField
        EachIterationNumEditFieldLabel  matlab.ui.control.Label
        EachIterationNumEditField       matlab.ui.control.NumericEditField
        BegintosimulateButton           matlab.ui.control.Button
        timesLabel_4                    matlab.ui.control.Label
        timesLabel_5                    matlab.ui.control.Label
        timesLabel_6                    matlab.ui.control.Label
        SaveresultButton                matlab.ui.control.Button
        UIAxes_PlottingArea4            matlab.ui.control.UIAxes
        TextArea_Message                matlab.ui.control.TextArea
    end

    
    properties (Access = public)
        Settings;
        Box; % Description
        DataCenter;
        OtherData;
        Graphs; % Description
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Settings=[];
            app.Box=[];
            app.DataCenter=[];
            app.OtherData=[];
            app.Settings.PlottingAreaParentHandle=app.Step0InitialmodelTab;%???????????????????
            app.Settings.PlottingAreaParentPosition=app.Step0InitialmodelTab.Position;%???????????????????
            app.Settings.PlottingAreaHandle=app.UIAxes_PlottingArea1;%?????????
            app.Settings.PlottingAreaPosition=app.UIAxes_PlottingArea1.Position;%?????????
            %???????????????????????????f.ChangePlottingAreaParent?f.ChangePlottingArea????????
            %???f.ChangePlottingAreaParent(app.Panel2); f.ChangePlottingArea(app.UIAxes_PlottingArea3);
            app.Settings.OutputFocus=app.TextArea_Message;%?????????
            %??????????????????????????????f.ChangeOutputFocus???????????
            %???f.ChangeOutputFocus(app.TextArea2);
            setappdata(0,'app',app);%?app???????
            setappdata(0,'CurrentWindow',1);%?????CurrentWindow??1?
        end

        % Button pushed function: GenerateinitialmodelButton
        function GenerateinitialmodelButtonPushed(app, event)
            fs.disp('*****开始生成初始模型箱*****');
            fs.randSeed(app.RandSeedEditField.Value);%build random model
            B=obj_Box;%build a box object
            B.name=app.NameofModelEditField.Value;
            B.GPUstatus='auto';
            width=app.InitialwidthEditField.Value;
            length=0;
            height=app.InitialheightEditField.Value;
            ballR=app.ParticleradiusEditField.Value;%width, length, height, radius
            distriRate=app.DistriRateEditField.Value;%define distribution of ball radius,
            isClump=0;
            B.ballR=ballR;
            B.isClump=isClump;
            B.distriRate=distriRate;
            B.sampleW=width;
            B.sampleL=length;
            B.sampleH=height;
            B.platenStatus=[0,0,0,0,0,1];
            B.buildInitialModel();
            d=B.d;
            d.showB=2;
            %             app.UIAxes_PlottingArea1.Visible='on'
            %             app.BegintosedimentateButton.Enable='on';
            %             colormap(app.UIAxes_PlottingArea1,"jet");
            d.show('aR');
            fs.disp('*****初始模型箱已生成*****');
            app.BegintosedimentateButton.Enable='on';
            app.Box=B; %?B???app.Box?
            app.DataCenter=d; %?d???app.DataCenter?
            msgbox('初始模型箱已生成, 请沉积样本');
        end

        % Button pushed function: BegintosedimentateButton
        function BegintosedimentateButtonPushed(app, event)
            fs.disp('*****开始沉积样本*****');
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            B.gravitySediment(app.GravitySedimentEditField.Value);
            d.mo.setGPU('off');
            d.show('aR');
            fs.disp('*****样本沉积完成*****');
            app.BegintoCompactButton.Enable='on';
            app.Box=B;
            app.DataCenter=d;
            msgbox('样本沉积完成, 请压实样本');
        end

        % Button pushed function: BegintoCompactButton
        function BegintoCompactButtonPushed(app, event)
            fs.disp('*****开始压实样本*****');
            B=app.Box;
            d=app.DataCenter;
            d.mo.setGPU('auto');
            B.compactSample(app.CompactSampleEditField.Value);
            d.mo.setGPU('off');
            d.clearData(1);
            d.recordCalHour([B.name,'1Finish']);
            d.calculateData();
            d.show('aR');
            fs.disp('*****已压实样本*****');
            app.Box=B;
            app.DataCenter=d;
            msgbox('已压实样本, 前往步骤1:设置岩土层及材料');
        end

        % Button pushed function: GenerategoafmodelButton
        function GenerategoafmodelButtonPushed(app, event)
            fs.disp('*****开始生成采空区模型*****');
            B=app.Box;
            d=app.DataCenter;
            B.setUIoutput();
            d.mo.setGPU('off');
            d.mo.bFilter(:)=true;
            d.deleteConnection('boundary');
            d.mo.zeroBalance();
            d.resetStatus();
            d.mo.isHeat=1;%calculate heat in the model
            d.setStandarddT();
            d.mo.setGPU('off');
            CHValue=app.GoafheightSlider.Value;
            CWValue=app.GoafwidthSlider.Value;
            KZValue=app.PillarwidthSlider.Value;
            DTValue=app.RoofthicknessSlider.Value;
            Tunnel1_rig=0.5*app.InitialwidthEditField.Value-0.5*KZValue;
            Tunnel2_lef=0.5*app.InitialwidthEditField.Value+0.5*KZValue;
            Tunneltop1=17-DTValue;
            TunnelThick=DTValue;
            mX=d.mo.aX(1:d.mNum);mZ=d.mo.aZ(1:d.mNum);
            GoafFilter=(mX<Tunnel1_rig&mX>Tunnel1_rig-CWValue&mZ<17-DTValue&mZ>17-DTValue-CHValue)|(mX<Tunnel2_lef+CWValue&mX>Tunnel2_lef&mZ<17-DTValue&mZ>17-DTValue-CHValue);
            d.addGroup('Goaf',find(GoafFilter));
            Goaf=d.getGroupId('Goaf');
            d.delElement(Goaf);
            mX1=d.mo.aX(1:d.mNum);mY1=d.mo.aY(1:d.mNum);mZ1=d.mo.aZ(1:d.mNum);
            Crack2Filter=mZ1<(Tunneltop1+TunnelThick)&mZ1>Tunneltop1&mX1>Tunnel1_rig-CWValue&mX1<Tunnel1_rig|mZ1<(Tunneltop1+TunnelThick)&mZ1>Tunneltop1&mX1<Tunnel2_lef+CWValue&mX1>Tunnel2_lef;
            d.addGroup('Crack2',find(Crack2Filter));
            d.breakGroup('Crack2');
            d.mo.setNearbyBall();
            d.mo.zeroBalance();
            f.ChangePlottingAreaParent(app.Step2GoafmodelTab);
            f.ChangePlottingArea(app.UIAxes_PlottingArea3);
            d.show('aMatId'  );
            fs.disp('*****采空区模型已生成*****');
            app.BegintosimulateButton.Enable='on';
            app.Box=B;
            app.DataCenter=d;
            msgbox('采空区模型已生成,请前往步骤3：模拟计算');
        end

        % Button pushed function: BegintosimulateButton
        function BegintosimulateButtonPushed(app, event)
            fs.disp('*****开始获取采空区模型*****');
            B=app.Box;
            d=app.DataCenter;
            B.setUIoutput();
            d.mo.setGPU('off');
            d.deleteConnection('boundary');
            d.mo.zeroBalance();
            d.resetStatus();
            d.mo.isHeat=1;%calculate heat in the model
            d.setStandarddT();
            d.mo.isCrack=1;
            d.breakGroup('sample','lefPlaten');
            d.mo.setGPU('auto');
            fs.disp('*****采空区模型已获取*****');
            fs.disp('*****开始模拟计算*****');
            totalCircle=app.TotalCircleEditField.Value;
            stepNum=app.StepNumEditField.Value;
            d.tic(totalCircle*stepNum);
            fName=['data/step/' B.name num2str(B.ballR) '-' num2str(B.distriRate) 'loopNum'];
            save([fName '0.mat']);
            for i=1:totalCircle
                for j=1:stepNum
                    d.toc();
                    d.balance('Standard',app.EachIterationNumEditField.Value);
                end
                d.clearData(1);%clear data in d.mo
                save([fName num2str(i) '.mat']);
                d.calculateData();
            end
            d.mo.setGPU('off');
            f.ChangePlottingAreaParent(app.Step3SimulationTab);
            f.ChangePlottingArea(app.UIAxes_PlottingArea4);
            d.show('Displacement');
            fs.disp('*****模拟计算已完成*****');
            save(['TempModel\',B.name,'3.mat'],'B','d');
            app.SaveresultButton.Enable='on';
            msgbox('模拟计算已完成');
        end

        % Button pushed function: ImportMaterialsButton
        function ImportMaterialsButtonPushed(app, event)
            fs.disp('*****开始导入材料*****');
            B=app.Box;
            d=app.DataCenter;
            UI_Material(d,B.ballR); %??MatDEM??????????
            fs.disp('*****材料已导入*****');
            app.Box=B;
            app.DataCenter=d;
            app.GiveMaterialsButton.Enable='on';
            msgbox('材料已导入, 请分层赋材料');
        end

        % Callback function

        % Button pushed function: GiveMaterialsButton
        function GiveMaterialsButtonPushed(app, event)
            fs.disp('*****开始分层赋材料*****');
            B=app.Box;
            d=app.DataCenter; %??MatDEM?????????GUIDE???????????f.ChangePlottingAreaParent?f.ChangePlottingArea????????
            PlottingAreaPosition=app.Settings.PlottingAreaPosition; %???????????????????
            app.Settings.PlottingAreaPosition=[]; %???????????????
            setappdata(0,'app',app); %????????app?
            d.GROUP=UI_Group(d); %??MatDEM????????????
            app.Settings.PlottingAreaPosition=PlottingAreaPosition; %?????????????
            setappdata(0,'app',app); %????????app?
            %             d.show('aMatId');
            f.ChangePlottingAreaParent(app.Step1SetMaterialsbyLayersTab);
            f.ChangePlottingArea(app.UIAxes_PlottingArea2);
            d.show('aMatId'  );
            fs.disp('*****分层赋材料已完成*****');
            app.Box=B;
            app.DataCenter=d;
            app.BegintoNaturalBalanceButton.Enable='on';
            msgbox('分层赋材料已完成, 请将岩土层重新固结');
        end

        % Close request function: GoafCollapse
        function GoafCollapseCloseRequest(app, event)
            delete(app)%????????WinMainCloseRequest?????????????????????
            try
                rmappdata(0,'app');%??????????????app?CurrentWindow?
                rmappdata(0,'CurrentWindow');
            catch%???????
            end
        end

        % Selection changed function: GeneratethelayersButtonGroup
        function GeneratethelayersButtonGroupSelectionChanged(app, event)
            if app.YesButton.Value==1
                app.ImportMaterialsButton.Enable='off';
                app.GeneratethelayersButton.Enable='on';
                msgbox('请在文本框中按从下向上的顺序依次输入各岩土层层底相对于模型箱底部的标高（单位为米，无需加单位）');
            elseif app.NoButton.Value==1
                app.GeneratethelayersButton.Enable='off';
                app.ImportMaterialsButton.Enable='on';
                msgbox('请导入材料及分层赋材料');
            end
        end

        % Button pushed function: GeneratethelayersButton
        function GeneratethelayersButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            LayerValue=app.Text_EditField.Value;
            LayerValue=str2num(LayerValue);
            ModelmZ = d.mo.aZ(1:d.mNum);
            app.OtherData.GroundLayer=max(LayerValue);
            if max(LayerValue)>max(ModelmZ)
                msgbox('输入最大值不应大于模型箱中样本高度' );
            elseif min(LayerValue)<0
                msgbox('输入最小值不应小于0');
            else
                [m,n]=size(LayerValue);
                X0=(1:1:B.sampleW);
                X0=X0.';
                Y0(B.sampleW,1)=0;
                for i=1:B.sampleW
                    Z0(i,:)=LayerValue;
                end
                XYZ0=[ ];
                for i=1:n
                    XYZ0(:,3*i-2)=X0;
                    XYZ0(:,3*i-1)=Y0;
                    XYZ0(:,3*i)=Z0(:,i);
                end
                clear ModelmZ;
                clear i;
                clear m;
                clear n;
                clear LayerValue;
                clear X0;
                clear Y0;
                clear Z0;
                app.OtherData.XYZ0=XYZ0;
                msgbox('层面数据已生成, 请保存层面数据 ');
            end
            app.SaveLayerButton.Enable='on';
        end

        % Value changing function: Text_EditField
        function Text_EditFieldValueChanging(app, event)
            B=app.Box;
            d=app.DataCenter;
            app.ThemaximumvalueshouldbelessthanLabel.Visible=1;
            ModelmZ = d.mo.aZ(1:d.mNum);
            LayerMax=max(ModelmZ);
            app.LayerMax_Label.Text = num2str(LayerMax-B.ballR);
        end

        % Button pushed function: BegintoNaturalBalanceButton
        function BegintoNaturalBalanceButtonPushed(app, event)
            fs.disp('*****开始固结*****');
            B=app.Box;
            d=app.DataCenter;
            B.setUIoutput();
            d.mo.setGPU('off');
            d.mo.bFilter(:)=true;
            d.deleteConnection('boundary');
            d.mo.zeroBalance();
            d.resetStatus();
            d.mo.isHeat=1;%calculate heat in the model
            d.setStandarddT();
            d.balance('Standard',app.NaturalbalanceEditField.Value);
            d.mo.setGPU('off');
            msgbox('固结完成，请前往步骤2：生成采空区');
            app.Box=B;
            app.DataCenter=d;
            app.GenerategoafmodelButton.Enable='on';
        end

        % Button pushed function: SaveLayerButton
        function SaveLayerButtonPushed(app, event)
            XYZ0=app.OtherData.XYZ0;
            [file,path]=uiputfile(['TempModel/Rock and soil layer','.txt']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'XYZ0','-ascii');
                fs.disp(['已保存层面数据',path,file]);
            end
            app.ImportMaterialsButton.Enable='on';
            msgbox('层面数据已保存, 请导入材料');
        end

        % Button pushed function: SaveresultButton
        function SaveresultButtonPushed(app, event)
            B=app.Box;
            d=app.DataCenter;
            d.clearData(1);
            [file,path]=uiputfile(['TempModel/',B.name,'3.mat']);
            if isequal(file,0)==false&&isequal(path,0)==false
                save([path,file],'B','d','-v7.3');
                fs.disp(['已保存计算结果',path,file]);
            end
            msgbox('结果已保存');
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create GoafCollapse and hide until all components are created
            app.GoafCollapse = uifigure('Visible', 'off');
            app.GoafCollapse.Position = [100 100 780 579];
            app.GoafCollapse.Name = '采空塌陷试验室';
            app.GoafCollapse.CloseRequestFcn = createCallbackFcn(app, @GoafCollapseCloseRequest, true);

            % Create TabGroup
            app.TabGroup = uitabgroup(app.GoafCollapse);
            app.TabGroup.Position = [2 147 780 418];

            % Create Step0InitialmodelTab
            app.Step0InitialmodelTab = uitab(app.TabGroup);
            app.Step0InitialmodelTab.Title = '步骤0:  初始模型箱';

            % Create Panel_2
            app.Panel_2 = uipanel(app.Step0InitialmodelTab);
            app.Panel_2.Position = [8 11 227 374];

            % Create InitialwidthEditFieldLabel
            app.InitialwidthEditFieldLabel = uilabel(app.Panel_2);
            app.InitialwidthEditFieldLabel.HorizontalAlignment = 'right';
            app.InitialwidthEditFieldLabel.Position = [45 342 65 22];
            app.InitialwidthEditFieldLabel.Text = '模型箱宽度';

            % Create InitialwidthEditField
            app.InitialwidthEditField = uieditfield(app.Panel_2, 'numeric');
            app.InitialwidthEditField.Position = [124 342 46 22];
            app.InitialwidthEditField.Value = 100;

            % Create InitialheightEditFieldLabel
            app.InitialheightEditFieldLabel = uilabel(app.Panel_2);
            app.InitialheightEditFieldLabel.HorizontalAlignment = 'right';
            app.InitialheightEditFieldLabel.Position = [40 313 70 22];
            app.InitialheightEditFieldLabel.Text = '模型箱高度';

            % Create InitialheightEditField
            app.InitialheightEditField = uieditfield(app.Panel_2, 'numeric');
            app.InitialheightEditField.Position = [124 313 46 22];
            app.InitialheightEditField.Value = 60;

            % Create ParticleradiusEditFieldLabel
            app.ParticleradiusEditFieldLabel = uilabel(app.Panel_2);
            app.ParticleradiusEditFieldLabel.HorizontalAlignment = 'right';
            app.ParticleradiusEditFieldLabel.Position = [30 281 82 22];
            app.ParticleradiusEditFieldLabel.Text = '单元半径';

            % Create ParticleradiusEditField
            app.ParticleradiusEditField = uieditfield(app.Panel_2, 'numeric');
            app.ParticleradiusEditField.Position = [124 281 46 22];
            app.ParticleradiusEditField.Value = 1;

            % Create DistriRateEditFieldLabel
            app.DistriRateEditFieldLabel = uilabel(app.Panel_2);
            app.DistriRateEditFieldLabel.HorizontalAlignment = 'right';
            app.DistriRateEditFieldLabel.Position = [52 250 58 22];
            app.DistriRateEditFieldLabel.Text = '分散系数';

            % Create DistriRateEditField
            app.DistriRateEditField = uieditfield(app.Panel_2, 'numeric');
            app.DistriRateEditField.Position = [124 250 46 22];
            app.DistriRateEditField.Value = 0.2;

            % Create GenerateinitialmodelButton
            app.GenerateinitialmodelButton = uibutton(app.Panel_2, 'push');
            app.GenerateinitialmodelButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateinitialmodelButtonPushed, true);
            app.GenerateinitialmodelButton.VerticalAlignment = 'top';
            app.GenerateinitialmodelButton.Position = [50 157 132 22];
            app.GenerateinitialmodelButton.Text = '生成初始模型箱';

            % Create RandSeedEditFieldLabel
            app.RandSeedEditFieldLabel = uilabel(app.Panel_2);
            app.RandSeedEditFieldLabel.HorizontalAlignment = 'right';
            app.RandSeedEditFieldLabel.Position = [50 217 62 22];
            app.RandSeedEditFieldLabel.Text = '随机种子';

            % Create RandSeedEditField
            app.RandSeedEditField = uieditfield(app.Panel_2, 'numeric');
            app.RandSeedEditField.Position = [124 217 46 22];
            app.RandSeedEditField.Value = 1;

            % Create GravitySedimentEditFieldLabel
            app.GravitySedimentEditFieldLabel = uilabel(app.Panel_2);
            app.GravitySedimentEditFieldLabel.HorizontalAlignment = 'right';
            app.GravitySedimentEditFieldLabel.Position = [28 106 94 22];
            app.GravitySedimentEditFieldLabel.Text = '沉积';

            % Create GravitySedimentEditField
            app.GravitySedimentEditField = uieditfield(app.Panel_2, 'numeric');
            app.GravitySedimentEditField.Position = [128 106 51 22];
            app.GravitySedimentEditField.Value = 0.01;

            % Create CompactSampleEditFieldLabel
            app.CompactSampleEditFieldLabel = uilabel(app.Panel_2);
            app.CompactSampleEditFieldLabel.HorizontalAlignment = 'right';
            app.CompactSampleEditFieldLabel.Position = [29 36 94 22];
            app.CompactSampleEditFieldLabel.Text = '压实';

            % Create CompactSampleEditField
            app.CompactSampleEditField = uieditfield(app.Panel_2, 'numeric');
            app.CompactSampleEditField.Position = [129 36 49 22];
            app.CompactSampleEditField.Value = 0.0001;

            % Create BegintosedimentateButton
            app.BegintosedimentateButton = uibutton(app.Panel_2, 'push');
            app.BegintosedimentateButton.ButtonPushedFcn = createCallbackFcn(app, @BegintosedimentateButtonPushed, true);
            app.BegintosedimentateButton.VerticalAlignment = 'top';
            app.BegintosedimentateButton.Enable = 'off';
            app.BegintosedimentateButton.Position = [51 76 128 22];
            app.BegintosedimentateButton.Text = '开始沉积';

            % Create BegintoCompactButton
            app.BegintoCompactButton = uibutton(app.Panel_2, 'push');
            app.BegintoCompactButton.ButtonPushedFcn = createCallbackFcn(app, @BegintoCompactButtonPushed, true);
            app.BegintoCompactButton.VerticalAlignment = 'top';
            app.BegintoCompactButton.Enable = 'off';
            app.BegintoCompactButton.Position = [59 9 111 22];
            app.BegintoCompactButton.Text = '开始压实';

            % Create mLabel
            app.mLabel = uilabel(app.Panel_2);
            app.mLabel.Position = [170 342 12 22];
            app.mLabel.Text = 'm';

            % Create mLabel_2
            app.mLabel_2 = uilabel(app.Panel_2);
            app.mLabel_2.Position = [170 312 12 22];
            app.mLabel_2.Text = 'm';

            % Create mLabel_3
            app.mLabel_3 = uilabel(app.Panel_2);
            app.mLabel_3.Position = [170 280 12 22];
            app.mLabel_3.Text = 'm';

            % Create timesLabel
            app.timesLabel = uilabel(app.Panel_2);
            app.timesLabel.Position = [178 106 34 22];
            app.timesLabel.Text = '次';

            % Create timesLabel_2
            app.timesLabel_2 = uilabel(app.Panel_2);
            app.timesLabel_2.Position = [177 36 34 22];
            app.timesLabel_2.Text = '次';

            % Create NameofModelEditFieldLabel
            app.NameofModelEditFieldLabel = uilabel(app.Panel_2);
            app.NameofModelEditFieldLabel.HorizontalAlignment = 'right';
            app.NameofModelEditFieldLabel.Position = [7 186 87 22];
            app.NameofModelEditFieldLabel.Text = '模型名称';

            % Create NameofModelEditField
            app.NameofModelEditField = uieditfield(app.Panel_2, 'text');
            app.NameofModelEditField.HorizontalAlignment = 'center';
            app.NameofModelEditField.Position = [102 186 118 22];
            app.NameofModelEditField.Value = 'Goaf_Collapse';

            % Create UIAxes_PlottingArea1
            app.UIAxes_PlottingArea1 = uiaxes(app.Step0InitialmodelTab);
            title(app.UIAxes_PlottingArea1, '绘图区')
            xlabel(app.UIAxes_PlottingArea1, 'X')
            ylabel(app.UIAxes_PlottingArea1, 'Y')
            app.UIAxes_PlottingArea1.PlotBoxAspectRatio = [1.62365591397849 1 1];
            app.UIAxes_PlottingArea1.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea1.Position = [242 21 531 353];

            % Create Step1SetMaterialsbyLayersTab
            app.Step1SetMaterialsbyLayersTab = uitab(app.TabGroup);
            app.Step1SetMaterialsbyLayersTab.Title = '步骤1: 设置层面和材料';

            % Create GeneratethelayersButtonGroup
            app.GeneratethelayersButtonGroup = uibuttongroup(app.Step1SetMaterialsbyLayersTab);
            app.GeneratethelayersButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @GeneratethelayersButtonGroupSelectionChanged, true);
            app.GeneratethelayersButtonGroup.Title = '是否需要生成层面数据';
            app.GeneratethelayersButtonGroup.Position = [14 318 265 75];

            % Create YesButton
            app.YesButton = uiradiobutton(app.GeneratethelayersButtonGroup);
            app.YesButton.Text = '是';
            app.YesButton.Position = [104 26 58 22];

            % Create NoButton
            app.NoButton = uiradiobutton(app.GeneratethelayersButtonGroup);
            app.NoButton.Text = '否';
            app.NoButton.Position = [105 1 65 22];
            app.NoButton.Value = true;

            % Create PleaseenterthelayerpositioninturnPanel
            app.PleaseenterthelayerpositioninturnPanel = uipanel(app.Step1SetMaterialsbyLayersTab);
            app.PleaseenterthelayerpositioninturnPanel.Title = '请依次输入层底标高';
            app.PleaseenterthelayerpositioninturnPanel.Position = [14 192 265 114];

            % Create GeneratethelayersButton
            app.GeneratethelayersButton = uibutton(app.PleaseenterthelayerpositioninturnPanel, 'push');
            app.GeneratethelayersButton.ButtonPushedFcn = createCallbackFcn(app, @GeneratethelayersButtonPushed, true);
            app.GeneratethelayersButton.Enable = 'off';
            app.GeneratethelayersButton.Position = [5 3 121 22];
            app.GeneratethelayersButton.Text = '生成层面数据';

            % Create Text_EditField
            app.Text_EditField = uieditfield(app.PleaseenterthelayerpositioninturnPanel, 'text');
            app.Text_EditField.ValueChangingFcn = createCallbackFcn(app, @Text_EditFieldValueChanging, true);
            app.Text_EditField.FontSize = 15;
            app.Text_EditField.FontWeight = 'bold';
            app.Text_EditField.Position = [5 55 260 37];
            app.Text_EditField.Value = '0,7,17,24,28,31,48,49,54.5,59,61';

            % Create LayerMax_Label
            app.LayerMax_Label = uilabel(app.PleaseenterthelayerpositioninturnPanel);
            app.LayerMax_Label.Position = [90 33 25 22];
            app.LayerMax_Label.Text = '';

            % Create ThemaximumvalueshouldbelessthanLabel
            app.ThemaximumvalueshouldbelessthanLabel = uilabel(app.PleaseenterthelayerpositioninturnPanel);
            app.ThemaximumvalueshouldbelessthanLabel.Visible = 'off';
            app.ThemaximumvalueshouldbelessthanLabel.Position = [5 33 229 22];
            app.ThemaximumvalueshouldbelessthanLabel.Text = '最大值应小于： ';

            % Create SaveLayerButton
            app.SaveLayerButton = uibutton(app.PleaseenterthelayerpositioninturnPanel, 'push');
            app.SaveLayerButton.ButtonPushedFcn = createCallbackFcn(app, @SaveLayerButtonPushed, true);
            app.SaveLayerButton.Enable = 'off';
            app.SaveLayerButton.Position = [141 3 100 22];
            app.SaveLayerButton.Text = '保存层面数据';

            % Create SetMaterialsbyLayersPanel
            app.SetMaterialsbyLayersPanel = uipanel(app.Step1SetMaterialsbyLayersTab);
            app.SetMaterialsbyLayersPanel.Title = '分层赋材料';
            app.SetMaterialsbyLayersPanel.Position = [14 122 265 59];

            % Create ImportMaterialsButton
            app.ImportMaterialsButton = uibutton(app.SetMaterialsbyLayersPanel, 'push');
            app.ImportMaterialsButton.ButtonPushedFcn = createCallbackFcn(app, @ImportMaterialsButtonPushed, true);
            app.ImportMaterialsButton.Enable = 'off';
            app.ImportMaterialsButton.Position = [14 5 101 22];
            app.ImportMaterialsButton.Text = '导入材料';

            % Create GiveMaterialsButton
            app.GiveMaterialsButton = uibutton(app.SetMaterialsbyLayersPanel, 'push');
            app.GiveMaterialsButton.ButtonPushedFcn = createCallbackFcn(app, @GiveMaterialsButtonPushed, true);
            app.GiveMaterialsButton.Enable = 'off';
            app.GiveMaterialsButton.Position = [159 5 100 22];
            app.GiveMaterialsButton.Text = '开始分层赋材料';

            % Create UIAxes_PlottingArea2
            app.UIAxes_PlottingArea2 = uiaxes(app.Step1SetMaterialsbyLayersTab);
            title(app.UIAxes_PlottingArea2, '绘图区')
            xlabel(app.UIAxes_PlottingArea2, 'X')
            ylabel(app.UIAxes_PlottingArea2, 'Y')
            app.UIAxes_PlottingArea2.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea2.Position = [282 53 485 314];

            % Create NaturalbalancePanel
            app.NaturalbalancePanel = uipanel(app.Step1SetMaterialsbyLayersTab);
            app.NaturalbalancePanel.Title = '固结';
            app.NaturalbalancePanel.Position = [14 11 263 102];

            % Create NaturalbalanceEditFieldLabel
            app.NaturalbalanceEditFieldLabel = uilabel(app.NaturalbalancePanel);
            app.NaturalbalanceEditFieldLabel.HorizontalAlignment = 'right';
            app.NaturalbalanceEditFieldLabel.Position = [11 47 90 22];
            app.NaturalbalanceEditFieldLabel.Text = '固结';

            % Create NaturalbalanceEditField
            app.NaturalbalanceEditField = uieditfield(app.NaturalbalancePanel, 'numeric');
            app.NaturalbalanceEditField.Position = [103 47 29 22];
            app.NaturalbalanceEditField.Value = 1;

            % Create timesLabel_3
            app.timesLabel_3 = uilabel(app.NaturalbalancePanel);
            app.timesLabel_3.Position = [133 47 34 22];
            app.timesLabel_3.Text = '次';

            % Create BegintoNaturalBalanceButton
            app.BegintoNaturalBalanceButton = uibutton(app.NaturalbalancePanel, 'push');
            app.BegintoNaturalBalanceButton.ButtonPushedFcn = createCallbackFcn(app, @BegintoNaturalBalanceButtonPushed, true);
            app.BegintoNaturalBalanceButton.Enable = 'off';
            app.BegintoNaturalBalanceButton.Position = [108 8 148 22];
            app.BegintoNaturalBalanceButton.Text = '开始固结';

            % Create Step2GoafmodelTab
            app.Step2GoafmodelTab = uitab(app.TabGroup);
            app.Step2GoafmodelTab.Title = '步骤2：生成采空区';

            % Create Panel_3
            app.Panel_3 = uipanel(app.Step2GoafmodelTab);
            app.Panel_3.Position = [8 13 261 372];

            % Create GoafheightSliderLabel
            app.GoafheightSliderLabel = uilabel(app.Panel_3);
            app.GoafheightSliderLabel.HorizontalAlignment = 'right';
            app.GoafheightSliderLabel.Position = [14 341 67 22];
            app.GoafheightSliderLabel.Text = '采空区高度';

            % Create GoafheightSlider
            app.GoafheightSlider = uislider(app.Panel_3);
            app.GoafheightSlider.Limits = [6 12];
            app.GoafheightSlider.MajorTicks = [6 7 8 9 10 11 12];
            app.GoafheightSlider.MinorTicks = [6 7 8 9 10 11 12];
            app.GoafheightSlider.Position = [102 350 130 3];
            app.GoafheightSlider.Value = 12;

            % Create GoafwidthSliderLabel
            app.GoafwidthSliderLabel = uilabel(app.Panel_3);
            app.GoafwidthSliderLabel.HorizontalAlignment = 'right';
            app.GoafwidthSliderLabel.Position = [13 265 66 22];
            app.GoafwidthSliderLabel.Text = '采空区宽度';

            % Create GoafwidthSlider
            app.GoafwidthSlider = uislider(app.Panel_3);
            app.GoafwidthSlider.Limits = [6 12];
            app.GoafwidthSlider.MajorTicks = [6 7 8 9 10 11 12];
            app.GoafwidthSlider.MinorTicks = [6 7 8 9 10 11 12];
            app.GoafwidthSlider.Position = [102 275 130 3];
            app.GoafwidthSlider.Value = 12;

            % Create PillarwidthSliderLabel
            app.PillarwidthSliderLabel = uilabel(app.Panel_3);
            app.PillarwidthSliderLabel.HorizontalAlignment = 'right';
            app.PillarwidthSliderLabel.Position = [16 185 63 22];
            app.PillarwidthSliderLabel.Text = '矿柱宽度';

            % Create PillarwidthSlider
            app.PillarwidthSlider = uislider(app.Panel_3);
            app.PillarwidthSlider.Limits = [4 10];
            app.PillarwidthSlider.MajorTicks = [4 5 6 7 8 9 10];
            app.PillarwidthSlider.MinorTicks = [4 5 6 7 8 9 10];
            app.PillarwidthSlider.Position = [102 194 130 3];
            app.PillarwidthSlider.Value = 10;

            % Create RoofthicknessSliderLabel
            app.RoofthicknessSliderLabel = uilabel(app.Panel_3);
            app.RoofthicknessSliderLabel.HorizontalAlignment = 'right';
            app.RoofthicknessSliderLabel.Position = [6 115 87 22];
            app.RoofthicknessSliderLabel.Text = '顶板厚度';

            % Create RoofthicknessSlider
            app.RoofthicknessSlider = uislider(app.Panel_3);
            app.RoofthicknessSlider.Limits = [0 3];
            app.RoofthicknessSlider.MinorTicks = [0 1 2 3];
            app.RoofthicknessSlider.Position = [104 125 130 3];
            app.RoofthicknessSlider.Value = 3;

            % Create GenerategoafmodelButton
            app.GenerategoafmodelButton = uibutton(app.Panel_3, 'push');
            app.GenerategoafmodelButton.ButtonPushedFcn = createCallbackFcn(app, @GenerategoafmodelButtonPushed, true);
            app.GenerategoafmodelButton.Enable = 'off';
            app.GenerategoafmodelButton.Position = [64 26 128 22];
            app.GenerategoafmodelButton.Text = '开始生成采空区';

            % Create UIAxes_PlottingArea3
            app.UIAxes_PlottingArea3 = uiaxes(app.Step2GoafmodelTab);
            title(app.UIAxes_PlottingArea3, '绘图区')
            xlabel(app.UIAxes_PlottingArea3, 'X')
            ylabel(app.UIAxes_PlottingArea3, 'Y')
            app.UIAxes_PlottingArea3.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea3.Position = [279 39 491 337];

            % Create Step3SimulationTab
            app.Step3SimulationTab = uitab(app.TabGroup);
            app.Step3SimulationTab.Title = '步骤3：模拟计算';

            % Create Panel
            app.Panel = uipanel(app.Step3SimulationTab);
            app.Panel.Position = [8 17 222 368];

            % Create TotalCircleEditFieldLabel
            app.TotalCircleEditFieldLabel = uilabel(app.Panel);
            app.TotalCircleEditFieldLabel.HorizontalAlignment = 'right';
            app.TotalCircleEditFieldLabel.Position = [1 325 69 22];
            app.TotalCircleEditFieldLabel.Text = '保存次数';

            % Create TotalCircleEditField
            app.TotalCircleEditField = uieditfield(app.Panel, 'numeric');
            app.TotalCircleEditField.Position = [78 325 34 22];
            app.TotalCircleEditField.Value = 1;

            % Create StepNumEditFieldLabel
            app.StepNumEditFieldLabel = uilabel(app.Panel);
            app.StepNumEditFieldLabel.HorizontalAlignment = 'right';
            app.StepNumEditFieldLabel.Position = [15 245 55 22];
            app.StepNumEditFieldLabel.Text = '循环步数';

            % Create StepNumEditField
            app.StepNumEditField = uieditfield(app.Panel, 'numeric');
            app.StepNumEditField.Position = [78 245 34 22];
            app.StepNumEditField.Value = 1;

            % Create EachIterationNumEditFieldLabel
            app.EachIterationNumEditFieldLabel = uilabel(app.Panel);
            app.EachIterationNumEditFieldLabel.HorizontalAlignment = 'right';
            app.EachIterationNumEditFieldLabel.Position = [3 167 108 22];
            app.EachIterationNumEditFieldLabel.Text = '每步标准平衡次数';

            % Create EachIterationNumEditField
            app.EachIterationNumEditField = uieditfield(app.Panel, 'numeric');
            app.EachIterationNumEditField.Position = [110 166 40 22];
            app.EachIterationNumEditField.Value = 1e-05;

            % Create BegintosimulateButton
            app.BegintosimulateButton = uibutton(app.Panel, 'push');
            app.BegintosimulateButton.ButtonPushedFcn = createCallbackFcn(app, @BegintosimulateButtonPushed, true);
            app.BegintosimulateButton.Enable = 'off';
            app.BegintosimulateButton.Position = [57 97 108 22];
            app.BegintosimulateButton.Text = '开始模拟计算';

            % Create timesLabel_4
            app.timesLabel_4 = uilabel(app.Panel);
            app.timesLabel_4.Position = [116 326 34 22];
            app.timesLabel_4.Text = '次';

            % Create timesLabel_5
            app.timesLabel_5 = uilabel(app.Panel);
            app.timesLabel_5.Position = [116 245 34 22];
            app.timesLabel_5.Text = '次';

            % Create timesLabel_6
            app.timesLabel_6 = uilabel(app.Panel);
            app.timesLabel_6.Position = [149 166 30 22];
            app.timesLabel_6.Text = '次';

            % Create SaveresultButton
            app.SaveresultButton = uibutton(app.Panel, 'push');
            app.SaveresultButton.ButtonPushedFcn = createCallbackFcn(app, @SaveresultButtonPushed, true);
            app.SaveresultButton.Enable = 'off';
            app.SaveresultButton.Position = [57 30 100 22];
            app.SaveresultButton.Text = '保存结果';

            % Create UIAxes_PlottingArea4
            app.UIAxes_PlottingArea4 = uiaxes(app.Step3SimulationTab);
            title(app.UIAxes_PlottingArea4, '绘图区')
            xlabel(app.UIAxes_PlottingArea4, 'X')
            ylabel(app.UIAxes_PlottingArea4, 'Y')
            app.UIAxes_PlottingArea4.PlotBoxAspectRatio = [1.53887399463807 1 1];
            app.UIAxes_PlottingArea4.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea4.Position = [241 47 528 326];

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.GoafCollapse);
            app.TextArea_Message.Position = [2 34 779 114];

            % Show the figure after all components are created
            app.GoafCollapse.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GoafCollapse_lab_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.GoafCollapse)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.GoafCollapse)
        end
    end
end