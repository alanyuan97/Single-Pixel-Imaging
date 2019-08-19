
function [store_mask_op,SNRarray_train] = optimize(av,LOOPMAX,increment_amount,Data_in,testname,Nofinput)
tic;

% set the number of loop iterations

N = 64;
% set the dimensions of image

% initialize data
count = 0;
SNRarray_train = zeros(20,1);
store_mask_op = zeros(N,N,20);
correct10 = zeros(10,1);
a = zeros(N);

% Test image Hadamard Transform

testdata = imread(testname);

refdouble = imresize(im2double(testdata),[64 64]);

vmax=max(max(refdouble));
vmin=min(min(refdouble));
refnorm=(refdouble-vmin)/(vmax-vmin);
testspec = Hadamard(refnorm);

for looptime = 1:LOOPMAX
    
    if looptime  == 1
        % Find the first 10 coordinates by default
        inputspec= av;
    else
        % otherwise, take next page as input
        add_result = zeros(N);
        for pageindex = 1:length(top10page)
            add_result = add_result + abs(Data_in(:,:,top10page(pageindex)));
        end
        av_spec = add_result/pageindex;
        % Obtain average Hadamard Spectrum
        inputspec = av_spec .* flip_mask;
    end
    
    startindex = 1;
    endindex = startindex+increment_amount;
    
    sortedarray = extractarray(inputspec,N);
    
    upthreshold = sortedarray(startindex);
    downthreshold = sortedarray(endindex);
    [Crow,Ccol] = find(abs(inputspec)>=downthreshold & abs(inputspec)<=upthreshold);
    tempmask = zeros(N);
    
    for ii=1:N
        for jj=1:N
            for inner_index=1:length(Crow)
                if(ii == Crow(inner_index) && jj == Ccol(inner_index))
                    tempmask(ii,jj) = 1;
                end
            end
        end
    end
    
    a(tempmask>0|a>0)=1;
    flip_mask = 1.-a;
    % flip 1 to 0 // 0 to 1
        
    for i= 1:length(Crow)        
        correct10(i,1) = inputspec(Crow(i),Ccol(i));
    end
    
    top10page = my_av_dist(Data_in,correct10,Nofinput,length(Crow),Crow,Ccol,50);
    
    if mod(looptime,(LOOPMAX/20))==0
        count = count +1;
        Final_rec = testspec .* a;
        store_mask_op(:,:,count) = a;
        output = rec(Final_rec);
                
        ssimval = ssim(output,refnorm);
        subplot(4,5,count);
        imagesc(a);
        axis image;colormap gray;
        title(['Sampling Rate ',num2str(1000*looptime/4096), ' / SSIM ', num2str(ssimval)]);
        
        peaksnr = psnr(output,refnorm);
        SNRarray_train(count,1) = peaksnr;
    end
end

toc;
end