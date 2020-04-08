close all;
clear;
%% ÉèÖÃ²ÎÊı

filename='mnist';
class=10;

step=16;
rate=0.50;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
N=60000;
%% get trainorder

trainimages=im2double(importdata([ filename '\trainimages1024.mat']));
% mkdir([ filename '\results\' num2str(class) '\0\0']);
% for i=1:N
%     imwrite(reshape(trainimages(:,i),[32,32]),[filename '\results\' num2str(class) '\0\0\' num2str(i) '.png']);
% end
% trainimage=trainimage(:,:,class+1);
% trainnum=importdata([filename '\trainnum.mat']);
% N=trainnum(class+1);
% %N=400
% for i=1:N
%     A=reshape(trainimages(:,i),[32,32]);
%     B=fftshift(fft2(A));
% %     m=max(max(abs(B)));
% %     B=B/m;
%     B=reshape(B,[1,1024]);
%     trainspc(i,:)=B;
% end
trainspc=importdata([filename '\results\' num2str(class) '\ff-trainspc.mat']);
for i=1:N
    B=trainspc(i,:);
    m=max(max(abs(B)));
    B=B/m;
    trainspc(i,:)=B;
end
trainspc=trainspc(1:N,:);
trainspc1=abs(trainspc);
sumspc=sum(trainspc1,1);
[~,sumdeorder]=sort(sumspc,'descend');
save([ filename '\results\' num2str(class) '\ff-sumdeorder1.mat'],'sumdeorder');
% trainspc1=importdata([ filename '\results\' num2str(class) '\trainspc1.mat']);
% trainspc=importdata([ filename '\results\' num2str(class) '\trainspc.mat']);
% 
% trainspc1=trainspc1(1:N,:);
% trainspc=trainspc(1:N,:);
% 
% sumspc=sum(trainspc1,1);
for classno=1:40
    classno
%    mkdir([ filename '\results2\' num2str(class) '\'  num2str(classno)]);
    pattflag=zeros(1,1024);
    imageflag=zeros(1,N);
    %% get test order
    testimages=im2double(importdata([ filename '\testimages1024.mat']));
    testimage=reshape(testimages(:,classno),[32 32]);
    imwrite(testimage,[ filename '\results\' num2str(class) '\'  num2str(classno) '\before.png']);
    
    testspc=fftshift(fft2(testimage));     
    m=max(max(abs(testspc)));
    testspc=testspc/m;   
    testspc1=abs(testspc);
    [~,deorder]=sort(reshape(testspc1,[1,1024]),'descend');
    save([ filename '\results\' num2str(class) '\'  num2str(classno) '\ff-deorder1'],'deorder');
    
    %% get the order
    [a,pattflag,k]=getmax(sumspc,step,pattflag);
    order=a;times=0;
    while sum(imageflag)<N && sum(pattflag)<1024
        temptest=testspc(order);
        temptrain=trainspc(:,order);
        [trainno,imageflag,num]=getsim4fourier(temptrain,temptest,imageflag,rate);
        num;
        if num==0
            break;
        end
%         times=times+1;
%         mkdir([filename '\results\' num2str(class) '\0\' num2str(times) ]);
%         for i=1:num
%             imwrite(reshape(trainimages(:,trainno(i)),[32,32]),[filename '\results\' num2str(class) '\0\' num2str(times) '\' num2str(trainno(i)) '.png']);
%         end
        temptrainspc=trainspc1(trainno,:);
        if num==1
            ind=find(pattflag==0);
            tempspc=temptrainspc(ind);
            [~,a1]=sort(tempspc,'descend');
            a=ind(a1);
            order=[order,a];
            pattflag(ind)=1;
        else           
            avespc=mean(temptrainspc,1);
            [a,pattflag,k]=getmax(avespc,step,pattflag);
            order=[order,a];
        end
    end
    orderle(classno)=size(order,2);
    save([ filename '\results\' num2str(class) '\' num2str(classno) '\ff-' num2str(step) 'range' num2str(rate*100) '1.mat'],'order');
end

