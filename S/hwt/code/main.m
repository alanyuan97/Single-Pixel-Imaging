close all;
clear all; 

Nofinput = 1;% number of inputs
MASKNAME = 'apple1.jpg';
OUTPUTNAME = 'apple_recover1.png';

Rightmost = 150;
Bottom = 150;

row=size(imread(MASKNAME,'jpg'),1);
col=size(imread(MASKNAME,'jpg'),2); %find the dimensions of the 2D matirx


[X1 , orig1] = Hadamard_learn(imread(MASKNAME,'jpg')); %[Normalized Original] 
[X2 , orig2] = Hadamard_learn(imread('apple2.jpg','jpg'));

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
[Sorted1,Threshold1] = arraylearn(orig1,row,1); % the lower the percentage, the higher the recover rate
orig1 = set201(Threshold1,orig1,row);

needrec = orig2 .* orig1;

output = rec(needrec);

imwrite(output,OUTPUTNAME) %reconstructing image using function rec as defined 

ref = imread('grayapple2','png');
refdouble = im2double(ref);
peaksnr = psnr(output,refdouble);

fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

% Taking the average value of the spectrum 
%av = (orig1 + orig2)/sizeofinput;
%imwrite(rec(av),'averagerec.png')
