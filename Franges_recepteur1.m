%**************************************************************************
%*********************  Images vues par le recepteur *********************
%**************************************************************************


tic

clear all
clear figure
close all

%Chargement coordonnées objet simulé
load X.txt
load Y.txt
load Z.txt
%Chargement nombre de trame
load N.txt
%Chargement couleur trame
load couleur.txt

%--------- Paramètres CCD -------------
%Taille CCD (pixel)
NbHR=1600;  %en horizontal
NbVR=1200;   %en vertical
%coordonnées matricielles des pts mR du CCD
[vR,uR]=meshgrid((1:1:NbHR),(1:1:NbVR));
%Zoom récepteur sur 1:1200x1:1300 au lieu de 1:1200x1:1600
[vRzoom,uRzoom]=meshgrid([1:1:1300],[1:1:1200]);
save 'uRzoom.txt' 'uRzoom' -ascii;
save 'vRzoom.txt' 'vRzoom' -ascii;



%---------- Matrice de projection perspective récepteur MR ------------
%Angles du dispositif
alpha=40*pi/180;
beta=100*pi/180;
phiR=-pi/2;
thetaR=-pi/2-(alpha+beta)/2;
psiR=0;
%Distances ou composantes translation du dispositif (mm)
L=950;
t1R=0;
t2R=0;
t3R=sin(alpha)/sin(alpha+beta)*L;
%Matrice de rotation RR
r11R=cos(phiR)*cos(thetaR);
r21R=sin(phiR)*cos(thetaR);
r31R=-sin(thetaR);
r12R=cos(phiR)*sin(thetaR)*sin(psiR)-sin(phiR)*cos(psiR);
r22R=sin(phiR)*sin(thetaR)*sin(psiR)+cos(phiR)*cos(psiR);
r32R=cos(thetaR)*sin(psiR);
r13R=cos(phiR)*sin(thetaR)*cos(psiR)+sin(phiR)*sin(psiR);
r23R=sin(phiR)*sin(thetaR)*cos(psiR)-cos(phiR)*sin(psiR);
r33R=cos(thetaR)*cos(psiR);
RR=[r11R r12R r13R; r21R r22R r23R; r31R r32R r33R];
%Vecteur translation TR
TR=[t1R t2R t3R]';
%Facteurs d'échelle du CCD (mm-1)
kuR=352.11;
kvR=352.11;
%Focale recepteur (mm)
fR=3.7;
%Paramètres intrinsèques
alphauR=-kuR*fR;
alphavR=kvR*fR;
%Centre axe optique sur CCD
u0R=NbVR/2+0.5;
v0R=NbHR/2+0.5;
%Matrice ICR
ICR=[alphauR 0 u0R 0; 0 alphavR v0R 0; 0 0 1 0];
%Matrice AR
AR=[RR TR;0 0 0 1];
%Matrice MR
MR=ICR*AR;
MR
%save 'MR.txt' 'MR' -ascii
load MR.txt

%--------- Projection sur récepteur ------------
sRuR1=[MR(1,1).*X+MR(1,2).*Y+MR(1,3).*Z+MR(1,4)];
sRvR1=[MR(2,1).*X+MR(2,2).*Y+MR(2,3).*Z+MR(2,4)];
sR=[MR(3,1).*X+MR(3,2).*Y+MR(3,3).*Z+MR(3,4)];
uR1=sRuR1./sR;
vR1=sRvR1./sR;


%--- Calcul des images récepteur IR pour les N trames ---
%Libération mémoire
clear sRuR1 sRvR1 sR X Y Z;
for k=1:N
    %------ Chargement des images d'intensité I de l'objet ---
    Nom=['I' num2str(k)];
    ima=imread(Nom,'bmp');
    I=double(ima(:,:,1))/255; %matrice numéric normalisée 
     
    %Libération mémoire
    clear ima A B IRzoom IR;
    %Calcul de l'inage de réception IR
    % on utilise "griddata" à la place de "interp2" car vR1 et uR1 
    % pas directement issus d'un "meshgrid"
    IR=griddata(vR1,uR1,I,vR,uR);
    for i=1:1:size(IR,1)
        for j=1:1:size(IR,2)
        IR(i,j)=IR(i,j)+0.25/(1+(i+j)/100);
        IR(i,j)=min(IR(i,j),1);
        IR(i,j)=max(IR(i,j),0);
        end
    end
    IR=1.*(IR>0.5); %Normalisation car 'nearest' dans griddata prend trop de memoire
    %Zoom récepteur sur 1:1200x1:1300 au lieu de 1:1200x1:1600
    IRzoom=IR(:,1:1300); 
    %enregistrement IR zoom
    A=['IRzoom' num2str(k) '.bmp'];
    B(:,:,1)=uint8(couleur(1).*IRzoom);
    B(:,:,2)=uint8(couleur(2).*IRzoom);
    B(:,:,3)=uint8(couleur(3).*IRzoom);
    imwrite(B,A,'bmp')
    %Affichage des images zoom
    figure(1); pcolor(vRzoom,uRzoom,IRzoom); axis equal; axis([1 1300 1 1200]); shading flat; colormap('gray'); xlabel('vR pixels'); ylabel('uR pixels'); title('Image IR(mR) ZOOM');
    saveas(figure(1),['Fig image recepteur zoom',num2str(k),'.jpg'])
end

toc









