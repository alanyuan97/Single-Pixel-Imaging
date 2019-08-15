% Threshold defined as index 
function [SortedArray,upThresholdvalue,downThresholdvalue] = extractarray(InputArray,dim,upindex,downindex)
    temp = reshape(InputArray,[dim*dim 1]);
    SortedArray = sort(abs(temp),'descend');
    % Maxdif = SortedArray(1) - SortedArray(length(SortedArray));
    downThresholdvalue = SortedArray(downindex);
    upThresholdvalue = SortedArray(upindex);
end