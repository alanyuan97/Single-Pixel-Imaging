close all;
clear; 

Nofinput = 6 ; % number of inputs
MASKIMAGE = 'apple1.jpg';
TESTIMAGE = 'apple2.jpg';
OUTPUTNAME = 'recover.png';

row=size(imread(MASKIMAGE,'jpg'),1);
col=size(imread(MASKIMAGE,'jpg'),2); %find the dimensions of the 2D matirx

ref = imread('grayapple','png');
refdouble = im2double(ref);
SNRarray = zeros(20,1);


% Training Image Hadamard Transform
[NM1 , orig1] = Hadamard_learn(imread(MASKIMAGE,'jpg')); %[Normalized Original]
[NM2 , orig2] = Hadamard_learn(imread('peach.jpg','jpg'));
[NM3 , orig3] = Hadamard_learn(imread('melon.jpg','jpg'));
[NM4 , orig4] = Hadamard_learn(imread('grape.jpg','jpg'));
[NM5 , orig5] = Hadamard_learn(imread('kiwi.jpg','jpg'));
[NM6 , orig6] = Hadamard_learn(imread('sw.jpg','jpg'));
% Test image Hadamard Transform
[Ntest , testspec] = Hadamard_learn(imread(TESTIMAGE,'jpg'));

% Taking the average value of the spectrum 
av = (orig1 + orig2 + orig3 + orig4 + orig5 + orig6)/Nofinput;

for i = 1:20
    [Sorted1,Threshold1] = arraylearn(av,row,0.05*i); % the higher the percentage, the higher the recover rate
    mask = set201(Threshold1,av,row);
    
    needrec = testspec .* mask;
    
    output = rec(needrec);
    
    if i==15
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


