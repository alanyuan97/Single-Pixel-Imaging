% This code take Orig as input, returns the sequence of mask accordingly.

tic;
clear a;

close all;
% test image data read in
testname = 'test3.jpg';

testdata = imread(testname);

refdouble = imresize(im2double(testdata),[64 64]);

vmax=max(max(refdouble));
vmin=min(min(refdouble));
refnorm=(refdouble-vmin)/(vmax-vmin);

LOOPMAX = 100;
% set the number of loop iterations

N = 64;
% set the dimensions of image

% initialize data
count = 0;
SNRarray_train = zeros(20,1);
correct10 = zeros(10,1);
Srow = [];
Scol = [];
a = zeros(N);

for looptime = 1:LOOPMAX
    
    if looptime  == 1
        % Find the first 10 coordinates by default
        inputspec = Hadamard(refdouble);
    else
        % otherwise, take next page as input
        add_result = zeros(N);
        for pageindex = 1:length(top10page)
            add_result = add_result + Orig(:,:,top10page(pageindex));
        end
        inputspec = add_result/pageindex;
        % Obtain average Hadamard Spectrum
    end
    
%     a = zeros(N);
    startindex = 1;
    endindex = 10;
%     opmask = zeros(N);

    loopornot = 0;
    sortedarray = extractarray(inputspec,N);
    
    while loopornot<10
        upthreshold = sortedarray(startindex);
        downthreshold = sortedarray(endindex);
%         a = zeros(N);
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
        opmask = tempmask;
        % Generate temporary mask and check if incremented by 10, if not loop
        % until 10 pixels are incremented.
        a(tempmask>0|a>0)=1;
        fprintf('\n Sum %i \n',sum(a(:)));
        loopornot = sum(a(:))-10*(looptime-1);
        fprintf('\n Loopornot %i \n',loopornot);
        if startindex<4096 && endindex<4096
            startindex = startindex + 1 ;
            endindex = endindex + 1 ;
        end
     end
    
    % Print coordinates, for debugging use.
    rowindex = length(Crow);
    
    for i= 1:rowindex
        %         formatspec = 'Coordinate ( %i , %i ) \n';
        %         fprintf(formatspec,Crow(i),Ccol(i));
        
%         Srow = [Srow;Crow(i)];
%         Scol = [Scol;Ccol(i)];
        
        correct10(i,1) = inputspec(Crow(i),Ccol(i));
    end
    
    %   [MIN_DISTANCE,MIN_PAGE] = my_min_dist(Orig,correct10,Nofinput,rowindex,Crow,Ccol);
    top10page = my_av_dist(Orig,correct10,Nofinput,rowindex,Crow,Ccol,40);
    Final_rec = Hadamard(refdouble) .* a;
    
    if mod(looptime,(LOOPMAX/20))==0
        count = count +1;
        output = rec(Final_rec);
        
        vmax1=max(max(output));
        vmin1=min(min(output));
        outputnorm=(output-vmin1)/(vmax1-vmin1);
        
        %         subplot(4,5,count); imagesc(opmask); colormap gray; title(['Iteration loop ',num2str(looptime)]);
        ssimval = ssim(outputnorm,refnorm);
        subplot(4,5,count);
        imagesc(a);
        axis image;colormap gray;
        title(['Pixels used ',num2str(10*looptime), ' / SSIM ', num2str(ssimval)]);
        
        peaksnr = psnr(output,refdouble);
        SNRarray_train(count,1) = peaksnr;
    end
end

toc;