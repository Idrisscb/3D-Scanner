% retourne les angles phi, theta, psi . Utilise la matrice obtenue
% apr�s l'utilisation  de calib_recepteur.

load 'ext_mat.txt';

angle=zeros(1,3);
angle(1,1)=-pi/2;
angle(1,2)=-160*pi/180;
angle(1,3)=0;


rep=fminsearch('Norme',angle);
AngleRecDegree=rep*180/pi;


% rep =  phi    theta    psi    en rad
% AngleRecDegree en degr�e
save 'AngleRecDegree.txt' 'AngleRecDegree' -ascii