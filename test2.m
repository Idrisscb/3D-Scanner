% programme permettant de tester et de lancer calcul_ME

U1 = zeros(3,16);
% contient les ur et vr (dans cet ordre)
%(11 13 15 31 51 33 55 22 66 72 77 85 38 36

%U1 = [-264 -267 -269 -140 5 -144 0 -206 84 185 182 293 -152 -149 -249 -250 -253 -134 3 -136 0 -194  79 174 169 276 -143 -140; -246 -125 -3 -266 -294 -135 0 -193 78 -248 169 1 202 66 -246 -126 -3 -268 -295 -136 0 -194 78 -249 168 -1 202 65; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 100 100 100 100 100 100 100 100 100 100 100 100 100 100];
U1=[396 343 282 638 638 637 826 868 396 347 285 640 641 640 828 871; 539 812 1107 535 810 1109 533 809 451 706 983 445 703 985 441 701;  0 0 0 0 0 0 0 0 100 100 100 100 100 100 100 100 ];

U = U1';

P= Convert_u_into_X (U);
% contient les ue et ve (dans cet ordre)
o=[120 120 120 600 600 600 960 960 120 120 120 600 600 600 960 960; 160 800 1280 160 800 1280 160 800 160 800 1280 160 800 1280 160 800];
o(1,:)=o(1,:)*768/1200;
o(1,:)=o(1,:)*1024/1024;

o2=o';

ME = calcul_ME(P,o2,1420);



