X=1:1:20;
figure
plot(X,SNRarray,'b--o')
hold on 
plot (X,SNRarrayown,'r--o');
hold on 
plot (X,SNRarray_train,'g--o')
legend('Average_mask','Own_mask','Trained_mask');
hold off
title('PSNR against Iteration Count');
xlabel('Iteration Count');
ylabel('PSNR / dB');