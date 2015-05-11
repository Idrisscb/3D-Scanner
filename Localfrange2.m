function [Bande] = Localfrange2( n,p )
tic
V=int2bin(n,p);

%stockage du nombre binaire sous forme de vecteur V

%--------- Paramètres CCD -------------
load uRzoom.txt;
load vRzoom.txt;

%--------- Recherche de la frange n -------------

rouge=imread(['IRzoomRouge.bmp']);
noir=imread(['IRzoomNoir.bmp']);
mask=(double(rouge(:,:,1))>110).*1;
seuil=(2*rouge+noir)*1/3;
Im=ones(size(seuil,1),size(seuil,2));

Bornes=zeros(size(seuil,1),2);

for k=1:1:p                         % parcourir toutes les photos
    image=imread(['IRzoom',num2str(k),'.bmp']);
    
    
    image1=(image>seuil).*1;
    image1=double(image1(:,:,1));
    imageN=(mask.*image1).*1;
    
    Im1=(imageN==V(k+1)).*1;
    Im=(Im1.*Im).*1;
%     for x=1:size(image,1)               % parcourir les lignes
%         
%         for y=1:size(image,2)                   % parcourir les colonnes
%             if (((image(x,y)>seuil(x,y))&& V(k+1)==1) || ((image(x,y)<seuil(x,y))&& V(k+1)==0))&&Im(x,y)==1
%                 Im(x,y)=1;
%             else
%                 Im(x,y)=0;
%             end
%             
%         end
%     end
end
% Im=medfilt2(Im,[9,9]);
% Im=medfilt2(Im,[1,9]);
% Im=medfilt2(Im,[15,1]);
% Im=medfilt2(Im,[1,15]);
Im=medfilt2(Im,[2,2]);

for i=1:1:size(image,1)
    j=1;
    while(j<size(image,2)&&(Im(i,j)~=1))
        j=j+1;
    end
    Bornes(i,1)=j;
    
    k=size(image,2);
    while(k>1&&(Im(i,k)~=1))
        k=k-1;
    end
    Bornes(i,2)=k;
    
end
% Bornes(:,1)=medfilt1(Bornes(:,1),7);
% Bornes(:,2)=medfilt1(Bornes(:,2),7);

% figure(n);
% pcolor(Im);axis equal; shading flat; colormap('gray');
%--------- Renvoi des bords de bande sous forme de Matrice 1200*2 -------------
Bande=Bornes;
toc
end
