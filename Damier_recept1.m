% Creer un damier pour le calibrage du recepteur

tic

clear all
clear figure
close all

p=10; % nombre de rectangles horizontaux
q=10; % nombre de rectangles verticaux
couleur=[255 0 0];

% échantillonnage de l'objet mire
NbHR=1600;
NbVR=1200;
[x,y]=meshgrid((1:1:NbHR),(1:1:NbVR));

% intensité (booléen) du damier
    % vaut 1 si sin(pi/NbHR*p.*x).*sin(pi/NbVR*q.*y)>=0
    % vaut 0 sinon
I=1.*(sin(pi/NbHR*p.*x).*sin(pi/NbVR*q.*y)>=0);

A=['MireDamier.bmp'];
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