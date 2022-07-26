classdef TwoBalls_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TwoballsUIFigure  matlab.ui.Figure
        TwoballsButton    matlab.ui.control.Button
        TypeButtonGroup   matlab.ui.container.ButtonGroup
        ballR01Button     matlab.ui.control.RadioButton
        ballR20Button     matlab.ui.control.RadioButton
        Thisappisbasedthecodefileexamplesuser_TwoBallsmLabel  matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: TwoballsButton
        function TwoballsButtonPushed(app, event)
            %This
            %-----parameters-----
            if app.ballR01Button.Value==true
                diameter=0.1;visRate=0.1;%Figure 1.3-2
            else
                diameter=20;visRate=0;%Figure 5.4-1
            end
            r=diameter/2;%ball radius
            d=build();
            d.name='TwoBalls';
            %-----define struct data of model and boundary-----
            moObj.X=[0;0];moObj.Y=[0;0];moObj.Z=diameter*[1;3];
            moObj.R=r*[1;1];
            boObj.X=[0;0];boObj.Y=[0;0];boObj.Z=diameter*[0;4];
            boObj.R=r*[1;1];
            %-----define material-----
            ballMat=material('ball');
            ballMat.setMaterial(7e6,0.15,1.5e5,1e6,1,diameter,1500);
            d.addMaterial(ballMat);
            %-----initialize d-----
            d.aX=[moObj.X;boObj.X;boObj.X(end)];%add a virtual element
            d.aY=[moObj.Y;boObj.Y;boObj.Y(end)];
            d.aZ=[moObj.Z;boObj.Z;boObj.Z(end)];
            d.aR=[moObj.R;boObj.R;boObj.R(end)/4];
            d.vRate=visRate;%rate of viscosity (0-1)
            d.aNum=length(d.aR);d.mNum=length(moObj.R);
            d.aMatId=ones(size(d.aR))*ballMat.Id;
            d.g=-9.8;%gravity acceleration
            d.setBuild();
            %-----define boundary groups-----
            d.GROUP.lefB=[];d.GROUP.rigB=[];
            d.GROUP.froB=[];d.GROUP.bacB=[];
            d.GROUP.botB=3;d.GROUP.topB=4;
            %-----initialize d.mo-----
            d.setModel();
            d.mo.isHeat=1;
            %-----numerical simulation-----
            d.balance(1,800);
            d.showB=2;
            d.show();
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TwoballsUIFigure and hide until all components are created
            app.TwoballsUIFigure = uifigure('Visible', 'off');
            app.TwoballsUIFigure.Position = [100 100 225 201];
            app.TwoballsUIFigure.Name = 'Two balls';

            % Create TwoballsButton
            app.TwoballsButton = uibutton(app.TwoballsUIFigure, 'push');
            app.TwoballsButton.ButtonPushedFcn = createCallbackFcn(app, @TwoballsButtonPushed, true);
            app.TwoballsButton.Position = [14 73 200 22];
            app.TwoballsButton.Text = 'Two balls';

            % Create TypeButtonGroup
            app.TypeButtonGroup = uibuttongroup(app.TwoballsUIFigure);
            app.TypeButtonGroup.Title = 'Type';
            app.TypeButtonGroup.Position = [14 110 200 76];

            % Create ballR01Button
            app.ballR01Button = uiradiobutton(app.TypeButtonGroup);
            app.ballR01Button.Text = 'ballR:0.1; visRate=0.1';
            app.ballR01Button.Position = [11 30 177 22];
            app.ballR01Button.Value = true;

            % Create ballR20Button
            app.ballR20Button = uiradiobutton(app.TypeButtonGroup);
            app.ballR20Button.Text = 'ballR:20; visRate=0';
            app.ballR20Button.Position = [11 8 126 22];

            % Create Thisappisbasedthecodefileexamplesuser_TwoBallsmLabel
            app.Thisappisbasedthecodefileexamplesuser_TwoBallsmLabel = uilabel(app.TwoballsUIFigure);
            app.Thisappisbasedthecodefileexamplesuser_TwoBallsmLabel.Position = [14 20 200 45];
            app.Thisappisbasedthecodefileexamplesuser_TwoBallsmLabel.Text = {'This app is based the code file '; '''examples/user_TwoBalls.m'''};

            % Show the figure after all components are created
            app.TwoballsUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TwoBalls_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TwoballsUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TwoballsUIFigure)
        end
    end
end