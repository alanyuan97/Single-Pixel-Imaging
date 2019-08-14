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

for i = 1:500
    if labels(i,1)==1
        str = ['one_',num2str(i),'.jpg'];
        imwrite(reshape(images(i,:),28,28)',str)
        namelist(index)=str;
        index = index +1;
        % MATLAB does not support the increment operator ++
    end
end

toc;