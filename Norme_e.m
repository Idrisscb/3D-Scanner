function [ res ] = Norme_e(angle)
%calcul la norme de Rr(phi,theta,psi)-Rrmes

%Rrmes
load 'ext_mat_e.txt'


%angle est un vecteur (1,3)
phi=angle(1,1);
theta=angle(1,2);
psi=angle(1,3);


RR=zeros(3,3);
RR(1,1)=cos(phi).*cos(theta);
RR(2,1)=sin(phi).*cos(theta);
RR(3,1)=-sin(theta);
RR(1,2)=cos(phi).*sin(theta).*sin(psi)-sin(phi).*cos(psi);
RR(2,2)=sin(phi).*sin(theta).*sin(psi)+cos(phi).*cos(psi);
RR(3,2)=cos(theta).*sin(psi);
RR(1,3)=cos(phi).*sin(theta).*cos(psi)+sin(phi).*sin(psi);
RR(2,3)=sin(phi).*sin(theta).*cos(psi)-cos(phi).*sin(psi);
RR(3,3)=cos(theta).*cos(psi);

res=norm(RR-ext_mat_e);

end

