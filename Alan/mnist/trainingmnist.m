%Neural Networks Codes will be run on this part
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
pic1=imread('three_8.jpg');
% pic=255-pic;
[a,b]=size(pic1);
for i=1:1:a
    for j=1:1:b   
        if  pic1(i,j)==0    
            up=i;           
            break       
        end
    end
end
for i=a:-1:1
    for j=1:1:b       
        if  pic1(i,j)==0            
            down=i;
            break
        end        
    end
end
for j=1:1:b
    for i=1:1:a       
        if  pic1(i,j)==0            
            left=j;
            break
        end        
    end
end
for j=b:-1:1
    for i=1:1:a       
        if  pic1(i,j)==0            
            right=j;
            break
        end        
    end
end
pic=pic1(down:up,right:left);
imshow(pic)
pic=imresize(pic,[28 28]);
% size(pic);
pic1=1-double(reshape(pic,784,1))/255;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%???????
% image = loadMNISTImages('train-images'); % ???????60000?size(image)=784*60000
% label = loadMNISTLabels('train-labels');%??????????
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label1=zeros(60000,10);
j=0;
for i=1:1:60000  
    j=labels(i)+1;
    label1(i,j)=1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%=????
PR=minmax(images);
bpnet=newff(PR,[30 10],{'tansig', 'tansig'}, 'traingd', 'learngdm');
net.epoch=100;
net.trainParam.epochs=10;%????????
net.trainParam.goal=0.001; %????????0.001
net.trainParam.show=1; %???100?????????
net.trainParam.lr=0.01; %????
bpnet=train(bpnet,images,label1');
bpnet=sim(bpnet,pic1);
shuzi=find(bpnet==max(bpnet))-1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc