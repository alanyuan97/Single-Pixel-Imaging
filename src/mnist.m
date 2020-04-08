% THIS CODE GENERATES THE WHOLE SET OF TESTDATA AND NAMELIST
% RUN FOR THE FIRST TIME
function alldata = mnist(numlabels,numimages,diglabel,iteration)
count =1;
for i = 1:iteration
    if numlabels(i,1)==diglabel
        temp = imresize(reshape(numimages(i,:),28,28)',[32 32]);
        if count == 1
            alldata = temp;
        else 
            alldata = cat(3,alldata,temp);
        end
        count = count +1;
    end
    
end

end
