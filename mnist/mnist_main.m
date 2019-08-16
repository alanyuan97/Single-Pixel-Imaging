% This code generates a 3D array that contains the Hadamard 
% spectrum (Orig), such that code optimize.m can take as an input.
% This code also plot the PSNR against the pecentage of threshold. 
% Also, it compares the PSNR while using the original mask. 


tic;

close all;

Nofinput = length(namelist) ; % number of inputs
TESTIMAGE = 'test3.jpg';
OUTPUTNAME = 'recover.jpg';

SNRarray = zeros(10,1);
SNRarrayown = zeros(10,1);

ref = imread(TESTIMAGE);
refdouble = imresize(im2double(ref),[64 64]);
Orig = zeros(64,64,Nofinput);


% Training Image Hadamard Transform
for readindex=1:Nofinput
    temp = imread(strtrim(list(:,:,readindex)));
    rstemp = imresize(temp,[64 64]);
    Orig(:,:,readindex) = Hadamard(rstemp);
end

% Test image Hadamard Transform
Test = imread(TESTIMAGE);
rsTest = imresize(Test,[64 64]);
testspec = Hadamard(rsTest);

% Taking the average value of the spectrum 

av = sum(Orig,3)/Nofinput;
row = 64;

for i = 1:20
    [Sorted1,Threshold1] = arraylearn(av,row,0.05*i); % the higher the percentage, the higher the recover rate
    mask = set201(Threshold1,av,row); % replaced av
    maskown = set201(Threshold1,testspec,row);
    
    needrec = (testspec.* mask);
    needrecown = (testspec.* maskown);
    
    output = rec(needrec);
    outputown = rec(needrecown);

    if i==19
        imwrite(output,OUTPUTNAME) %reconstructing image using function rec as defined
        writeout= mask;
    end
    
    peaksnr = psnr(output,refdouble);
    
    fprintf('\n The Peak-SNR value is %0.4f', peaksnr); % 0.4f => 4 digit precision
    % The greater Peak SNR, the better the image
    subplot(4,5,i); imshow(output);   title(['Recovered Image ',num2str(10*i),'%']);
%     subplot(2,5,i); imagesc(mask); colormap gray; title(['Mask Rate',num2str(10*i),'%']);

    SNRarray(i,1) = peaksnr;
    SNRarrayown(i,1) = psnr(outputown,refdouble);
end


X=1:1:20;
figure
plot(X*0.05,SNRarray,'b--o')
hold on 
plot (X*0.05,SNRarrayown,'r--o');
legend('Average','Own');
title('PSNR against threshhold percentage');
xlabel('Percentage Threshold / %');
ylabel('PSNR / dB');

[ssimval, ssimmap] = ssim(output,refdouble);
fprintf('\n The SSIM value is %0.4f.\n',ssimval);
% imshow(ssimmap,[]);
% title(sprintf('\n ssim Index Map - Mean ssim Value is %0.4f',ssimval));

toc;