% Sample code
% RUN THIS CODE IN A NEW FOLDER !!! i.e. ./newfolder/
%% Generate images
load('helper.mat')
numlabels = datain(:,1);  % Label
numimages = datain(:,2:785); % Data 28*28

iteration = 1000; % i.e 1:1000 image bound 
test_iteration = 950; % i.e. From 950 - 1000 test image bound


name_list = mnist(numlabels,numimages,'three',3,iteration,test_iteration); % Generate images in current directory
size_of_input = length(name_list); % Size of list
alldata = zeros(32,32,size_of_input);

% Iterate to generate spectrum data
for readindex=1:size_of_input
    alldata(:,:,readindex) = imread(strtrim(name_list(:,:,readindex)));
end
%% Generate Test image data
test_name = 'three_test_5.jpg';
testdata = imread(test_name);
%% Test
dummy = helper(alldata,1,1); % helper(data,THRESHOLD_FLAG,PRINTFLAG)
dummy.test(testdata,128,0.5,4) % test(testdata,max_iteration,max_sample_rate,endindex)