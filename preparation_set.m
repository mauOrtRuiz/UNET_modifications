% prepara imagenes de GT para proyectro Ki67

% Aqui cambiar el numero por la imagen correspondiente
I=imread('Imagen2_Label.jpg');
[BW1,MASKEDRGBIMAGE1] = createMaskBLUE(I);
[BW,MASKEDRGBIMAGE] = createMaskRED(I);
% 
se = strel('disk',3);

BW_red_1=imclose(BW,se);
BW_blue_1=imclose(BW1,se);

figure(6)
hb1=imshow(Io)
hb1.AlphaData = 0.9;
hold on
hb2=imshow(BW_blue_1)
hb2.AlphaData = 0.2;


BW_extra=watershed(BW_blue_1);
BW_extra(~BW_blue_1) = 0;



% Eliminar objetos pequeos
CC = bwconncomp(BW_blue_1);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
P=100;
BW2 = ismember(L, find([S.Area] >= P));
J = uint8(imcomplement(logical(BW2)));
BW_red_Mod=uint8(BW_red_1).*J;


% This is red: BW_red_Mod
% This is blue BW2

[x,y]=size(BW_extra);
Img_out=ones(x,y);
  for x1=1:x
    for y1=1:y
        if BW_extra(x1,y1)==1; % 1=blue this is cell (from original)
            Img_out(x1,y1)=2;
        end
        if BW_red_Mod(x1,y1)==1; % 2=red this is positive Ki67 (from original)
            Img_out(x1,y1)=3;
        end
        
        
        
    end
  end
Imagen2_Lbl=Img_out;
Imagen2_Ori=imread('Imagen1_Original.jpg');


dir_outim = fullfile('D:\Digipatho\Ki67\Dataset\');

 filenameouti = [dir_outim,'Img_',num2str(conteo),'.png'];
 filenameoutl = [dir_outim,'lbl_',num2str(conteo),'.png'];

       
 imwrite(Imagen2_Ori,filenameouti);
 imwrite(Imagen2_Lbl,filenameoutl);




