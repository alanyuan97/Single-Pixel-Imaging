X=1:1:20;
figure
plot(X*1.22,SNRarray,'b--o')
hold on 
plot (X*1.22,SNRarrayown,'r--o');
hold on 
plot (X*1.22,SNRarray_train,'g--o')
legend('Average_mask','Own_mask','Trained_mask');
hold off
title('PSNR against Sampling Rate');
xlabel('Sampling Rate / %');
ylabel('PSNR / dB');