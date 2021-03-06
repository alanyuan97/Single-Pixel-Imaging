close all;

loaded = 1;
coef = 0.0488;
%change this line
% 0=> load 1=>Don't load

if loaded == 0
    datain = load('mnist_train.csv');
    numlabels = datain(:,1);
    numimages = datain(:,2:785);
end

name_list = mnist(numlabels,numimages,'three',3);
size_of_input = length(name_list);

[stored_maskav,snrav,snrown,snrzig,av_spec,all_spec_data]=mnist_main(size_of_input,name_list,'test.jpg');
[stored_maskop,snrop]=optimize(av_spec,400,9,all_spec_data,'test.jpg',size_of_input);

X=1:1:20;
figure
plot(X*coef*100,snrav,'b--o')
grid on
grid minor
hold on 
plot (X*coef*100,snrown,'r');
hold on 
plot (X*coef*100,snrop,'m--o')
hold on 
plot (X*coef*100,snrzig,'k--o')
legend('Average mask','Own mask','Trained mask','Zigzag mask','Location','northwest');
hold off
title('PSNR against Sampling Rate');
xlabel('Sampling Rate / %');
ylabel('PSNR / dB');