% Code for generating figures
close all;
X=1:1:20;
figure
plot(X*coef*100,SNRarray,'b--o')
grid on
grid minor

hold on 
plot (X*coef*100,SNRarrayown,'r');
hold on 
plot (X*coef*100,SNRarray_train,'m--o')
hold on 
plot (X*coef*100,SNRarrayzig,'k--o')
legend('Average mask','Own mask','Trained mask','Zigzag mask','Location','northwest');
hold off
title('PSNR against Sampling Rate');
xlabel('Sampling Rate / %');
ylabel('PSNR / dB');

% figure
% for i = 1:20
% subplot(4,5,i);
% imagesc(abs(store_mask_average(:,:,i)-store_mask_op(:,:,i)));
% axis image;
% colormap gray;
% title(['Sampling Rate ',num2str(i*coef*100)]);
% end
