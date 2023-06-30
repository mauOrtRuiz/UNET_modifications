filenameTE = fullfile('D:\Research_Breast_Cancer\code\roiBounds_BaseMagnificationSup.csv');
T=readtable(filenameTE);
conteo=1;
total=height(T);

classes = [
    "background"           %==1
    "positive"           %==2  
    "negative"          %==3
]

resi=0.5;
To=512;
%To=750;  
offset=512;


for k=1:total
  k
  filenameAutoI = ['D:\Research_Breast_Cancer\Data_raw\Images\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
  filenameAutoL = ['D:\Research_Breast_Cancer\Data_raw\labels\',convertStringsToChars(string(T.Var1(k))),'_xmin',num2str(T.xmin(k)),'_ymin',num2str(T.ymin(k)),'_MPP-0.2500.png'];
 
 
  Imm=imread(filenameAutoI);
  IIa=imread(filenameAutoL);
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
    end
end

end

