classdef UI_Function2Object_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        Function2ObjectUIFigure  matlab.ui.Figure
        CreateModelButton        matlab.ui.control.Button
        MessageTextArea          matlab.ui.control.TextArea
        NameLabel                matlab.ui.control.Label
    end

    
    properties (Access = public)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%make sure Access=public
        Settings;%%%%%%%%%%%%%%%%%%%%%%add a Settings, the ufs.setUIoutputApp command requires the property
        Box %%%%%%%%%%%%%%%%%%%%%%add a Box property, B is recorded here, used in the menu of MatDEM
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            fileName='app/UI_Function2Object.mat';%the file generated by user_Function2ObjLang defines the characters of UI
            ufs.setUIText(app,fileName);%set the UI characters
            ufs.setUIoutputApp(app,app.MessageTextArea);%set the output text area
            ufs.setIconApp(app.Function2ObjectUIFigure,'Resources/MatDEMlogo.ico');%set the logo
        end

        % Button pushed function: CreateModelButton
        function CreateModelButtonPushed(app, event)
            %�������������������������������
            %using functions to build objects, modify and import objects
            a1=f.run('examples/funtest.m',1,2,3);%sum of 1,2,3, a1 will be 6
            %step1: make object (struct data)
            hobObj=f.run('fun/makeHob.m',0.2,0.1,1,0.01,0.8);%see the function file about the input parameters
            curveObj=f.run('fun/make3DCurve.m',[0;1;2;3],[2,3,5,3],[3,5,2,1],0.05,0.8);
            columnObj=f.run('fun/makeColumn.m',0.1,0.28,0.01,0.8);
            ringObj=f.run('fun/makeRing.m',0.1,3,0.01,0.6);
            ringObj3D=mfs.make3Dfrom2D(ringObj,0.6,0.01);
            
            %step2: modify and combine the object, more operations can be found in help->mfs
            ringObj3D2=mfs.rotate(ringObj3D,'YZ',60);%rotate the object and then move it
            ringObj3D2=mfs.move(ringObj3D2,0.5,0.5,0.5);
            hobObj2=mfs.move(hobObj,0.5,0.8,0.2);
            columnObj2=mfs.move(columnObj,0.5,0.5,0.3);
            [columnObj2,ringObj3D2]=mfs.alignObj('front',columnObj2,ringObj3D2);%align objects
            allObj=mfs.combineObj(ringObj3D2,hobObj2,columnObj2);%combine the objects
            %figure;fs.showObj(allObj);
            
            figure;%draw objects
            subplot(2,2,1);%use subplot to draw four figures
            fs.showObj(hobObj);
            subplot(2,2,2);
            fs.showObj(curveObj);
            subplot(2,2,3);
            fs.showObj(columnObj);
            title('This is a column');
            subplot(2,2,4);
            fs.showObj(ringObj3D);
            title('This is a ring');
            
            %step3: make a Box, and import the objects to the box
            B=obj_Box;%declare a box object
            B.name='Objects';
            B.ballR=0.01;%element radius
            B.sampleW=1;%width, length, height
            B.sampleL=1;%when L is zero, it is a 2-dimensional model
            B.sampleH=1;
            B.isSample=0;%an empty box without sample elements
            B.setType('botPlaten');%add a top platen to compact model
            B.buildInitialModel();
            
            app.Box=B;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command which allows the "stop computing" in the menu
            B.setUIoutput(app.MessageTextArea);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%added command which defines the output message area
            
            d=B.d;
            [ringId,hobId,columnId]=d.addElement(1,{ringObj3D2,hobObj2,columnObj2});
            d.addGroup('ring',ringId);
            d.addGroup('hob',hobId);
            d.addGroup('column',columnId);
            
            d.mo.balance();
            figure;%show the model
            d.setGroupId();%set groupId for each group
            d.show('groupId');
            view(30,20);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create Function2ObjectUIFigure and hide until all components are created
            app.Function2ObjectUIFigure = uifigure('Visible', 'off');
            app.Function2ObjectUIFigure.Position = [100 100 418 325];
            app.Function2ObjectUIFigure.Name = 'Function2Object';

            % Create CreateModelButton
            app.CreateModelButton = uibutton(app.Function2ObjectUIFigure, 'push');
            app.CreateModelButton.ButtonPushedFcn = createCallbackFcn(app, @CreateModelButtonPushed, true);
            app.CreateModelButton.Position = [11 284 170 22];
            app.CreateModelButton.Text = 'Create Model';

            % Create MessageTextArea
            app.MessageTextArea = uitextarea(app.Function2ObjectUIFigure);
            app.MessageTextArea.Position = [11 36 400 240];
            app.MessageTextArea.Value = {'This app demo is based on the code user_Function2Object, which shows how to convert commands to an App. It aslo shows the native language support, the code user_Function2ObjLang defines the characters, including this paragraph.'};

            % Create NameLabel
            app.NameLabel = uilabel(app.Function2ObjectUIFigure);
            app.NameLabel.Position = [11 14 400 22];
            app.NameLabel.Text = 'Chun Liu, Nanjing University, chunliu@nju.edu.cn';

            % Show the figure after all components are created
            app.Function2ObjectUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = UI_Function2Object_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.Function2ObjectUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.Function2ObjectUIFigure)
        end
    end
end