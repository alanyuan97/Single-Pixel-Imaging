close all;
clear;
%% ÉèÖÃ²ÎÊı

filename='mnist';
class=10;

step=8;
rate=0.70;

%N=5000;
%% get trainorder

trainimage=im2double(importdata([ filename '\trainimages1024.mat']));
%trainimage=trainimage(:,:,class+1);
%trainnum=importdata([filename '\trainnum.mat']);
%N=trainnum(class+1);
N=size(trainimage,2);
for i=1:N
    A=reshape(trainimage(:,i),[32,32]);
    B=fwht2d(A);
    m=max(max(abs(B)));
    B=B/m;
    B=reshape(B,[1,1024]);
    trainspc(i,:)=B;
end
trainspc1=abs(trainspc);
sumspc=sum(trainspc1,1);
[~,sumdeorder]=sort(sumspc,'descend');
save([ filename '\results\' num2str(class) '\sumdeorder1.mat'],'sumdeorder');
% trainspc1=importdata([ filename '\results\' num2str(class) '\trainspc1.mat']);
% trainspc=importdata([ filename '\results\' num2str(class) '\trainspc.mat']);
% 
% trainspc1=trainspc1(1:N,:);
% trainspc=trainspc(1:N,:);
% 
% sumspc=sum(trainspc1,1);
for classno=1:10
    classno
    mkdir([ filename '\results\' num2str(class) '\'  num2str(classno)]);
    pattflag=zeros(1,1024);
    imageflag=zeros(1,N);
    %% get test order
    testimages=im2double(importdata([ filename '\testimages1024.mat']));
    testimage=reshape(testimages(:,classno),[32 32]);
    imwrite(testimage,[ filename '\results\' num2str(class) '\'  num2str(classno) '\before.png']);
    
    testspc=fwht2d(testimage);    
    m=max(max(abs(testspc)));
    testspc=testspc/m;
    testspc1=abs(testspc);
    [~,deorder]=sort(reshape(testspc1,[1,1024]),'descend');
    save([ filename '\results\' num2str(class) '\'  num2str(classno) '\deorder1'],'deorder');
    
    %% get the order
    [a,pattflag,k]=getmax(sumspc,step,pattflag);
    order=a;
    while sum(imageflag)<N && sum(pattflag)<1024
        temptest=testspc(order);
        temptrain=trainspc(:,order);
        [trainno,imageflag,num]=getsim3(temptrain,temptest,imageflag,rate);
        num;
        if num==0
            break;
        end
        temptrainspc=trainspc1(trainno,:);
        avespc=mean(temptrainspc,1);
        [a,pattflag,k]=getmax(avespc,step,pattflag);
        order=[order,a];
    end
    save([ filename '\results\' num2str(class) '\' num2str(classno) '\' num2str(step) 'range' num2str(rate*100) '4.mat'],'order');
end

