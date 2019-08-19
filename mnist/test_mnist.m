% This code generates a set of numbered figures used to testing
% code when need to load data in
% **********************************
% **********************************

% Display elasped time in seconds 
function list = test_mnist(numimages,LABEL,start_index,end_index,randstart,randend)
namerandlist = strings;
index=1;

for i = start_index:end_index
        str = [LABEL,'_',num2str(i),'.jpg'];
        imwrite(reshape(numimages(i,:),28,28)',str)
        namerandlist(index)=str;
        index = index +1;
end

random_index = randi([randstart randend],1,1);
str = 'test.jpg';
imwrite(reshape(numimages(random_index,:),28,28)',str)

list = char(namerandlist);
toc;