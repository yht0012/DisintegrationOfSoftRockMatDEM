function [dd, kk] = testFun( ab,b3 ,c )
%FUNTEST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
kk=f.run('examples/funtest.m',ab,b3,c);
ee=0;
for i=1:50
    if i>2
        break;
    end
    ee=ee+i;
end
dd=ee+kk;
return;
disp(['num2str: ',num2str(ee)]);
end