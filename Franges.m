function Franges(rouge,noir,images)
    
I=imread(['Picture ' num2str(noir) '.jpg']);
A=['IRzoomNoir.bmp'];
I1=double(I(:,:,1))/255;
%I1=medfilt2(I1,[5,5]);
I(:,:,1)=uint8(I1*255);
imwrite(I,A,'bmp');
I=imread(['Picture ' num2str(rouge) '.jpg']);
A=['IRzoomRouge.bmp'];
I1=double(I(:,:,1))/255;
%I1=medfilt2(I1,[5,5]);
I(:,:,1)=uint8(I1*255);
imwrite(I,A,'bmp');

for i=1:1:size(images,2)
    I=imread(['Picture ' num2str(images(i)) '.jpg']);
A=['IRzoom' num2str(i) '.bmp'];

I1=double(I(:,:,1))/255;
%I1=medfilt2(I1,[5,5]);
I(:,:,1)=uint8(I1*255);
imwrite(I,A,'bmp');
    
end
end

