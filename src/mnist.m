% THIS CODE GENERATES THE WHOLE SET OF TESTDATA AND NAMELIST
% RUN FOR THE FIRST TIME
function list = mnist(numlabels,numimages,LABEL,diglabel,iteration,test_iteration)

tic;
% Display elasped time in seconds

namelist = strings;
index=1;
t = 10;
count = 0;

for i = 1:iteration
    if numlabels(i,1)==diglabel
        if i<test_iteration
            str = [LABEL,'_',num2str(i),'.jpg'];
        else
            if count<t
                str = [LABEL,'_test_',num2str(count),'.jpg'];
                count = count + 1 ;
            else 
                break
            end
        end
        temp = imresize(reshape(numimages(i,:),28,28)',[32 32]);
        imwrite(temp,str)
        namelist(index)=str;
        index = index +1;
    end
end

list = char(namelist);
toc;
end
