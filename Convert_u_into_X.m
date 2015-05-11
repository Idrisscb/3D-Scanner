function [ res ] = Convert_u_into_X( U )

load 'MR.txt'

n=16;
t3=1010;
MNR=MR/t3;
V=zeros(2,2);
W=zeros(2,1);
res1=zeros(n,2);

for i=1:1:n
    V(1,1)=MNR(3,1)*U(i,1)-MNR(1,1);
    V(2,1)=MNR(3,1)*U(i,2)-MNR(2,1);
    V(1,2)=MNR(3,2)*U(i,1)-MNR(1,2);
    V(2,2)=MNR(3,2)*U(i,2)-MNR(2,2);
    
    W(1,1)=(MNR(1,3)-MNR(3,3)*U(i,1))*U(i,3)-MNR(3,4)*U(i,1)+MNR(1,4);
    W(2,1)=(MNR(2,3)-MNR(3,3)*U(i,2))*U(i,3)-MNR(3,4)*U(i,2)+MNR(2,4);
    
    res1(i,:)=V\W;
    
    
end
res= zeros(n,3);

res(:,1)= res1(:,1);
res(:,2)= res1(:,2);
for i= ((n/2)+1):n
    res(i,3)=100;
end
end

