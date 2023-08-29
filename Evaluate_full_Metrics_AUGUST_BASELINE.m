% EVALUATES METRICS FOR DEEP NETWORK WITH ALL METRICS FOR DEEP NETWORK
% CREATED BY MAURICIO
% THIS IS NETWORK MAU2
% RUN ON 23 DE MAYO DE 2023

%clear%
%filenameTE = fullfile('D:\Research_Breast_Cancer\code\roiBounds_BaseMagnificationSupAg_RS.csv');
filenameTE = fullfile('D:\Research_Breast_Cancer\code\roiBounds_BaseMagnificationSupAg_RS4.csv');
T=readtable(filenameTE);
conteo=1;
conteoGIGANTE=1;
total=height(T);
load vector_decision;

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
%load net_Expe_A20;
%net=net_Expe_A20;

% BASELINE
%load Tnet_UNET_baseline_aug;
%net=Tnet_UNET_baseline_aug;

% RMSi
%load Tnet_RMSi_aug;
%net=Tnet_RMSi_aug;

% RMSe
%load Tnet_RMSe_aug;
%net=Tnet_RMSe_aug;
%load Tnet_Mau2_oct23
%net=Tnet_Mau2_oct23;

%load Net_P_Unetj
%net=Net_P_Unetj



load Tnet_ResUnetBN_aug;
net=Tnet_ResUnetBN_aug;


%DRD (Mau2)
%load Tnet_Mau2_augRD;
%net=Tnet_Mau2_augRD;

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


for k=1:total
    k
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
            Img_out(x1,y1)=4;
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
  
  veres=1;
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
       COMPrison(k)=sum(sum(comp1))/((szc(1)*szc(2)));
       %pause
     end

     
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
       
% aqui evalua metricas


segmentadaC=imagen_estimated_New;
Im2orig_class1=imagen_segmented==1;
Im2seg_class1=segmentadaC==1;


if k>1
   load similarity_nopost_C
   load acc_class_nopost_C 
   load dice_nopost_C
   load F1_class_nopost_C
   
end

Iorint=uint8(Im2orig_class1);
Isegint=uint8(Im2seg_class1);
IorintNOT = uint8(imcomplement(Im2orig_class1));
IsegintNOT = uint8(imcomplement(Im2seg_class1));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity_nopost_C(k,1) = jaccard(Im2seg_class1, Im2orig_class1);
acc_class_nopost_C(k,1)=(TP1+TN1)/(TP1+TN1+FP1+FN1);
dice_nopost_C(k,1) = dice(Im2seg_class1, Im2orig_class1);
F1_class_nopost_C(k,1)=2*TP1/(2*TP1+FP1+FN1);


% Here it processes Confusion Matrix



Im2orig_class2=imagen_segmented==2;
Im2seg_class2=segmentadaC==2;


Iorint=uint8(Im2orig_class2);
Isegint=uint8(Im2seg_class2);
IorintNOT = uint8(imcomplement(Im2orig_class2));
IsegintNOT = uint8(imcomplement(Im2seg_class2));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity_nopost_C(k,2) = jaccard(Im2seg_class2, Im2orig_class2);
acc_class_nopost_C(k,2)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
dice_nopost_C(k,2) = dice(Im2seg_class2, Im2orig_class2);
F1_class_nopost_C(k,2)=2*TP1/(2*TP1+FP1+FN1);

Im2orig_class3=imagen_segmented==3;
Im2seg_class3=segmentadaC==3;

Iorint=uint8(Im2orig_class3);
Isegint=uint8(Im2seg_class3);
IorintNOT = uint8(imcomplement(Im2orig_class3));
IsegintNOT = uint8(imcomplement(Im2seg_class3));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity_nopost_C(k,3) = jaccard(Im2seg_class3, Im2orig_class3);
acc_class_nopost_C(k,3)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
dice_nopost_C(k,3) = dice(Im2seg_class3, Im2orig_class3);
F1_class_nopost_C(k,3)=2*TP1/(2*TP1+FP1+FN1);


Im2orig_class4=imagen_segmented==4;
Im2seg_class4=segmentadaC==4;

Iorint=uint8(Im2orig_class4);
Isegint=uint8(Im2seg_class4);
IorintNOT = uint8(imcomplement(Im2orig_class4));
IsegintNOT = uint8(imcomplement(Im2seg_class4));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity_nopost_C(k,4) = jaccard(Im2seg_class4, Im2orig_class4);
acc_class_nopost_C(k,4)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
dice_nopost_C(k,4) = dice(Im2seg_class4, Im2orig_class4);
F1_class_nopost_C(k,4)=2*TP1/(2*TP1+FP1+FN1);

Im2orig_class5=imagen_segmented==5;
Im2seg_class5=segmentadaC==5;

Iorint=uint8(Im2orig_class5);
Isegint=uint8(Im2seg_class5);
IorintNOT = uint8(imcomplement(Im2orig_class5));
IsegintNOT = uint8(imcomplement(Im2seg_class5));

TP1=sum(sum(Iorint.*Isegint));
TN1=sum(sum(IorintNOT.*IsegintNOT));
FP1=sum(sum(Isegint.*IorintNOT));
FN1=sum(sum(Iorint.*IsegintNOT));

similarity_nopost_C(k,5) = jaccard(Im2seg_class5, Im2orig_class5);
acc_class_nopost_C(k,5)=(TP1+TN1)/(TP1+TN1+FP1+FN1)
dice_nopost_C(k,5) = dice(Im2seg_class5, Im2orig_class5);
F1_class_nopost_C(k,5)=2*TP1/(2*TP1+FP1+FN1);

save similarity_nopost_C similarity_nopost_C
save acc_class_nopost_C acc_class_nopost_C
save dice_nopost_C dice_nopost_C
save F1_class_nopost_C F1_class_nopost_C

       % This is SEGMENTED -> imagen_estimated_New
       % This is GROUND TRUTH -> imagen_segmented

       if k==1
           clasen=2;
       end
       I_classTUM = imagen_estimated_New==clasen;
       IGT_classTUM = imagen_segmented==clasen;
       figure(7)
       imshow(I_classTUM)
       title('Segmented by method_Class Other')

       figure(8)
       imshow(IGT_classTUM)
       title('Ground Thruth Class Other')

       %pause
       
       clear imagen_estimated_New
       clear imagen_New
       clear imagen_segmented 
       clear imagen_predictions
       disp('Completed image k')
       
       
%pause       
end


for j=1:5
        for k=1:5
            for Ta=1:total
             vectori(Ta)=MTotal(j,k,Ta);
            end
           AvMatrixC(j,k)=mean(vectori,'omitnan');
        end
 end

disp('here to finish')
save AvMatrixC AvMatrixC
COMPrison_C=COMPrison;
save COMPrison_C COMPrison_C



for k=1:5
   AvAccIm(k)=mean(acc_class_nopost_C(:,k),'omitnan');
   StdAccIm=std(acc_class_nopost_C(:,k),'omitnan');
   
   AvSimIm(k)=mean(similarity_nopost_C(:,k),'omitnan');
   StdSimIm(k)=std(similarity_nopost_C(:,k),'omitnan');

 
   AvDiceIm(k)=mean(dice_nopost_C(:,k),'omitnan');
   StdDiceIm(k)=std(dice_nopost_C(:,k),'omitnan');

   AvF1Im(k)=mean(F1_class_nopost_C(:,k),'omitnan');
   StdF1Im=std(F1_class_nopost_C(:,k),'omitnan');

end
