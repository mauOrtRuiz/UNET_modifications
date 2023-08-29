%prompt="Superpixels (800)";
supx = 1000;

[La,Na] = superpixels(imagen_New,supx);
 BWa = boundarymask(La);
 figure(7)
 imshow(imoverlay(imagen_New,BWa,'cyan'),'InitialMagnification',67)

% aqui se define cuales son las classes que se quedan baseline.
% algoritmo  TUMOR PASA POR OPENING
%  STROMA pasa tal cual solo se quitan pequeoa


%prompt="Region con prioridad 1: (1-Other, 2-tumor, 3-stroma, 4-inflammatory, 5-necrosis)";
Reg1 = clasen;
%prompt="Region con prioridad 2: (1-Other, 2-tumor, 3-stroma, 4-inflammatory, 5-necrosis, 6-none)";
Reg2 = 6;

%prompt="Umbral bajo (600)";
umbral = 600;

%prompt="Umbral alto (1000)";
umbral2 = 1000;

%umbral=600;
%umbral2=1000;


Prio1=imagen_estimated_New==Reg1;
Prio2=imagen_estimated_New==Reg2;

%Prio3=imagen_estimated_New==1;



se = strel('diamond',5);
Prio2_mejo = imclose(Prio2, se);

se = strel('diamond',5);
Prio1_mejo = imclose(Prio1, se);



   
actualST=imagen_sin(Prio1_mejo,umbral);
actualST=imcomplement(actualST);
actualST=imagen_sin(actualST,umbral2);
CapaST=actualST;

% mascara para eliminar stroma CapaST
capaST_Num=Reg1*uint8(imcomplement(CapaST));


umbral=600;
umbral2=1000;


actualTum=imagen_sin(Prio2_mejo,umbral);
actualTum=imcomplement(actualTum);
actualTum=imagen_sin(actualTum,umbral2);
CapaT=actualTum;

% mascara para eliminar stroma CapaST
capaT_Num=Reg2*uint8(imcomplement(CapaT));



%baselineIm=imcomplement(capacInvar)).*
%actualCT2=uint8(imcomplement(actualCT)).*imagen_estimated_New;

% en este punto se va a generar superpixeles de las regiones sobrantes




 
 %figure(9)
 analiza=La;
 
 segmentada=imagen_estimated_New;
for item=1:Na
    figu=analiza==item;
    
    
      [row,col,v] = find(figu);
      
      for tt=1:length(v)
          vec(tt)=imagen_estimated_New(row(tt),col(tt));
          %actualCT2([row,col])=mode(vec);
      end
      Mv=mode(vec);
      
      for tt=1:length(v)
         segmentada(row(tt), col(tt))=Mv;
      end
      clear vec
      clear row
      clear col
    
end

% se corrige la segmentada
if (Reg2==6)

else


    segmentadaC=segmentada.*uint8(CapaT);
    segmentadaC=segmentadaC+capaT_Num;
end


segmentadaC=segmentada.*uint8(CapaST);
segmentadaC=segmentadaC+capaST_Num;

 figure(15)
       B = labeloverlay(imagen_New,segmentadaC,'Colormap',cmap,'Transparency',0.4);
       imshow(B) 
       title('post')



