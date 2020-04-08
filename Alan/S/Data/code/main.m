close all;
clear; 

Nofinput = 1;% number of inputs
MASKIMAGE = 'apple1.jpg';
TESTIMAGE = 'apple2.jpg';
OUTPUTNAME = 'recover.png';

row=size(imread(MASKIMAGE,'jpg'),1);
col=size(imread(MASKIMAGE,'jpg'),2); %find the dimensions of the 2D matirx


[X1 , orig1] = Hadamard(imread(MASKIMAGE,'jpg')); %[Normalized Original] 
[X2 , orig2] = Hadamard(imread(TESTIMAGE,'jpg'));

% %********** Naive approach 1 ***************
% new = zeros(row);
% for i=1:Rightmost
%     for j=1:Bottom
%       new(i,j) = orig2(i,j);
%     end
% end 
% 
% %********** End ***************

%************ Approach 2

ref = imread('grayapple','png');
refdouble = im2double(ref);
SNRarray = zeros(20,1);

for i = 1:20
    [Sorted1,Threshold1] = arraylearn(orig1,row,0.05*i); % the higher the percentage, the higher the recover rate
    mask = set201(Threshold1,orig1,row);
    
    needrec = orig1 .* mask;
    
    output = rec(needrec);
    
    if i==19
        imwrite(output,OUTPUTNAME) %reconstructing image using function rec as defined
    end % Show specific image , for debug
    
    peaksnr = psnr(output,refdouble);
    
    fprintf('\n The Peak-SNR value is %0.4f', peaksnr); % 0.4f => 4 digit precision
    % The greater Peak SNR, the better the image
    
    SNRarray(i,1) = peaksnr;
end

X=1:1:20;
figure
plot(X*0.05,SNRarray,'-o') 
title('PSNR against threshhold percentage');
xlabel('Percentage Threshold / %');
ylabel('PSNR');

% Taking the average value of the spectrum 
%av = (orig1 + orig2)/sizeofinput;
%imwrite(rec(av),'averagerec.png')
