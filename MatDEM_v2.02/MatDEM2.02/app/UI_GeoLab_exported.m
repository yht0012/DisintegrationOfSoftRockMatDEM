classdef UI_GeoLab < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        GeoLabsUIFigure  matlab.ui.Figure
        Image6           matlab.ui.control.Image
        Image5           matlab.ui.control.Image
        AppsPanel        matlab.ui.container.Panel
        Image1           matlab.ui.control.Image
        Image2           matlab.ui.control.Image
        Image3           matlab.ui.control.Image
        Image4           matlab.ui.control.Image
        Button_4         matlab.ui.control.Button
        Button_3         matlab.ui.control.Button
        Button_1         matlab.ui.control.Button
        Button_2         matlab.ui.control.Button
    end

       
    properties (Access = public)
        Settings % Description
        appFileNames % Description
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            ufs.setIconApp(app.GeoLabsUIFigure,'Resources/MatDEMlogo.ico');
            app.appFileNames{1}='app/UI_Slope3D_exported.m';
            app.appFileNames{2}='app/UI_SlopeNet_exported.m';
            app.appFileNames{3}='app/UI_collapse_exported.m';
            app.appFileNames{4}='app/UI_LandSubsidence_exported.m'; 
            app.Image1.ImageSource='Resources/slope1.png';
            app.Image2.ImageSource='Resources/slopeNet1.png';
            app.Image3.ImageSource='Resources/tunnel.png';
            app.Image4.ImageSource='Resources/landSubsidence.png';
            app.Image5.ImageSource='Resources/GeoLabs.png';
            app.Image6.ImageSource='Resources/background.jpg';
        end

        % Image clicked function: Image1
        function Image1Clicked(app, event)
            fName=app.appFileNames{1};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Button pushed function: Button_1
        function Button_1Pushed(app, event)
            fName=app.appFileNames{1};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Image clicked function: Image2
        function Image2Clicked(app, event)
            fName=app.appFileNames{2};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
            fName=app.appFileNames{2};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Image clicked function: Image3
        function Image3Clicked(app, event)
            fName=app.appFileNames{3};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
            fName=app.appFileNames{3};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Image clicked function: Image4
        function Image4Clicked(app, event)
            fName=app.appFileNames{4};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
            fName=app.appFileNames{4};
            delete(app.GeoLabsUIFigure);
            f.runWinApp(fName,true);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create GeoLabsUIFigure and hide until all components are created
            app.GeoLabsUIFigure = uifigure('Visible', 'off');
            app.GeoLabsUIFigure.Position = [100 100 788 592];
            app.GeoLabsUIFigure.Name = 'µØÖÊÔÖº¦ÊÔÑéÊÒ£¨GeoLabs£©²âÊÔ°æ0.6';
            app.GeoLabsUIFigure.Resize = 'off';

            % Create Image6
            app.Image6 = uiimage(app.GeoLabsUIFigure);
            app.Image6.Position = [-7 146 804 447];
            app.Image6.ImageSource = 'background.jpg';

            % Create Image5
            app.Image5 = uiimage(app.GeoLabsUIFigure);
            app.Image5.BackgroundColor = [1 1 1];
            app.Image5.Position = [0 524 237 69];
            app.Image5.ImageSource = 'GeoLabs.png';

            % Create AppsPanel
            app.AppsPanel = uipanel(app.GeoLabsUIFigure);
            app.AppsPanel.ForegroundColor = [0.0745 0.6235 1];
            app.AppsPanel.BorderType = 'none';
            app.AppsPanel.Title = 'Apps';
            app.AppsPanel.BackgroundColor = [0.9608 0.9608 0.9608];
            app.AppsPanel.Position = [1 3 790 210];

            % Create Image1
            app.Image1 = uiimage(app.AppsPanel);
            app.Image1.ImageClickedFcn = createCallbackFcn(app, @Image1Clicked, true);
            app.Image1.BackgroundColor = [0 0.4471 0.7412];
            app.Image1.Position = [16 38 177 143];
            app.Image1.ImageSource = 'slope1.png';

            % Create Image2
            app.Image2 = uiimage(app.AppsPanel);
            app.Image2.ImageClickedFcn = createCallbackFcn(app, @Image2Clicked, true);
            app.Image2.BackgroundColor = [0 0.4471 0.7412];
            app.Image2.Position = [220 38 164 143];
            app.Image2.ImageSource = 'slopeNet1.png';

            % Create Image3
            app.Image3 = uiimage(app.AppsPanel);
            app.Image3.ImageClickedFcn = createCallbackFcn(app, @Image3Clicked, true);
            app.Image3.BackgroundColor = [0 0.4471 0.7412];
            app.Image3.Position = [413 38 168 143];
            app.Image3.ImageSource = 'tunnel.png';

            % Create Image4
            app.Image4 = uiimage(app.AppsPanel);
            app.Image4.ImageClickedFcn = createCallbackFcn(app, @Image4Clicked, true);
            app.Image4.BackgroundColor = [0 0.4471 0.7412];
            app.Image4.Position = [610 38 164 143];
            app.Image4.ImageSource = 'landSubsidence.png';

            % Create Button_4
            app.Button_4 = uibutton(app.AppsPanel, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.BackgroundColor = [0.902 0.949 1];
            app.Button_4.Position = [605 6 174 24];
            app.Button_4.Text = 'µØÃæ³Á½µÊÔÑéÊÒ';

            % Create Button_3
            app.Button_3 = uibutton(app.AppsPanel, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.BackgroundColor = [0.902 0.949 1];
            app.Button_3.Position = [410 6 174 24];
            app.Button_3.Text = '²É¿ÕËúÏÝÊÔÑéÊÒ';

            % Create Button_1
            app.Button_1 = uibutton(app.AppsPanel, 'push');
            app.Button_1.ButtonPushedFcn = createCallbackFcn(app, @Button_1Pushed, true);
            app.Button_1.BackgroundColor = [0.902 0.949 1];
            app.Button_1.Position = [19 6 174 24];
            app.Button_1.Text = '»¬ÆÂÔÖº¦ÊÔÑéÊÒ';

            % Create Button_2
            app.Button_2 = uibutton(app.AppsPanel, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.BackgroundColor = [0.902 0.949 1];
            app.Button_2.Position = [215 6 174 24];
            app.Button_2.Text = 'ÈáÐÔ·À»¤µ²ÍøÊÔÑéÊÒ';

            % Show the figure after all components are created
            app.GeoLabsUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_GeoLab

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.GeoLabsUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.GeoLabsUIFigure)
        end
    end
end