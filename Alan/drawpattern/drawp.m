clear;
B=importdata('hadtrans.mat');
ii=8;%row index
jj=15;%column index
spectrum=B(:,:,ii,jj);
vnorm=(spectrum+1)/2;
imwrite(vnorm,'illumination_pattern.bmp','bmp');