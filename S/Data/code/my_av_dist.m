% Find the corresponding coordinates & the page where
% the minimum Euclidean distance is stored at.
% NP: Orig contains all spectrum data.

function top5 = my_av_dist(input_data,correct10,P_N,ROW_N,Crow,Ccol,top)

    top10 = zeros(ROW_N,1,P_N);
    
    average_array = zeros(P_N,2);
    
    for pgnum=1:P_N
        tempspec = input_data(:,:,pgnum);
        for i= 1:ROW_N
            top10(i,1,pgnum)=tempspec(Crow(i),Ccol(i));
        end

        min_dist_var = (top10(i,1,pgnum)-correct10).^2;
        dist = sqrt(sum(min_dist_var(:)));
        average_array(pgnum,1) = dist;
        average_array(pgnum,2) = pgnum;
    end
    
    sorted_average = sortrows(average_array,1,'descend');
    top5= sorted_average(1:top,2);
end