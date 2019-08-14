
close all;
CATAGORY = 2;

LABEL = label_names{CATAGORY};
tic;
namelist = strings;
index = 1;

find = 0 ;

for i=1:500
    if labels(i,1)==CATAGORY-1
        temp = zeros(32,32,3);
        temp(:,:,1) = reshape(data(i,1:1024),32,32)';
        temp(:,:,2) = reshape(data(i,1025:2048),32,32)';
        temp(:,:,3) = reshape(data(i,2049:3072),32,32)';
        rgb= uint8(temp);
        gray = rgb2gray(rgb);
        str = [LABEL,'_',num2str(i),'.jpg'];
        imwrite(gray,str);
        namelist(index) = str;
        index = index + 1;
    end
end 

for i = 3001:3100
    if labels(i,1)==CATAGORY-1 & find ==0 
        str = 'test.jpg';
        temp = zeros(32,32,3);
        temp(:,:,1) = reshape(data(i,1:1024),32,32)';
        temp(:,:,2) = reshape(data(i,1025:2048),32,32)';
        temp(:,:,3) = reshape(data(i,2049:3072),32,32)';
        rgb= uint8(temp);
        gray = rgb2gray(rgb);
        imwrite(gray,str)
        find = 1;
        % MATLAB does not support the increment operator ++
    end
end

list = char(namelist);

toc;
