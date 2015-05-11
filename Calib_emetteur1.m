% Calcule et renvoie sous forme de txt les paramètres intrasèques et extrinsèques en fonction des coefficients de la matrice de projection perspective . Doit être lancé après test 2

load 'ME.txt'
m1= zeros (1,3);
m2= zeros (1,3);
m3= zeros (1,3);

for i = 1:3
    m1(1,i)= ME(1,i);
    m2(1,i)= ME(2,i);
    m3(1,i)= ME(3,i);
end

%intrinseques = 
%       u0e       v0e        alphaUe       alphaVe

intrinseques_e= zeros(1,4);
intrinseques_e(1,1) = m1*m3';
intrinseques_e(1,2) = m2*m3';
intrinseques_e(1,3) = - norm(cross(m1,m3));
intrinseques_e(1,4) = norm(cross(m2,m3));

%ext_mat =
%       r1e
%       r2e
%       r3e
ext_mat = zeros( 3,3);
ext_mat(1,:)=  (1/ intrinseques_e(1,3)) *( m1 - intrinseques_e(1,1)*m3);
ext_mat(2,:)=  (1/ intrinseques_e(1,4)) *( m2 - intrinseques_e(1,2)*m3);
ext_mat(3,:)=  m3;

save 'ext_mat_e.txt' 'ext_mat' -ascii 
save 'intrinseques_e.txt' 'intrinseques_e' -ascii
%ext =
%       t1e       t2e       t3e

ext_e= zeros (1,3);
ext_e(1,1)=(1/intrinseques_e(1,3))*(ME(1,4)-intrinseques_e(1,1)*ME(3,4));
ext_e(1,2)=(1/intrinseques_e(1,4))*(ME(2,4)-intrinseques_e(1,2)*ME(3,4));
ext_e(1,3)=ME(3,4);

save 'ext_e.txt' 'ext_e' -ascii