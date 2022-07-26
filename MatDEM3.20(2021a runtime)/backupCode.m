%file will be save in the backup folder
mFiles=dir('*.m');
t=clock();
new_folder=['backup/MatDEM-' num2str(t(1)) num2str(t(2)) num2str(t(3)) '/'];
mkdir(new_folder);
for i=1:length(mFiles)
    fName=mFiles(i).name;
    copyfile(fName,[new_folder fName]);
end
fs.disp('Operation is finished');