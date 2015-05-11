% calcule MR et l'enregistre dans un .txt
% Est lancé dans test (il en utilise les données).


function [ res ] = calcul_MR(T,t,coef)

% T: matrice (2*n,3) des coordonnées des n points de reference
% t: matrice (2n,2) des Ur et Vr
% coef : distance entre le recepteur et l'objet (t3r)



n=size(T,1)/2;

B=zeros(4*n,11);        % matrice (4n,11)Br

% remplissage de Br
for i=1:2:(4*n)
    for j=1:3
        B(i,j)= T((i+1)/2,j);
    end
    B(i,4)= 1;
    for j =5:8
        B(i,j)= 0;
    end
    for j= 9:11
        B(i,j)= -t((i+1)/2,1)*T((i+1)/2,j-8);
    end
end 
for i=2:2:(4*n)
    for j=1:4
       B(i,j)= 0;
    end
    B(i,8)= 1;
    for j =5:7
        B(i,j)= T(i/2,j-4);
    end
    for j= 9:11
        B(i,j)= -t(i/2,2)*T(i/2,j-8);
    end
    





end

B1 =(B'*B)\B';          % matrice Br+

c = zeros (4*n,1);      % vecteur colonne cr
% remplissage de cr
for i = 1:2:(4*n)
    c(i,1)= t((i+1)/2,1);
end
for i=2:2:(4*n)
    c(i,1)= t(i/2,2);
end

x = B1*c;               % resolution de xr= Br+*cr
x2=x*coef;              % transformation des coefficients de MNR en ceux de MR

res = zeros (3,4);      % matrice Mr

% remplissage de Mr
res(1,1)= x2(1,1);
res(1,2)= x2(2,1);
res(1,3)= x2(3,1);
res(1,4)= x2(4,1);
res(2,1)= x2(5,1);
res(2,2)= x2(6,1);
res(2,3)= x2(7,1);
res(2,4)= x2(8,1);
res(3,1)= x2(9,1);
res(3,2)= x2(10,1);
res(3,3)= x2(11,1);
res(3,4)= coef ;

save 'MR.txt' 'res' -ascii
end

