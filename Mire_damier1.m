% Creer un damier pour le calibrage du emetteur


tic

clear all
clear figure
close all

p=10;
q=10;
couleur=[255 0 0];

NbHE=1024;
NbVE=768;
[u,v]=meshgrid((1:1:NbHE),(1:1:NbVE));


I=1.*(sin(pi/NbHE*p.*u).*sin(pi/NbVE*q.*v)>=0);


pcolor(u,v,I);
axis equal; 
shading flat; 
colormap('gray'); xlabel('x pixels'); ylabel('y pixels'); Title('mire damier');
toc