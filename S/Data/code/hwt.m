clear all;
%This is a code for Hadamard transform and inverse Hadamard transform
A=imread('clock.bmp'); %object image
A=im2double(A);
size1=size(A,1);
size2=size(A,2);%find the dimensions of the 2D matirx

B=fwht2d(A); %forward transform: hadamard spectrum B
vmax=max(max(B)); %max() returns the max row or column vector take two times to return the max element
vmin=min(min(B)); %same as above

Bnorm=(B-vmin)/(vmax-vmin); %normalization specifies this feature
imwrite(Bnorm,'spectrum.bmp','bmp');

Bnew=zeros(64,64);
Bnew(1:64,1:64)=B(1:64,1:64);
C=ifwht2d(Bnew); %inverse transform
vmax=max(max(C));
vmin=min(min(C));
Cnorm=(C-vmin)/(vmax-vmin);
imwrite(Cnorm,'rec.bmp','bmp'); %reconstructed image