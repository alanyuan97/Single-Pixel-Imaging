close all;
% code when need to load data in
% **********************************
tic;
% data = load('mnist_train.csv');
% 
% labels = data(:,1);
% 
% images = data(:,2:785);
% **********************************

% Display elasped time in seconds 

namelist = strings;
index=1;
find = 0 ;
LABEL = 'three';

for i = 1:2000
    if labels(i,1)==3
        str = [LABEL,'_',num2str(i),'.jpg'];
        imwrite(reshape(images(i,:),28,28)',str)
        namelist(index)=str;
        index = index +1;
        % MATLAB does not support the increment operator ++
    end
end

for i = 3001:3100
    if labels(i,1)==3 & find ==0 
        str = 'test.jpg';
        imwrite(reshape(images(i,:),28,28)',str)
        namelist(index)=str;
        index = index +1;
        find = 1;
        % MATLAB does not support the increment operator ++
    end
end

list = char(namelist);
toc;