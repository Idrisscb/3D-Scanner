% image Rouge et noire

tic

clear all
clear figure
close all


couleur=[255 0 0];

% échantillonnage de l'objet mire
NbHR=1600;
NbVR=1200;
[x,y]=meshgrid((1:1:NbHR),(1:1:NbVR));


I=1.*x*1.*y;

A=['ROUGE.bmp'];
B(:,:,1)=uint8(couleur(1).*I);
B(:,:,2)=uint8(couleur(2).*I);
B(:,:,3)=uint8(couleur(3).*I);
Imwrite(B,A,'bmp')
I=0.*x*1.*y;

A=['NOIR.bmp'];
B(:,:,1)=uint8(couleur(1).*I);
B(:,:,2)=uint8(couleur(2).*I);
B(:,:,3)=uint8(couleur(3).*I);
Imwrite(B,A,'bmp')

figure(1); pcolor(x,y,I);
axis equal; 
shading flat; 
colormap('gray'); xlabel('x pixels'); ylabel('y pixels'); Title('Mire objet');
saveas(figure(1),'Fig grille.jpg');
toc