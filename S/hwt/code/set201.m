function output = set201(Thrs,input)
%     for i=1:N
%         for j=1:N
%             if (input(i,j)<= Thrs)
%                 output(i,j)=0;
%             else
%                 output(i,j)=1;
%             end
%         end
%     end
output = zeros(256,256);
output(abs(input)<=Thrs)=0;
output(abs(input)>Thrs)=1;
end