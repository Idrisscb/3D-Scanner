%*************************************************************************
%*********** Programme génération de trames binaires *********************
%*************************************************************************

tic

clear all
clear figure
close all

%Nombre de trames ou ordre du codage bianire
N=5;
save 'N.txt' 'N' -ascii;
%Couleur des trames
couleur=[255 0 0]; %[red green blue]
save 'couleur.txt' 'couleur' -ascii;

%----- Paramètre LCD ---------------
%Taille en pixel
NbHE=1024; %sur horizontal
NbVE=768;  %sur vertical
save 'NbHE.txt' 'NbHE' -ascii;
%Coordonnées matricielles des pts mE du LCD
[vE,uE]=meshgrid((1:1:NbHE),(1:1:NbVE));
save 'uE.txt' 'uE' -ascii
save 'vE.txt' 'vE' -ascii


%Création des N trames
B=uint8(zeros(NbVE,NbHE,3));
for k=1:N
    %trame d'ordre k
    IE=1.*((sin(vE.*2^k.*pi./NbHE))<0);
    %enregistrement
    A=['Trame' num2str(k) '.bmp'];
    B(:,:,1)=uint8(couleur(1).*IE);
    B(:,:,2)=uint8(couleur(2).*IE);
    B(:,:,3)=uint8(couleur(3).*IE);
    imwrite(B,A,'bmp')
    %affichage
    figure(k); pcolor(vE,uE,IE); axis equal; shading flat; colormap('gray'), xlabel('vE pixels'); ylabel('uE pixels'); title('Trame IE(mE)');
    saveas(figure(k),['Fig trame',num2str(k),'.jpg'])
end

toc










