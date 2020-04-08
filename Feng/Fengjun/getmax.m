function [a,flag,k]=getmax(spc,step,flag)
k=0;
s=sum(flag);
b=zeros(1,1024-s);
ind=zeros(1,1024-s);
if s+step>=1024
    k=1;
end
j=0;
ind=find(flag==0);
b=spc(:,ind);
% for i=1:1024
%     if flag(i)==0
%         j=j+1;
%         ind(j)=i;
%         b(j)=spc(i);
%     end
% end
[~,p]=sort(b,'descend');
if k==0
    for i=1:step
        p(i);
        a(i)=ind(p(i));
        flag(a(i))=1;
    end
else 
   for i=1:1024-s
        p(i);
        a(i)=ind(p(i));
        flag(a(i))=1;
    end
end            
