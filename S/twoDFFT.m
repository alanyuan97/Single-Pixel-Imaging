vidHeight = 80; 
vidWidth = 100; 
% These are the wavevectors I want to find
k1 = 2*pi*0.1;
k2 = 2*pi*0.1; 
k3 = 2*pi*0.2;
k4 = 2*pi*0.2;
generatedOscillation = zeros(vidHeight, vidWidth);
for x = 1:vidWidth
    for y = 1:vidHeight
        % here i add a zero frequency component, which I later get rid of by
        % subtracting the average value of the image
        generatedOscillation(y,x) = generatedOscillation(y,x) + 1.2;
          % add one oscillation
          generatedOscillation(y,x) = generatedOscillation(y,x) + sin(k1*x + k2*y);
          % add another oscillation
          generatedOscillation(y,x) = generatedOscillation(y,x) + sin(k3*x + k4*y);
      end
  end
% show resulting image
figure
imagesc(generatedOscillation)
colorbar
% dft 2d
NFFTY = 2^nextpow2(vidHeight);
NFFTX = 2^nextpow2(vidWidth);
% 'detrend' data to eliminate zero frequency component
av = sum(generatedOscillation(:)) / length(generatedOscillation(:));
generatedOscillation = generatedOscillation - av;
% Find X and Y frequency spaces, assuming sampling rate of 1
samplingFreq = 1;
spatialFreqsX = samplingFreq/2*linspace(0,1,NFFTX/2+1);%linearly 65 points
spatialFreqsY = samplingFreq/2*linspace(0,1,NFFTY/2+1);
spectrum2D = fft2(generatedOscillation, NFFTY,NFFTX);
figure
contourf(spatialFreqsX, spatialFreqsY, abs(spectrum2D(1:NFFTY/2+1, 1:NFFTX/2+1)))