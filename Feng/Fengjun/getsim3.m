%% getsim��������Ϊѵ��ͼƬ��Ƶ�ס�����ͼƬ��Ƶ�ס�ͼƬ��־��0��ѵ������1����ѵ�������Լ�ѡ��Χ
%  ���Ϊѵ����ʣ��ѵ��ͼƬ�ı�ţ�ѡ��֮��ͼƬ��־����ѵ����ʣ���ͼƬ����
function [testno,imageflag,num]=getsim3(trainspc,testspc,imageflag,range)
num=0;
testno=zeros(1);
ind=find(imageflag==0);
trainspc2=trainspc(ind,:);
[N,M]=size(trainspc2);
dif=trainspc2-ones(N,1)*testspc;
dis=(sqrt(sum(dif.*dif,2)))';
[~,so]=sort(dis);
set=floor(N*range);
if set==0
    imageflag(ind(1))=1;
else
    li=dis(so(set));
    for i=1:N
        if  dis(i)>li
            imageflag(ind(i))=1;
        else
            num=num+1;
            testno(num)=ind(i);
        end
    end
end