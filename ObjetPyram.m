%************************************************************************
%*********** Programme génération objet bouclier *************************
%************************************************************************

tic

clear all
clear figure
close all


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

%Coordonnées matricielles des pts M de l'objet
[X,Y]=meshgrid(linspace(-600,600,NbHO),linspace(-450,450,NbVO));
%Affixe de l'objet (mm)

% definitions des affixes sur les différents  quart de plan
Z1 = (-1-coef1(1,1).*X-coef1(2,1).*Y)./coef1(3,1);
Z2 = (-1-coef2(1,1).*X-coef2(2,1).*Y)./coef2(3,1);
Z3 = (-1-coef3(1,1).*X-coef3(2,1).*Y)./coef3(3,1);
Z4 = (-1-coef4(1,1).*X-coef4(2,1).*Y)./coef4(3,1);

% creation de la pyramide  à partir des quarts de plans
Zi = ((X<0) .* (Y>0)).*Z1 + ((X>0) .* (Y>0)).*Z2 +((X>0) .* (Y<0)).*Z3 +((X<0) .* (Y<0)).*Z4;

% conservation des affixes positifs ( interieur de la pyramide)
Z = (Zi>=0).*Zi;


%Enregistrement des coordonnées matricelles objet
save 'X.txt' 'X' -ascii;
save 'Y.txt' 'Y' -ascii;
save 'Z.txt' 'Z' -ascii;

%Affichage
figure(1); pcolor(X,Y,Z); axis equal; shading flat; colormap('gray'); colorbar; xlabel('X mm'); ylabel('Y mm'); title('Z (mm) Objet simulé');
saveas(figure(1),['Fig objet simule.jpg'])

toc






