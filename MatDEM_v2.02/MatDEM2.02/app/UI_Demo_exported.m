classdef UI_Demo_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure_WinMain      matlab.ui.Figure
        UIAxes_PlottingArea   matlab.ui.control.UIAxes
        Label                 matlab.ui.control.Label
        EditField_TubeRadius  matlab.ui.control.NumericEditField
        Label_2               matlab.ui.control.Label
        EditField_TubeLength  matlab.ui.control.NumericEditField
        Label_3               matlab.ui.control.Label
        EditField_BallRadius  matlab.ui.control.NumericEditField
        Button_Generate       matlab.ui.control.Button
        TextArea_Message      matlab.ui.control.TextArea
    end
    
    properties (Access = public)
        Settings;
    end

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Settings.OutputFocus=app.TextArea_Message;
            setappdata(0,'app',app);
            setappdata(0,'CurrentWindow',1);
            
            axis(app.UIAxes_PlottingArea,'equal');
            box(app.UIAxes_PlottingArea,'on');
            grid(app.UIAxes_PlottingArea,'on');
        end

        % Close request function: UIFigure_WinMain
        function UIFigure_WinMainCloseRequest(app, event)
            delete(app)
            try
                rmappdata(0,'app');
                rmappdata(0,'CurrentWindow');
            catch
                %不做任何处理。
            end
        end

        % Button pushed function: Button_Generate
        function Button_GenerateButtonPushed(app, event)
            tube=mfs.makeTube2(app.EditField_TubeRadius.Value,app.EditField_TubeLength.Value,app.EditField_BallRadius.Value);
            tube=mfs.rotate(tube,'XZ',90);
            fs.showObj2(app.UIAxes_PlottingArea,tube);
            fs.disp(['已生成 半径 = ',num2str(app.EditField_TubeRadius.Value),' ， 长度 = ',num2str(app.EditField_TubeLength.Value),' 的管道。']);
        end
    end

    % App initialization and construction
    methods (Access = private)
        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure_WinMain
            app.UIFigure_WinMain = uifigure;
            app.UIFigure_WinMain.Position = [100 100 640 480];
            app.UIFigure_WinMain.Name = 'Generate a Tube';
            app.UIFigure_WinMain.Resize = 'off';
            app.UIFigure_WinMain.CloseRequestFcn = createCallbackFcn(app, @UIFigure_WinMainCloseRequest, true);

            % Create UIAxes_PlottingArea
            app.UIAxes_PlottingArea = uiaxes(app.UIFigure_WinMain);
            title(app.UIAxes_PlottingArea, '绘图区')
            xlabel(app.UIAxes_PlottingArea, 'X')
            ylabel(app.UIAxes_PlottingArea, 'Y')
            app.UIAxes_PlottingArea.TitleFontWeight = 'bold';
            app.UIAxes_PlottingArea.Position = [31 151 580 300];

            % Create Label
            app.Label = uilabel(app.UIFigure_WinMain);
            app.Label.HorizontalAlignment = 'right';
            app.Label.Position = [31 119 29 22];
            app.Label.Text = '管径';

            % Create EditField_TubeRadius
            app.EditField_TubeRadius = uieditfield(app.UIFigure_WinMain, 'numeric');
            app.EditField_TubeRadius.Position = [75 119 100 22];
            app.EditField_TubeRadius.Value = 5;

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure_WinMain);
            app.Label_2.HorizontalAlignment = 'right';
            app.Label_2.Position = [181 119 29 22];
            app.Label_2.Text = '管长';

            % Create EditField_TubeLength
            app.EditField_TubeLength = uieditfield(app.UIFigure_WinMain, 'numeric');
            app.EditField_TubeLength.Position = [225 119 100 22];
            app.EditField_TubeLength.Value = 20;

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure_WinMain);
            app.Label_3.HorizontalAlignment = 'right';
            app.Label_3.Position = [331 119 53 22];
            app.Label_3.Text = '单元半径';

            % Create EditField_BallRadius
            app.EditField_BallRadius = uieditfield(app.UIFigure_WinMain, 'numeric');
            app.EditField_BallRadius.Position = [399 119 100 22];
            app.EditField_BallRadius.Value = 0.5;

            % Create Button_Generate
            app.Button_Generate = uibutton(app.UIFigure_WinMain, 'push');
            app.Button_Generate.ButtonPushedFcn = createCallbackFcn(app, @Button_GenerateButtonPushed, true);
            app.Button_Generate.Position = [511 118 100 24];
            app.Button_Generate.Text = '生成';

            % Create TextArea_Message
            app.TextArea_Message = uitextarea(app.UIFigure_WinMain);
            app.TextArea_Message.Position = [31 31 580 80];
        end
    end

    methods (Access = public)

        % Construct app
        function app = UI_Demo_exported

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure_WinMain)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure_WinMain)
        end
    end
end