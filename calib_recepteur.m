% Calcule et renvoie sous forme de txt les paramètres intrasèques et extrinsèques en fonction des coefficients de la matrice de projection perspective . Doit être lancé après test

load 'MR.txt'
m1= zeros (1,3);
m2= zeros (1,3);
m3= zeros (1,3);

for i = 1:3
    m1(1,i)= MR(1,i);
    m2(1,i)= MR(2,i);
    m3(1,i)= MR(3,i);
end

%intrinseques = 
%       u0r       v0r        alphaUr       alphaVr

intrinseques= zeros(1,4);
intrinseques(1,1) = m1*m3';
intrinseques(1,2) = m2*m3';
intrinseques(1,3) = - norm(cross(m1,m3));
intrinseques(1,4) = norm(cross(m2,m3));
%ext_mat =
%       r1r
%       r2r
%       r3r
ext_mat = zeros( 3,3);
ext_mat(1,:)=  (1/ intrinseques(1,3)) *( m1 - intrinseques(1,1)*m3);
ext_mat(2,:)=  (1/ intrinseques(1,4)) *( m2 - intrinseques(1,2)*m3);
ext_mat(3,:)=  m3;

%ext =
%       t1r       t2r       t3r

ext= zeros (1,3);
ext(1,1)=(1/intrinseques(1,3))*(MR(1,4)-intrinseques(1,1)*MR(3,4));
ext(1,2)=(1/intrinseques(1,4))*(MR(2,4)-intrinseques(1,2)*MR(3,4));
ext(1,3)=MR(3,4);

save 'ext_mat.txt' 'ext_mat' -ascii
save 'intrinseques.txt' 'intrinseques' -ascii
save 'ext.txt' 'ext' -ascii
