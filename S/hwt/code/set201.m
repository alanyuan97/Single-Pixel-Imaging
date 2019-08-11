function input = set201(Thrs,input,N)
    for i=1:N
        for j=1:N
            if (input(i,j)<= Thrs)
                input(i,j)=0;
            else
                input(i,j)=1;
            end
        end
    end
end