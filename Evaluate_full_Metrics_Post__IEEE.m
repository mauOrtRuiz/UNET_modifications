%lee.cooper@northwestern.edu

clear
filenameTE = fullfile('D:\Research_Breast_Cancer\code\roiBounds_BaseMagnificationSupAg_RS4.csv');
T=readtable(filenameTE);
conteo=1;
conteoGIGANTE=1;
total=height(T);
load vector_decision;
flagPost=0;  %cambiar a 1 cuando se corre por segunda ocasion para generar cionfusion matrix de post procesamiento
%categorias seleccionadas
classes = [
    "other"
    "tumor"
    "stroma"
    "inflammatory"
    "necrosis" 
    ];
labelIDs = camvidPixelLabelIDSS2();
vector_angle=0;
dir_outim = fullfile('D:\Research_Breast_Cancer\data_out\conf\images\');
dir_outil = fullfile('D:\Research_Breast_Cancer\data_out\conf\labels\');

%load netUNET_Batch8ADAM_epochs50
%net=netUNET_Batch8ADAM_epochs50;

% thos is the good
%load netUNET_Batch8ADAM_March;
%net=netUNET_Batch8ADAM_March;

%This was the tested for IEEE:

%load netUNET_Batch8ADAM_March;
%net= netUNET_Batch8ADAM_March;
%netRes50_IEEE_CORR

%load netRes50_IEEE_CORR;
%net= netRes50_IEEE_CORR;

%load netMobile_IEEE_CORR;
%net= netMobile_IEEE_CORR;

%load netRes18_IEEE1;
%net= netRes18_IEEE1;
%load netUNET_modifC;
%load net_UNET_Residual_3TWO
%net=net_UNET_Residual_3TWO;
%load net_UNET_Residual_3FOUR;
%load net_P_Resnetb;
%net= net_P_Resnetb;

%Net Mau2
%load net_P_ResnetMau2;
%net=net_P_ResnetMau2;

% Net RMS
load Net_P_Unetj
net=Net_P_Unetj

%
%net=net_Expe_PM;


%net=net_UNET_Residual_3FOUR;
% this was before january 5th 23 load net_UNET_Dilated_Add4TTT;
% net= net_UNET_Dilated_Add4TTT;
%load netMobile_IEEE_UNET_MOD;
%net = netUNET_modifC;
%net=netMobile_IEEE_UNET_MOD;

MC=zeros(5,5);
totalclase=zeros(5,1);

TP_F=zeros(1,5);
TN_F=zeros(1,5);
FP_F=zeros(1,5);
FN_F=zeros(1,5);

prompt="Indicar el numero de imagen 1:tumor etc";
k = input(prompt);
if k==1
           clasen=2;
           coory1=655;
           coorx1=3;
           coory2=655+1024;
           coorx2=3+1024;
end


%for k=1:total
    
  filenameAutoI = ['D:\Research_Breast_Cancer\Data_raw\Images\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
  filenameAutoL = ['D:\Research_Breast_Cancer\Data_raw\labels\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
 
  
  
  Imm=imread(filenameAutoI);
  IIa=imread(filenameAutoL);

 

  [x,y]=size(IIa);
  xx1=1;
  yy1=1;
  T.Vector_orientate_1;

  %anguli is to rotate images with inclination
  anguli=T.Vector_orientate_1(k);
  
  % CODES FROM ORIGINAL
% Tumor : 1
% Stroma: 2
% 
  Img_out=ones(x,y);
  for x1=1:x
    for y1=1:y
        if IIa(x1,y1)==1; % 1=tumor (from original)
            Img_out(x1,y1)=2;
        end
        if IIa(x1,y1)==2; % 2=stroma (from original)
            Img_out(x1,y1)=3;
        end
        if IIa(x1,y1)==3; % 3=lymphocite (from original)
            Img_out(x1,y1)=4;
        end
        if IIa(x1,y1)==4; % 4=necrosis (from original)
            Img_out(x1,y1)=5;
        end
        if IIa(x1,y1)==10; % 10=plasma (from original)
            Img_out(x1,y1)=6;
        end
        %if IIa(x1,y1)==9; % 9=fat (from original)
        %    Img_out(x1,y1)=7;
        %end
        
    end
  end
  Imgout1=sum(sum(Img_out==1));
  Imgout2=sum(sum(Img_out==2));
  Imgout3=sum(sum(Img_out==3));
  Imgout4=sum(sum(Img_out==4));
  Imgout5=sum(sum(Img_out==5));
  
  ImgoutG=Img_out==2;
  Img_out=uint8(Img_out);

  cmap = camvidColorMapSS;
  
  
  
  T.Var1(k)
  
  
  
  
  if (anguli==0)
      flagna=2;
  else
      flagna=1;
  end
  
    
  % These has to be equal to Gen Jan23
    offset=500;
    
    %images resized until 256x256
    resi=0.5;
    To=512;
    %To=750;  
    offset=512;
    tama=To*resi;
    
    
    

readdy=1;

if(flagna==1)
  while(readdy)   
  anguli=T.Vector_orientate_1(k);
  %anguli=48;

  
  J1=imrotate(Imm,anguli);
  L1=imrotate(Img_out,anguli);
  
  
  
  readdy=0;
  end
  
  xx1=T.Vector_orientate_2(k);
  yy1=T.Vector_orientate_3(k);
  xx2=T.Vector_orientate_4(k);
  yy2=T.Vector_orientate_5(k);
  
  N1=J1(xx1:xx2,yy1:yy2,:);
  N2=L1(xx1:xx2,yy1:yy2,:);
  x=xx2;
  y=yy2;
  if(readdy==0)
    
    clear Imm;
    clear Img_out; 
    Imm=N1;
    Img_out=N2;
  end
end



[x,y]=size(Img_out);

imm_res=imresize(Img_out,resi);
[x2,y2]=size(imm_res);

K=round(x/To);
J=round(y/To);
if(K*To>x)
    K=K-1;
end
if(J*To>y)
    J=J-1;
end


 %raname;

B = labeloverlay(Imm,Img_out,'ColorMap',cmap);
%figure(3)
%imshow(B) 
% pixelLabelColorbar(cmap,classes);
true_count=1;
TP=0;
TN=0;
FP=0;
FN=0;
for activv=1:5
TPlocal=zeros(1,5);
TNlocal=zeros(1,5);
FPlocal=zeros(1,5);
FNlocal=zeros(1,5);

true_count=1;
for k1=1:K
    for j=1:J
        
        imagenS=imresize(Imm(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi);
        imagenL=imresize(Img_out(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi);
        

       % imagenS=imresize(Imm(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi);
       % imagenL=imresize(Img_out(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi); 


        imagen_New(To*resi*(k1-1)+1:k1*To*resi,To*resi*(j-1)+1:j*To*resi,:)=imagenS;
        
        %figure(10)
        %imshow(imagenS)
        %pause
        Ca = semanticseg(imagenS, net);
        actual1 = uint8(Ca);
        Y=predict(net,imagenS);
        

        % solo para mostrar la imagen momentanea colocar en momentum=1
        % este bloque grafica una por una cada parche dew 256x256
        momentum=0;
        
        if(momentum)
             figure(1)
             B = labeloverlay(imagenS,actual1,'Colormap',cmap,'Transparency',0.4);
             imshow(B) 
             title('Segmentada')

             figure(2)
             B = labeloverlay(imagenS,imagenL,'Colormap',cmap,'Transparency',0.4);
             imshow(B) 
             title('Ground Truth provided by SEMSEG Challenge')
        end

         


        imagen_estimated_New(To*resi*(k1-1)+1:k1*To*resi,To*resi*(j-1)+1:j*To*resi)=actual1;
        imagen_segmented(To*resi*(k1-1)+1:k1*To*resi,To*resi*(j-1)+1:j*To*resi)=imagenL;

        imagen_predictions(To*resi*(k1-1)+1:k1*To*resi,To*resi*(j-1)+1:j*To*resi,:)=Y;

               
        
        
         filenameouti = [dir_outim,'Img_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
         filenameoutl = [dir_outil,'lbl_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
         imwrite(imagenS,filenameouti);
         imwrite(imagenL,filenameoutl);
         
         metric_alone;
         conteo=conteo+1;
         %pause

    end %for j... end of columns
    if(k1==1)
        [xac yac non]=size(imagen_New);
    end
    yacRR=yac;
    % this should input the last region on J
    
    imagenS=imresize(Imm(To*(k1-1)+1:k1*To,y-To+1:y,:),resi);
    imagenL=imresize(Img_out(To*(k1-1)+1:k1*To,y-To+1:y,:),resi);

    Ca = semanticseg(imagenS, net);
    Y=predict(net,imagenS);

    actual1 = uint8(Ca);
     delta=y2-yac;
     imagen_estimated_New(To*resi*(k1-1)+1:k1*To*resi,yac+1:y2)=actual1(:,256-delta+1:256);
     imagen_segmented(To*resi*(k1-1)+1:k1*To*resi,yac+1:y2)=imagenL(:,256-delta+1:256);

     imagen_predictions(To*resi*(k1-1)+1:k1*To*resi,yac+1:y2,:)=Y(:,256-delta+1:256,:);

     imagen_New(To*resi*(k1-1)+1:k1*To*resi,yac+1:y2,:)=imagenS(:,256-delta+1:256,:);


         
      metric_alone; 


        
         
        
               
end

        [xac yac non]=size(imagen_New);
        yac=yacRR;

for j=1:J
% there should be last region on K1

    imagenS=imresize(Imm(x-To+1:x,To*(j-1)+1:j*To,:),resi);
    imagenL=imresize(Img_out(x-To+1:x,To*(j-1)+1:j*To,:),resi);

    Ca = semanticseg(imagenS, net);
    Y=predict(net,imagenS);
    actual1 = uint8(Ca);

    delta2=x2-xac;
     imagen_estimated_New(xac+1:x2,To*resi*(j-1)+1:j*To*resi)=actual1(256-delta2+1:256,:);
     imagen_segmented(xac+1:x2,To*resi*(j-1)+1:j*To*resi)=imagenL(256-delta2+1:256,:);

     imagen_New(xac+1:x2,To*resi*(j-1)+1:j*To*resi,:)=imagenS(256-delta2+1:256,:,:);
     imagen_predictions(xac+1:x2,To*resi*(j-1)+1:j*To*resi,:)=Y(256-delta2+1:256,:,:);

     metric_alone;

end

 imagenS=imresize(Imm(x-To+1:x,y-To+1:y,:),resi);
 imagenL=imresize(Img_out(x-To+1:x,y-To+1:y,:),resi);

    Ca = semanticseg(imagenS, net);
    Y=predict(net,imagenS);
    actual1 = uint8(Ca);

 imagen_estimated_New(xac+1:x2,yac+1:y2)=actual1(256-delta2+1:256,256-delta+1:256);
 imagen_segmented(xac+1:x2,yac+1:y2)=imagenL(256-delta2+1:256,256-delta+1:256);

 imagen_New(xac+1:x2,yac+1:y2,:)=imagenS(256-delta2+1:256,256-delta+1:256,:);
 imagen_predictions(xac+1:x2,yac+1:y2,:)=Y(256-delta2+1:256,256-delta+1:256,:);

 metric_alone;

%  This should be the very last remaining region

     %RES1(k1,activv)=(TPlocal+TNlocal)/(TPlocal+TN+FP+FN);
     %RES2(k1,activv)=(TPlocal)/(TPlocal+FNlocal);
     %RES3(k1,activv)=(TNlocal)/(TNlocal+FPlocal);

     
     TP_F(activv)=TP_F(activv)+TPlocal(activv);
     TN_F(activv)=TN_F(activv)+TNlocal(activv);
     FP_F(activv)=FP_F(activv)+FPlocal(activv);
     FN_F(activv)=FN_F(activv)+FNlocal(activv);
end

     




% ***************************************************
  
  veres=0;
  comp1=imagen_estimated_New==imagen_segmented;
     if(veres==1)
       figure(3)
       imshow(imagen_New)

       figure(4)
       B = labeloverlay(imagen_New,imagen_estimated_New,'Colormap',cmap,'Transparency',0.4);
       imshow(B) 
       title('Segmented regions by UNET neural network')

       figure(5)
       B = labeloverlay(imagen_New,imagen_segmented,'Colormap',cmap,'Transparency',0.4);
       imshow(B) 
       title('Ground Truth provided by SEMSEG Challenge')
       
       figure(6)
       imshow(comp1)
       szc=size(comp1);
       COMPrison(k)=sum(sum(comp1))/((szc(1)*szc(2)))

       %figure(7)
       %[La,Na] = superpixels(imagen_New,500);
       %BWa = boundarymask(La);
       %imshow(imoverlay(imagen_New,BWa,'cyan'),'InitialMagnification',67)
       %pause
     end

umbri=50;
Imagen_limpia=imagen_estimated_New==clasen;
cc = bwconncomp(Imagen_limpia);
stats = regionprops(cc,'Area'); 
idx = find([stats.Area] > umbri); 
Imagen_limpia = ismember(labelmatrix(cc),idx);
figure(11)
imshow(Imagen_limpia)


umbri=80;
GT_limpia=imagen_segmented==clasen;
cc = bwconncomp(GT_limpia);
stats = regionprops(cc,'Area'); 
idx = find([stats.Area] > umbri); 
GT_limpia = ismember(labelmatrix(cc),idx);
figure(12)
imshow(GT_limpia)

figure(3)
IOrignueva=imagen_New(coorx1:coorx2,coory1:coory2,:);
imshow(IOrignueva)

figure(4)
ImagenSEG_nue=Imagen_limpia(coorx1:coorx2,coory1:coory2,:);
imshow(ImagenSEG_nue)


figure(5)
GTnue_limpia=GT_limpia(coorx1:coorx2,coory1:coory2,:);
imshow(GTnue_limpia)

figure(6)
B = labeloverlay(IOrignueva,GTnue_limpia,'Colormap',cmap,'Transparency',0.4);
imshow(B) 
title('Ground Truth provided by SEMSEG Challenge')
       
figure(7)
B = labeloverlay(IOrignueva,ImagenSEG_nue,'Colormap',cmap,'Transparency',0.4);
imshow(B) 
title('Segmented regions by UNET neural network')
       


postprocessing_SUPER_auto
comp2=segmentadaC==imagen_segmented;  
szc=size(comp2);
COMPrison2(k)=sum(sum(comp2))/((szc(1)*szc(2)))

figure(8)
comp2nue=comp2(coorx1:coorx2,coory1:coory2,:);
imshow(comp2nue)

disp('Aqui concluye post  segmentadaC')
%for index=1:5
%    comp22(index)=(segmentadaC==index)==(imagen_segmented==index);
%    comp33(index)=(imagen_estimated_New==index)==(imagen_segmented==index);
%end


pause
load similarity 
load acc_class 
load precission_class

Im11orig_class1=imagen_segmented==1;
Im11seg_class1=segmentadaC==1;
save Im11orig_class1 Im11orig_class1
save  Im11seg_class1 Im11seg_class1


Iorint=uint8(Im11orig_class1);
Isegint=uint8(Im11seg_class1);
IorintNOT = uint8(imcomplement(Im11orig_class1));
IsegintNOT = uint8(imcomplement(Im11seg_class1));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity(k,1) = jaccard(Im11seg_class1, Im11orig_class1);
acc_class(k,1)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
precission_class(k,1)=TP1/(TP1+FP1);



% Here it processes Confusion Matrix
Im11orig_class2=imagen_segmented==2;
Im11seg_class2=segmentadaC==2;
save Im11orig_class2 Im11orig_class2
save Im11seg_class2 Im11seg_class2

Iorint=uint8(Im11orig_class2);
Isegint=uint8(Im11seg_class2);
IorintNOT = uint8(imcomplement(Im11orig_class2));
IsegintNOT = uint8(imcomplement(Im11seg_class2));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity(k,2) = jaccard(Im11seg_class2, Im11orig_class2);
acc_class(k,2)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
precission_class(k,2)=TP1/(TP1+FP1);

Im11orig_class3=imagen_segmented==3;
Im11seg_class3=segmentadaC==3;
save Im11orig_class3 Im11orig_class3
save  Im11seg_class3 Im11seg_class3
Iorint=uint8(Im11orig_class3);
Isegint=uint8(Im11seg_class3);
IorintNOT = uint8(imcomplement(Im11orig_class3));
IsegintNOT = uint8(imcomplement(Im11seg_class3));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity(k,3) = jaccard(Im11seg_class3, Im11orig_class3);
acc_class(k,3)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
precission_class(k,3)=TP1/(TP1+FP1);


Im11orig_class4=imagen_segmented==4;
Im11seg_class4=segmentadaC==4;
save Im11orig_class4 Im11orig_class4
save  Im11seg_class4 Im11seg_class4
Iorint=uint8(Im11orig_class4);
Isegint=uint8(Im11seg_class4);
IorintNOT = uint8(imcomplement(Im11orig_class4));
IsegintNOT = uint8(imcomplement(Im11seg_class4));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity(k,4) = jaccard(Im11seg_class4, Im11orig_class4);
acc_class(k,4)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
precission_class(k,4)=TP1/(TP1+FP1);


Im11orig_class5=imagen_segmented==5;
Im11seg_class5=segmentadaC==5;
save Im11orig_class5 Im11orig_class5
save  Im11seg_class5 Im11seg_class5
Iorint=uint8(Im11orig_class5);
Isegint=uint8(Im11seg_class5);
IorintNOT = uint8(imcomplement(Im11orig_class5));
IsegintNOT = uint8(imcomplement(Im11seg_class5));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity(k,5) = jaccard(Im11seg_class5, Im11orig_class5);
acc_class(k,5)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
precission_class(k,5)=TP1/(TP1+FP1);
save similarity similarity
save acc_class acc_class
save precission_class precission_class

disp('Fin')
pause
% ******************************************************************


     % *********************************************************************
       
       [T11 T22]=size(comp1);
       M(k,1)=sum(sum(comp1))/(T11*T22);
       sum(sum(comp1))/(T11*T22)
        Igt=imagen_segmented;
       Ipred=imagen_estimated_New;
       N_class=5;
       
       genera_confusion;
       
       
       labels1=reshape(imagen_segmented,[],1);
       [imH imL]=size(labels1);

       

       %pause In this loop AUC is computed
        for col=1:N_class
            scoresM(conteoGIGANTE:conteoGIGANTE+imH-1,col) = reshape(imagen_predictions(:,:,col),[],1);
            labelsM(conteoGIGANTE:conteoGIGANTE+imH-1,col) = reshape(imagen_segmented,[],1);
            
        end
        
       conteoGIGANTE=conteoGIGANTE+imH;
       


       pause
       
       disp('Completed image k')
       
       
%end


for kk=1:N_class
     Accu(kk)=(TP_F(kk)+TN_F(kk))/(TP_F(kk)+TN_F(kk)+FP_F(kk)+FN_F(kk));
     Sensy(kk)=(TP_F(kk))/(TP_F(kk)+FN_F(kk));
     Specy(kk)=(TN_F(kk))/(TN_F(kk)+FP_F(kk));
     VPR(kk)=(FP_F(kk))/(TN_F(kk)+FP_F(kk));
end

for kk=1:N_class
     Dice_Mau(kk)=(2*TP_F(kk))/(2*TP_F(kk)+FP_F(kk)+FN_F(kk));
     
end


     
     %for col=1:N_class

      %  figure(10+col)
      %  [Xp,Yp,Tp,AUC(col)]=perfcurve(labelsM(:,col),scoresM(:,col),col);
      %  plot(Xp,Yp)
      %  xlabel('False positive rate') 
      %  ylabel('True positive rate')
      %  title('ROC for Semantic Segmentation Region: Other')
     %end

    



       for row=1:N_class
           for col=1:N_class
               MCT(row,col)=MC(row,col)/totalclase(row);
           end
       end


       if k==1
           clasen=2;
       end
       I_classTUM = imagen_estimated_New==clasen;
       IGT_classTUM = imagen_segmented==clasen;
       %figure(9)
       %imshow(I_classTUM)
       %title('Segmented by method_Class Other')

       %figure(10)
       %imshow(IGT_classTUM)
       %title('Ground Thruth Class Other')

       %pause



       clear imagen_estimated_New
       clear imagen_New
       clear imagen_segmented 

       
 for NN=1:5
    CoF(NN,:)=MC(NN,:)/sum(MC(NN,:));
 end
 NN
    
 Dice_Mau  
 Accu
 mean(COMPrison)