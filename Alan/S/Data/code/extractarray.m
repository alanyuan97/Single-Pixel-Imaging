% Threshold defined as index 
function SortedArray = extractarray(InputArray,dim)
    temp = reshape(InputArray,[dim*dim 1]);
    SortedArray = sort(abs(temp),'descend');
end