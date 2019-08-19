% THIS CODE GENERATES THE WHOLE SET OF TESTDATA AND NAMELIST
% RUN FOR THE FIRST TIME
function list = mnist(numlabels,numimages,LABEL,diglabel)
% code when need to load data in
% **********************************
tic;
% Display elasped time in seconds 

namelist = strings;
index=1;
findbool = 0 ;

for i = 1:2000
    if numlabels(i,1)==diglabel
        str = [LABEL,'_',num2str(i),'.jpg'];
        imwrite(reshape(numimages(i,:),28,28)',str)
        namelist(index)=str;
        index = index +1;
    end
end

for i = 3001:3100
    if numlabels(i,1)==diglabel & findbool ==0 
        str = 'test.jpg';
        imwrite(reshape(numimages(i,:),28,28)',str)
        namelist(index)=str;
        index = index +1;
        findbool = 1;
    end
end

list = char(namelist);
toc;
end