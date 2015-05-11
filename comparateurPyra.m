load 'Coord1.txt'
load 'Coord2.txt'
load 'Coord3.txt'
s=size(Coord1);
maxi=0;
zz=0;
%----------- Création de l'objet pyramide dans repère Objet (O,X,Y,Z)------
%Nb pixel Objet (échantillonnage objet)
NbHO=1024;
NbVO=768;

% definition des sommets
A = [0;200;0];
B = [200;0;0];
C = [0;-200;0];
D = [-200;0;0];
S = [0;0;75];

% definition des coefs des differents plans
coef1 = Coef ( A, S, D);
coef2 = Coef ( A, S, B);
coef3 = Coef ( B, S, C);
coef4 = Coef ( C, S, D);
max2=0;

for i=1:1:s(1)
    for j=1:1:s(2)
        if isnan(Coord1(i,j))~=1
        
        z1 = (-1-coef1(1,1)*Coord1(i,j)-coef1(2,1).*Coord2(i,j))/coef1(3,1);
        z2 = (-1-coef2(1,1)*Coord1(i,j)-coef2(2,1)*Coord2(i,j))/coef2(3,1);
        z3 = (-1-coef3(1,1)*Coord1(i,j)-coef3(2,1)*Coord2(i,j))/coef3(3,1);
        z4 = (-1-coef4(1,1)*Coord1(i,j)-coef4(2,1)*Coord2(i,j))/coef4(3,1);
        zi = ((Coord1(i,j)<0) * (Coord2(i,j)>0))*z1 + ((Coord1(i,j)>0) * (Coord2(i,j)>0))*z2 +((Coord1(i,j)>0) * (Coord2(i,j)<0))*z3 +((Coord1(i,j)<0) * (Coord2(i,j)<0))*z4;
        z = (zi>=0)*zi;
        abs(z-Coord3(i,j));
        zz=zz+z;
        maxi=maxi+abs(z-Coord3(i,j)); 
        max2=max(max2,abs(z-Coord3(i,j)));
        end
    end
end
maxi/zz*100
maxi/(s(1)*s(2))
max2
