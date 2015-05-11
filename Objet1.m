%************************************************************************
%*********** Programme g�n�ration objet bouclier *************************
%************************************************************************

tic

clear all
clear figure
close all


%----------- Cr�ation de l'objet bouclier dans rep�re Objet (O,X,Y,Z)------
%Nb pixel Objet (�chantillonnage objet)
NbHO=1024;
NbVO=768;
%Rayon sphere mm
R=375;
%Recul sphere mm
a=300;
%Coordonn�es matricielles des pts M de l'objet
[X,Y]=meshgrid(linspace(-600,600,NbHO),linspace(-450,450,NbVO));
%Affixe de l'objet (mm)
Za2=R.^2-X.^2-Y.^2;
Z=sqrt((Za2>a^2).*Za2)-a+a.*(Za2<=a^2);
%Enregistrement des coordonn�es matricelles objet
save 'X.txt' 'X' -ascii;
save 'Y.txt' 'Y' -ascii;
save 'Z.txt' 'Z' -ascii;

%Affichage
figure(1); pcolor(X,Y,Z); axis equal; shading flat; colormap('gray'); colorbar; xlabel('X mm'); ylabel('Y mm'); title('Z (mm) Objet simul�');
saveas(figure(1),['Fig objet simule.jpg'])

toc






