% Sample code
% RUN THIS CODE IN A NEW FOLDER !!! i.e. ./newfolder/
%% Generate images
load('./helper.mat')
target_num = 7;
numlabels = datain(:,1);  % Label
numimages = datain(:,2:785); % Data 28*28

iteration = 60000; % i.e 1:1000 image bound 
alldata = mnist(numlabels,numimages,target_num,iteration); % Generate images in current directory
%% Generate Test image data
% test_name = 'three_test_3.jpg';
% testdata = imread(test_name);
idx = randi([1,size(alldata,3)],40,1);
testdata = zeros(32,32,40);
for i = 1:40
    testdata(:,:,i) = alldata(:,:,idx(i));
end
%% Test
dummy = helper(alldata,0,1); % helper(data,THRESHOLD_FLAG,PRINTFLAG)
dummy.test(testdata,64,1,16) % test(testdata,max_iteration,max_sample_rate,endindex)