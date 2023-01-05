%lee.cooper@northwestern.edu

clear
filenameTE = fullfile('D:\Research_Breast_Cancer\code\roiBounds_BaseMagnificationSup.csv');
T=readtable(filenameTE);
conteo=1;
total=height(T);
load vector_decision;

%categorias seleccionadas
classes = [
    "other"           %==1
    "tumor"           %==2  
    "stroma"          %==3
    "inflammatory"    %==4
    "necrosis"        %==5
    ];
labelIDs = camvidPixelLabelIDSS2();
vector_angle=0;


for k=1:total
  k
  filenameAutoI = ['D:\Research_Breast_Cancer\Data_raw\Images\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
  filenameAutoL = ['D:\Research_Breast_Cancer\Data_raw\labels\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
 
 
  Imm=imread(filenameAutoI);
  IIa=imread(filenameAutoL);



  testflag=0;
  if (abs(randn(1,1))>1.4)
      disp('Test')
       testflag=1;
       %patches for validation are stored in next directory
       dir_outim = fullfile('D:\Research_Breast_Cancer\data_out\January_Images\Test_images\');
       dir_outil = fullfile('D:\Research_Breast_Cancer\data_out\January_Images\Test_labels\');
       
       %original images and labels are stored in this directory
        file_outimOriginal = ['D:\Research_Breast_Cancer\data_out\January_Images\Original_images\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
        file_outilOriginal = ['D:\Research_Breast_Cancer\data_out\January_Images\Original_labels\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
 

       imwrite(Imm,file_outimOriginal);
       imwrite(IIa,file_outilOriginal);

  else
      disp('Images')
      dir_outim = fullfile('D:\Research_Breast_Cancer\data_out\January_Images\images\');
      dir_outil = fullfile('D:\Research_Breast_Cancer\data_out\January_Images\labels\');
  end



 
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
        if IIa(x1,y1)==3; % 3=inflammatory  (from original is lymphocyte+plasma)
            Img_out(x1,y1)=4;
        end
        if IIa(x1,y1)==4; % 4=necrosis (from original)
            Img_out(x1,y1)=5;
        end
        if IIa(x1,y1)==10; % 10=plasma=inflammatory(from original)
            Img_out(x1,y1)=4;
        end
        
        
    end
  end
  
  Img_out=uint8(Img_out);
  cmap = camvidColorMapSS;
  
  
  
  T.Var1(k)
  
  
  
  
  if (anguli==0)
      flagna=2;
  else
      flagna=1;
  end
  
    
    offset=500;
    
    %images resized until 256x256
    resi=0.5;
    To=512;
    %To=750;  
    offset=512;

    
    
    

readdy=1;

if(flagna==1)
  while(readdy)   
  anguli=T.Vector_orientate_1(k);
  
  
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
figure(3)
imshow(B) 
pixelLabelColorbar(cmap,classes);

 prompt ='Select decision 0:discard, 1: accept image';
 decision2 = input(prompt);
if(decision2==1)
if(testflag==1)

 for k1=1:K
    for j=1:J
        imagenS=imresize(Imm(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi);
        imagenL=imresize(Img_out(To*(k1-1)+1:k1*To,To*(j-1)+1:j*To,:),resi); 

        % if(abs(rand(1,1))>0.5)
        filenameouti = [dir_outim,'Img_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
        filenameoutl = [dir_outil,'lbl_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];

       
        imwrite(imagenS,filenameouti);
        imwrite(imagenL,filenameoutl);
        conteo=conteo+1;
        %end
    end 
        
        if ((j*To+offset)<y) % an 512 offset extra image can be accomodated
            
         imagenS=imresize(Imm(To*(k1-1)+1:k1*To,To*(j-1)+1+offset:j*To+offset,:),resi);
         imagenL=imresize(Img_out(To*(k1-1)+1:k1*To,To*(j-1)+1+offset:j*To+offset,:),resi); 
         % if(abs(rand(1,1))>0.5)
         filenameouti = [dir_outim,'Img_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
         filenameoutl = [dir_outil,'lbl_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
         imwrite(imagenS,filenameouti);
         imwrite(imagenL,filenameoutl);
         conteo=conteo+1;
         % end
        end        
 end
    if ((k1*To+offset)<x) % an 512 offset extra image can be accomodated
            
        
        imagenS=imresize(Imm(To*(k1-1)+1+offset:k1*To+offset,To*(j-1)+1:j*To,:),resi);
        imagenL=imresize(Img_out(To*(k1-1)+1+offset:k1*To+offset,To*(j-1)+1:j*To,:),resi);
        % if(abs(rand(1,1))>0.5)
        filenameouti = [dir_outim,'Img_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
        filenameoutl = [dir_outil,'lbl_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
        imwrite(imagenS,filenameouti);
        imwrite(imagenL,filenameoutl);
        conteo=conteo+1;
        % end
         
    end
else



%  next is exam ple with overlapping
% New K & J
K=K+(K-1);
J=J+(J-1);

for k1=1:K
    for j=1:J
        imagenS=imresize(Imm(To/2*(k1-1)+1:To/2*(k1-1)+To,To/2*(j-1)+1:To/2*(j-1)+To,:),resi);
        imagenL=imresize(Img_out(To/2*(k1-1)+1:To/2*(k1-1)+To,To/2*(j-1)+1:To/2*(j-1)+To,:),resi); 
         if(abs(rand(1,1))>0.5)
        filenameouti = [dir_outim,'Img_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
        filenameoutl = [dir_outil,'lbl_',num2str(conteo),'_256x256_',convertStringsToChars(string(T.Var1(k))),'.png'];
        imwrite(imagenS,filenameouti);
        imwrite(imagenL,filenameoutl);
        conteo=conteo+1;

         end
        %midAug
    end 
 end
   
end       

end
end

disp('Ended first section')
pause
