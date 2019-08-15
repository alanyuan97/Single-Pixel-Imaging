% Find the corresponding coordinates & the page where
% the minimum Euclidean distance is stored at.
% NP: Orig contains all spectrum data.

function [tempdist,temppage] = my_min_dist(input_data,correct10,P_N,ROW_N,Crow,Ccol)

    top10 = zeros(ROW_N,1,P_N);
    tempdist = 0;
    
    for pgnum=1:P_N
        tempspec = input_data(:,:,pgnum);
        for i= 1:ROW_N
            top10(i,1,pgnum)=tempspec(Crow(i),Ccol(i));
        end

        min_dist_var = (top10(i,1,pgnum)-correct10).^2;
        dist = sqrt(sum(min_dist_var(:)));

        if tempdist==0 || dist<tempdist
            tempdist = dist;
            temppage = pgnum;
        end
    end

end