clear;
Function2ObjectUIFigure.style='UIFigure';%type is not necessary
Function2ObjectUIFigure.type='Name';%the property of showing the word, it may be 'Name'(UIFigure), 'Text'(Button), 'Items'(DropDown)
Function2ObjectUIFigure.chs='通过函数来生成物体';%chinese version
Function2ObjectUIFigure.en='Function to Object';%English version

CreateModelButton.style='Button';
CreateModelButton.type='Text';
CreateModelButton.chs='生成几何模型';
CreateModelButton.en='Build the geometric model';

MessageTextArea.style='TextArea';
MessageTextArea.type='Value';
MessageTextArea.chs='这个应用示例基于user_Function2Object.m，演示如何将命令行转化一个窗口应用。这个示例也演示了多语言支持。app/user_Function2ObjLang.m代码定义了这个App的窗口文字，包括我们看到的这一段文字。可以使用主程序打开这个代码，运行之后会在app文件夹中生成UI_Function2Object.mat，这个文件定义了这个App的显示文字。可以用类似这个代码的方法来实现其它App的多语言支持。';
MessageTextArea.en='This app demo is based on the code ''user_Function2Object.m'', which shows how to convert commands to an App. It also shows the native language support. The code ''app/user_Function2ObjLang.m'' defines the characters of this App, including this paragraph. You may open the file in the ''Main program''. When you run it, a data file ''UI_Function2Object.mat'' will be generated in the folder ''app'', which records the characters shown in this App. Native language support of other Apps can be implemented in a similar way.';

NameLabel.style='Label';
NameLabel.type='Text';
NameLabel.chs='刘春，南京大学，chunliu@nju.edu.cn';
NameLabel.en='Chun Liu, Nanjing University, chunliu@nju.edu.cn';

Name=who;
for i=1:length(Name)
    name=Name{i};
    MatDEMUIdata.(name)=eval(name);
end

save('app/UI_Function2Object.mat','MatDEMUIdata');