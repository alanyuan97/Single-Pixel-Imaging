tic;

close all;

testname = 'test3.jpg';

testdata = imread(testname);

refdouble = imresize(im2double(testdata),[64 64]);

N = 64;

count = 0;

SNRarray_train = zeros(20,1);

% Find the first 10 coordinates
correct10 = zeros(10,1);
Srow = [];
Scol = [];

for looptime = 1:100
    
    if looptime  == 1
        inputspec = Hadamard(refdouble);
    else 
        inputspec = Orig(:,:,MIN_PAGE);
    end
    startindex = 1+(looptime-1)*10;
    endindex = startindex + 9;
    
    [sortedspec, upthreshold,downthreshold] = extractarray(inputspec,N,startindex,endindex);

    [Crow,Ccol] = find(abs(inputspec)>=downthreshold & abs(inputspec)<=upthreshold);


    % Print coordinates, for debugging use.
    rowindex = length(Crow);

    
    for i= 1:rowindex
%         formatspec = 'Coordinate ( %i , %i ) \n';
%         fprintf(formatspec,Crow(i),Ccol(i));
        
        Srow = [Srow;Crow(i)];
        Scol = [Scol;Ccol(i)];
        
        correct10(i,1) = inputspec(Crow(i),Ccol(i));
    end
    [MIN_DISTANCE,MIN_PAGE] = my_min_dist(Orig,correct10,Nofinput,rowindex,Crow,Ccol);
    
    opmask = zeros(N,N);
    
    for ii=1:N
        for jj=1:N
            for inner_index=1:length(Srow)
                if(ii == Srow(inner_index) && jj == Scol(inner_index))
                    opmask(ii,jj) = 1;
                end
            end
        end
    end
    

    Final_rec = Hadamard(refdouble) .* opmask;
    
    if mod(looptime,5)==0
        count = count +1;
        output = rec(Final_rec);
        % subplot(4,5,looptime); imagesc(opmask); colormap gray; title(['Iteration loop ',num2str(looptime)]);
        subplot(4,5,count); imagesc(output); colormap gray; title(['Iteration loop ',num2str(looptime)]);
        peaksnr = psnr(output,refdouble);
        SNRarray_train(count,1) = peaksnr;
    end
end 

toc;