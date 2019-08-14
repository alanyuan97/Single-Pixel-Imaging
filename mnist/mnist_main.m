close all;

Nofinput = length(namelist) ; % number of inputs
TESTIMAGE = 'five_1.jpg';
OUTPUTNAME = 'recover.png';

SNRarray = zeros(10,1);
SNRarrayown = zeros(10,1);

ref = imread(TESTIMAGE);
refdouble = im2double(ref);

% Training Image Hadamard Transform
for readindex=1:Nofinput
    if readindex==1
        Orig = Hadamard_learn(imread(strtrim(list(:,:,readindex))));
    else
        Orig(:,:,readindex) = Hadamard_learn(strtrim(imread(list(:,:,readindex))));
    end
    
end

% Test image Hadamard Transform
testspec = Hadamard_learn(imread(TESTIMAGE,'jpg'));

% Taking the average value of the spectrum 

av = sum(Orig,3)/Nofinput;


for i = 1:10
    [Sorted1,Threshold1] = arraylearn(av,row,0.1*i); % the higher the percentage, the higher the recover rate
    mask = set201(Threshold1,av); % replaced av
    maskown = set201(Threshold1,testspec);
    
    needrec = (testspec.* mask);
    needrecown = (testspec.* maskown);
    
    output = rec(needrec);
    outputown = rec(needrecown);

    if i==5
        imwrite(output,OUTPUTNAME) %reconstructing image using function rec as defined
        writeout= mask;
    end
    
    peaksnr = psnr(output,refdouble);
    
    fprintf('\n The Peak-SNR value is %0.4f', peaksnr); % 0.4f => 4 digit precision
    % The greater Peak SNR, the better the image
%   subplot(2,5,i); imshow(output);   title(['Recovered Image ',num2str(10*i),'%']);
    subplot(2,5,i); imagesc(mask); colormap gray; title(['Mask Rate',num2str(10*i),'%']);

    SNRarray(i,1) = peaksnr;
    SNRarrayown(i,1) = psnr(outputown,refdouble);
end

X=1:1:10;
figure
plot(X*0.1,SNRarray,'b--o')
hold on 
plot (X*0.1,SNRarrayown,'r--o');
legend('Average','Own');
title('PSNR against threshhold percentage');
xlabel('Percentage Threshold / %');
ylabel('PSNR / dB');

[ssimval, ssimmap] = ssim(output,refdouble);
fprintf('\n The SSIM value is %0.4f.\n',ssimval);
% imshow(ssimmap,[]);
% title(sprintf('\n ssim Index Map - Mean ssim Value is %0.4f',ssimval));