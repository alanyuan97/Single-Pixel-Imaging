close all;
clear;



%% …Ë÷√≤Œ ˝∂¡»Î‘≠Õº

filename='mnist';
class=10;
%classno=13 22 53;26,22,17

step=8;
rate=0.70;
size=32;
num=0;

for classno=1:10
    classno
    num=num+1;
    testimage=im2double(imread([filename '\results\' num2str(class) '\' num2str(classno) '\before.png']));
    A=testimage;
    
    %% hadamardæÿ’ÛÀ≥–Úª÷∏¥ÕºœÒ
    B=fwht2d(A);
    mask=zeros(size,size);
    m=zeros(size,size)+1;
    ord=1:size*size;
    ord=reshape(ord,[size,size]);
    order=zigzag(ord);
    rand=88;
    for i=1:rand
        if mod(order(i),size)==0
            mask(order(i)/size,size)=1;
            m(order(i)/size,size)=i/255;
        else
            mask(floor(order(i)/size)+1,mod(order(i),size))=1;
            m(floor(order(i)/size)+1,mod(order(i),size))=i/255;
        end
        Bm=B.*mask;
        rec=ifwht2d(Bm);
        recim=reshape(rec,[size,size]);
        ftest=recim;
        ftest=(ftest-min(min(ftest)))/(max(max(ftest))-min(min(ftest)));
        psn(num,i,1)=psnr(testimage,ftest);
        ssi(num,i,1)=ssim(testimage,ftest);
    end
    %                 Bm=B.*mask;
    %                 rec=ifwht2d(Bm);
    %                 recim=reshape(rec,[size,size]);
    %                 ftest=recim;
    %                 ftest=(ftest-min(min(ftest)))/(max(max(ftest))-min(min(ftest)));
    %                 imwrite(ftest,[filename '\results\' num2str(class) '\' num2str(classno) '\o-' num2str(rand) '.png']);
    %                 imwrite(m,[filename '\results\' num2str(class) '\' num2str(classno) '\paio-' num2str(rand) '.png']);
    %
    %% train≈≈–Úπ˝µƒhadamardæÿ’Ûª÷∏¥ÕºœÒ
    order2=double(importdata([filename '\results\' num2str(class) '\sumdeorder1.mat']));
    mask2=zeros(size,size);
    m2=zeros(size,size)+1;
    for i=1:rand
        if mod(order2(i),size)==0
            mask2(size,order2(i)/size)=1;
            m2(size,order2(i)/size)=i;
        else
            mask2(mod(order2(i),size),floor(order2(i)/size)+1)=1;
            m2(mod(order2(i),size),floor(order2(i)/size)+1)=i;
        end
        Bm2=B.*mask2;
        rec2=ifwht2d(Bm2);
        recim2=reshape(rec2,size,size);
        ftest2=recim2;
        ftest2=(ftest2-min(min(ftest2)))/(max(max(ftest2))-min(min(ftest2)));
        psn(num,i,2)=psnr(testimage,ftest2);
        ssi(num,i,2)=ssim(testimage,ftest2);
    end
    %                 Bm2=B.*mask2;
    %                 rec2=ifwht2d(Bm2);
    %                 recim2=reshape(rec2,size,size);
    %                 ftest2=recim2;
    %                 ftest2=(ftest2-min(min(ftest2)))/(max(max(ftest2))-min(min(ftest2)));
    %                 imwrite(ftest2,[filename '\results\' num2str(class) '\' num2str(classno) '\tr-' num2str(rand) '.png']);
    %                 imwrite(m2,[filename '\results\' num2str(class) '\' num2str(classno) '\paitr-' num2str(rand) '.png']);
    
    %% ≈≈–Úπ˝µƒhadamardæÿ’Ûª÷∏¥ÕºœÒ
    order3=double(importdata([filename '\results\' num2str(class) '\' num2str(classno) '\' num2str(step) 'range' num2str(rate*100) '4.mat']));
    %sor=sor+1;
    %sor=fliplr(sor);
    %sor=double(importdata('o1.mat'));
    %sor=randperm(1024);
    mask3=zeros(size,size);
    m3=zeros(size,size)+1;
    for i=1:rand
        if mod(order3(i),size)==0
            mask3(size,order3(i)/size)=1;
            m3(size,order3(i)/size)=i/255;
        else
            mask3(mod(order3(i),size),floor(order3(i)/size)+1)=1;
            m3(mod(order3(i),size),floor(order3(i)/size)+1)=i/255;
        end
        Bm3=B.*mask3;
        rec3=ifwht2d(Bm3);
        recim3=reshape(rec3,size,size);
        ftest3=recim3;
        ftest3=(ftest3-min(min(ftest3)))/(max(max(ftest3))-min(min(ftest3)));
        psn(num,i,3)=psnr(testimage,ftest3);
        ssi(num,i,3)=ssim(testimage,ftest3);
    end
    %                 Bm3=B.*mask3;
    %                 rec3=ifwht2d(Bm3);
    %                 recim3=reshape(rec3,size,size);
    %                 ftest3=recim3;
    %                 ftest3=(ftest3-min(min(ftest3)))/(max(max(ftest3))-min(min(ftest3)));
    %                 imwrite(ftest3,[filename '\results\' num2str(class) '\' num2str(classno) '\' num2str(step) '-' num2str(rate*100) '-' num2str(rand) '.png']);
    %                 imwrite(m3,[filename '\results\' num2str(class) '\' num2str(classno) '\pai' num2str(step) '-' num2str(rate*100) '-' num2str(rand) '.png']);
    %
    %% testÀ˘”–∆µ∆◊≈≈–Úπ˝µƒhadamardæÿ’Ûª÷∏¥ÕºœÒ
    order4=double(importdata([filename '\results\' num2str(class) '\' num2str(classno) '\deorder1.mat']));
    mask4=zeros(size,size);
    m4=zeros(size,size)+1;
    for i=1:rand
        if mod(order4(i),size)==0
            mask4(size,order4(i)/size)=1;
            m4(size,order4(i)/size)=i/255;
        else
            mask4(mod(order4(i),size),floor(order4(i)/size)+1)=1;
            m4(mod(order4(i),size),floor(order4(i)/size)+1)=i/255;
        end
        Bm4=B.*mask4;
        rec4=ifwht2d(Bm4);
        recim4=reshape(rec4,size,size);
        ftest4=recim4;
        ftest4=(ftest4-min(min(ftest4)))/(max(max(ftest4))-min(min(ftest4)));
        psn(num,i,4)=psnr(testimage,ftest4);
        ssi(num,i,4)=ssim(testimage,ftest4);
    end
    %         Bm4=B.*mask4;
    %         rec4=ifwht2d(Bm4);
    %         recim4=reshape(rec4,size,size);
    %         ftest4=recim4;
    %         ftest4=(ftest4-min(min(ftest4)))/(max(max(ftest4))-min(min(ftest4)));
    %         imwrite(ftest4,[filename '\results\' num2str(class) '\' num2str(classno) '\d-' num2str(rand) '.png']);
    %         imwrite(m4,[filename '\results\' num2str(class) '\' num2str(classno) '\paid-' num2str(rand) '.png']);
end
%
% save([filename '\results\' num2str(class) '\50psn' num2str(rate*100) '4.mat'],'psn');
% save([filename '\results\' num2str(class) '\50ssi' num2str(rate*100) '4.mat'],'ssi');

%% –ßπ˚œ‘ æ
% figure;
% subplot(1,5,1), imshow(testimage,[],'InitialMagnification',1000); title('Original graph');
% subplot(1,5,2), imshow(ftest,[],'InitialMagnification',1000); title('‘≠À≥–Ú');
% subplot(1,5,4), imshow(ftest2,[],'InitialMagnification',1000); title('∂ØÃ¨≈≈–Ú');
% subplot(1,5,5), imshow(ftest4,[],'InitialMagnification',1000); title('test÷±Ω”≈≈–Ú');
% subplot(1,5,3), imshow(ftest4,[],'InitialMagnification',1000); title('train÷±Ω”≈≈–Ú');
% 
% figure;
% subplot(1,4,1),imshow(m,[],'InitialMagnification',1000); title('H order')
% subplot(1,4,2),imshow(m4,[],'InitialMagnification',1000); title('train order')
% subplot(1,4,3),imshow(m2,[],'InitialMagnification',1000); title('Sort order')
% subplot(1,4,4),imshow(m4,[],'InitialMagnification',1000); title('test order')

avepsn(1,:)=mean(psn(:,:,1),1);
avepsn(2,:)=mean(psn(:,:,2),1);
avepsn(3,:)=mean(psn(:,:,3),1);
avepsn(4,:)=mean(psn(:,:,4),1);
avessi(1,:)=mean(ssi(:,:,1),1);
avessi(2,:)=mean(ssi(:,:,2),1);
avessi(3,:)=mean(ssi(:,:,3),1);
avessi(4,:)=mean(ssi(:,:,4),1);
r=88;
figure;
plot(1:r,avepsn(1,1:r),'k',1:r,avepsn(2,1:r),'g',1:r,avepsn(3,1:r),'r',1:r,avepsn(4,1:r),'b')
title('Number Digit Images','FontSize',12)
xlabel('Number of Illuminations','FontSize',12)
ylabel('PSNR of Reconstructed Images','FontSize',12)
legend('H','trainsort','sort','testsort','Location','SouthEast','FontSize',12)

figure;
plot(1:r,avessi(1,1:r),'k',1:r,avessi(2,1:r),'g',1:r,avessi(3,1:r),'r',1:r,avessi(4,1:r),'b')
title('Number Digit Images','FontSize',12)
xlabel('Number of Illuminations','FontSize',12)
ylabel('SSIM of Reconstructed Images','FontSize',12)
legend('H','trainsort','sort','testsort','Location','SouthEast','FontSize',12)
