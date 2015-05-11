%**************************************************************************
%*********** Images projetée sur l'objet **********************************
%**************************************************************************

tic

clear all
clear figure
close all


%Chargement de l'objet simulé dans repère Objet (O,X,Y,Z)
load X.txt
load Y.txt
load Z.txt
%Chargement nombre de trame
load N.txt
%Chargement couleur trame
load couleur.txt
%Chargement coordonnées LCD
load uE.txt
load vE.txt
%taille LCD
NbVE=max(max(uE));
NbHE=max(max(vE));

%---------- Matrice de projection perspective émetteur ME ------------
%Angles du dispositif
alpha=40*pi/180;
beta=100*pi/180;
phiE=-pi/2;
thetaE=pi/2+(alpha+beta)/2;
psiE=0;
%Distances ou composantes translation du dispositif (mm)
L=950;
t1E=0;
t2E=0;
t3E=sin(beta)/sin(alpha+beta)*L;
%Matrice de rotation RE
r11E=cos(phiE)*cos(thetaE);
r21E=sin(phiE)*cos(thetaE);
r31E=-sin(thetaE);
r12E=cos(phiE)*sin(thetaE)*sin(psiE)-sin(phiE)*cos(psiE);
r22E=sin(phiE)*sin(thetaE)*sin(psiE)+cos(phiE)*cos(psiE);
r32E=cos(thetaE)*sin(psiE);
r13E=cos(phiE)*sin(thetaE)*cos(psiE)+sin(phiE)*sin(psiE);
r23E=sin(phiE)*sin(thetaE)*cos(psiE)-cos(phiE)*sin(psiE);
r33E=cos(thetaE)*cos(psiE);
RE=[r11E r12E r13E; r21E r22E r23E; r31E r32E r33E];
%Vecteur translation TE
TE=[t1E t2E t3E]';
%Facteurs d'échelle du LCD (mm-1)
kuE=55.99;
kvE=55.99;
%Focale emetteur (mm)
fE=33.6;
%Paramètres intrinsèques
alphauE=-kuE*fE;
alphavE=kvE*fE;
%Centre axe optique sur LCD
u0E=NbVE/2+0.5;
v0E=NbHE/2+0.5;
%Matrice ICE
ICE=[alphauE 0 u0E 0; 0 alphavE v0E 0; 0 0 1 0];
%Matrice AE
AE=[RE TE;0 0 0 1];
%Matrice ME
ME=ICE*AE;
ME
%save 'ME.txt' 'ME' -ascii
load ME.txt

%------ Calcul des images de franges objet pour les N trames ------
for k=1:N
    %------ Chargement des images d'intensité IE du LCD ---
    Nomtrame=['Trame' num2str(k)];
    ima=imread(Nomtrame,'bmp');
    IE=double(ima(:,:,1))/255; %matrice numéric normalisée 
    %Projection émetteur
    sEuE1=[ME(1,1).*X+ME(1,2).*Y+ME(1,3).*Z+ME(1,4)];
    sEvE1=[ME(2,1).*X+ME(2,2).*Y+ME(2,3).*Z+ME(2,4)];
    sE=[ME(3,1).*X+ME(3,2).*Y+ME(3,3).*Z+ME(3,4)];
    uE1=sEuE1./sE;
    vE1=sEvE1./sE;
    
    %Détermination de l'image projetée dans rep Objet
    I=interp2(vE,uE,IE,vE1,uE1,'neasrest');
    I=0.85.*I;
    for i=1:1:size(I,1)
        for j=1:1:size(I,2)
        I(i,j)=I(i,j)+0.15/(1+sqrt((i-384)^2+(j-500)^2)/200);
        end
    end
    %enregistrement
    
    A=['I' num2str(k) '.bmp'];
    B(:,:,1)=uint8(couleur(1).*I);
    B(:,:,2)=uint8(couleur(2).*I);
    B(:,:,3)=uint8(couleur(3).*I);
    C=B(:,:,1);
    imwrite(B,A,'bmp')
    %Affichage
    figure(1); pcolor(X,Y,I); axis equal; shading flat; colormap('gray'); xlabel('X mm'); ylabel('Y mm'); title('Image I(M)');
    saveas(figure(1),['Fig franges sur objet',num2str(k),'.jpg'])
end
 

toc









