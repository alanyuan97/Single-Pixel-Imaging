function B = Hadamard(A)
% GRAY = rgb2gray(A);
% imwrite(GRAY,'grayapple.png','png');
% figure
% imshow(GRAY)

I=im2double(A);

B=fwht2d(I); %forward transform: hadamard spectrum B
vmax=max(max(B)); %max() returns the max row or column vector take two times to return the max element
vmin=min(min(B)); %same as above

% Bnorm=(B-vmin)/(vmax-vmin); %normalization specifies this feature
% figure
% imagesc(abs(Bnorm))
% colorbar
% imwrite(Bnorm,'spectrum.png','png');

% av = sum(Bnorm:))/length(B);

% %Reconstructing Image
% Bnew=zeros(256,256);
% Bnew(1:256,1:256)=B(1:256,1:256);
% C=ifwht2d(Bnew); %inverse transform
% vmax=max(max(C));
% vmin=min(min(C));
% Cnorm=(C-vmin)/(vmax-vmin);
% imwrite(Cnorm,'rec.png','png'); %reconstructed image
end
