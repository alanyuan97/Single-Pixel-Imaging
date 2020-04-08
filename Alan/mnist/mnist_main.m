% This code generates a 3D array that contains the Hadamard 
% spectrum (Orig), such that code optimize.m can take as an input.
% This code also plot the PSNR against the pecentage of threshold. 
% Also, it compares the PSNR while using the original mask. 

function [store_mask_average,SNRarray,SNRarrayown,SNRarrayzig,av,Orig] = mnist_main(Nofinput,list,testname)
tic;

coef = 0.0488;
row = 64;
SNRarray = zeros(20,1);
SNRarrayown = zeros(20,1);
SNRarrayzig = zeros(20,1);
store_mask_average = zeros(64,64,20);

Orig = zeros(64,64,Nofinput);
zigzag_array = zeros(4096,1);

% Training Image Hadamard Transform
for readindex=1:Nofinput
    temp = imread(strtrim(list(:,:,readindex)));
    rstemp = imresize(temp,[64 64]);
    Orig(:,:,readindex) = Hadamard(rstemp);
end

% Test image Hadamard Transform

testdata = imread(testname);

refdouble = imresize(im2double(testdata),[64 64]);

vmax=max(max(refdouble));
vmin=min(min(refdouble));
refnorm=(refdouble-vmin)/(vmax-vmin);
testspec = Hadamard(refnorm);

% Taking the average value of the spectrum 

av = sum(Orig,3)/Nofinput;

for i = 1:20
    Threshold1 = arraylearn(av,row,coef*i); % the higher the percentage, the higher the recover rate
    Threshold2 = arraylearn(testspec,row,coef*i);
    
    
    zigzag_array((i-1)*204+1:204*i)=1;
    mask_zigzag = invzigzag(zigzag_array,row,row);
    mask = set201(Threshold1,av,row);
    maskown = set201(Threshold2,testspec,row);
    
    needrec = (testspec.* mask);
    needrecown = (testspec.* maskown);
    needreczigzag = (testspec.* mask_zigzag);
    
    output = rec(needrec);
    outputown = rec(needrecown);
    outputzig = rec(needreczigzag);
    
    store_mask_average(:,:,i)=mask;
   
  
    % fprintf('\n The Peak-SNR value is %0.4f \n', peaksnr); % 0.4f => 4 digit precision
    % The greater Peak SNR, the better the image
    
    % subplot(4,5,i); imshow(outputzig);   title(['Recovered Image ',num2str(5*i),'%']);  
%     subplot(4,5,i); imagesc(maskown); colormap gray; title(['Sampling Rate ',num2str(5*i),'%']);

    SNRarray(i,1) = psnr(output,refnorm);
    SNRarrayown(i,1) = psnr(outputown,refnorm);
    SNRarrayzig(i,1) = psnr(outputzig,refnorm);
end

toc;
end