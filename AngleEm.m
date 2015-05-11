% retourne les angles phi, theta, psi . Utilise la matrice obtenue
% après l'utilisation  de calib_emetteur.

load 'ext_mat_e.txt';

angle=zeros(1,3);
angle(1,1)=-pi/2;
angle(1,2)=160*pi/180;
angle(1,3)=0;

rep_e=fminsearch('Norme_e',angle);
AngleEmDegree=rep_e*180/pi;

% rep_e =  phi    theta    psi    en rad
% AngleEmDegree en degrée

save 'AngleEmDegree.txt' 'AngleEmDegree' -ascii