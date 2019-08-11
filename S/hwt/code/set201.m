function output = set201(Thrs,input,N)
    for i=1:N
        for j=1:N
            if (input(i,j)<= Thrs)
                output(i,j)=0;
            else
                output(i,j)=1;
            end
        end
    end
end