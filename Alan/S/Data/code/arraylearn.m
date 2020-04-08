% A=[9 7 3;5 4 6;8 2 1];
% B=reshape(A,[9 1]);
% C=sort(B);
% threshold=C(3,:);
% A(A<=threshold)=0
% SAMPLE CODE ABOVE

% Threshold defined as percentage 
function Thresholdvalue = arraylearn(InputArray,dim,Thresholdpercentage)
    temp = reshape(InputArray,[dim*dim 1]);
    SortedArray = sort(abs(temp),'descend');
    maxindex = round(length(SortedArray)*Thresholdpercentage);
    Thresholdvalue = SortedArray(maxindex);
end