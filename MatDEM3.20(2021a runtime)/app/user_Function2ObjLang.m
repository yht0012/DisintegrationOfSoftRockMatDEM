clear;
Function2ObjectUIFigure.style='UIFigure';%type is not necessary
Function2ObjectUIFigure.type='Name';%the property of showing the word, it may be 'Name'(UIFigure), 'Text'(Button), 'Items'(DropDown)
Function2ObjectUIFigure.chs='ͨ����������������';%chinese version
Function2ObjectUIFigure.en='Function to Object';%English version

CreateModelButton.style='Button';
CreateModelButton.type='Text';
CreateModelButton.chs='���ɼ���ģ��';
CreateModelButton.en='Build the geometric model';

MessageTextArea.style='TextArea';
MessageTextArea.type='Value';
MessageTextArea.chs='���Ӧ��ʾ������user_Function2Object.m����ʾ��ν�������ת��һ������Ӧ�á����ʾ��Ҳ��ʾ�˶�����֧�֡�app/user_Function2ObjLang.m���붨�������App�Ĵ������֣��������ǿ�������һ�����֡�����ʹ���������������룬����֮�����app�ļ���������UI_Function2Object.mat������ļ����������App����ʾ���֡������������������ķ�����ʵ������App�Ķ�����֧�֡�';
MessageTextArea.en='This app demo is based on the code ''user_Function2Object.m'', which shows how to convert commands to an App. It also shows the native language support. The code ''app/user_Function2ObjLang.m'' defines the characters of this App, including this paragraph. You may open the file in the ''Main program''. When you run it, a data file ''UI_Function2Object.mat'' will be generated in the folder ''app'', which records the characters shown in this App. Native language support of other Apps can be implemented in a similar way.';

NameLabel.style='Label';
NameLabel.type='Text';
NameLabel.chs='�������Ͼ���ѧ��chunliu@nju.edu.cn';
NameLabel.en='Chun Liu, Nanjing University, chunliu@nju.edu.cn';

Name=who;
for i=1:length(Name)
    name=Name{i};
    MatDEMUIdata.(name)=eval(name);
end

save('app/UI_Function2Object.mat','MatDEMUIdata');