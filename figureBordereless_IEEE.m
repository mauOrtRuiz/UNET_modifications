

figure(4)

 filenameImagenOriginal = ['D:\Research_Breast_Cancer\code\Results_august\Imagenes\Im_Original_Method_',convertStringsToChars(ka),'Class',num2str(clasen),'.png'];
 filenameImagenGT = ['D:\Research_Breast_Cancer\code\Results_august\Imagenes\Im_GT_Method_',convertStringsToChars(ka),'Class_',num2str(clasen),'.png'];
 
  

currAxPos = get(gca,'position');
if currAxPos(end) ==1
    set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);axis on
else
    set(gca,'position',[-0.07 0 1.2 1.2 ]);axis off
    %set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);
end

clear currAxPos


clear filename
gcf;
if ~exist('filename','var')
    filename='Mauaaa.png';
end
set(gcf,'PaperPositionMode','auto')
print('-dpng','-r300',filename)

pause
figure(5)


currAxPos = get(gca,'position');
if currAxPos(end) ==1
    set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);axis on
else
    set(gca,'position',[-0.07 0 1.2 1.2 ]);axis off
    %set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);
end

clear currAxPos


clear filename
gcf;
if ~exist('filename','var')
    filename='Example15GT.png';
end
set(gcf,'PaperPositionMode','auto')
print('-dpng','-r300',filename)

figure(6)


currAxPos = get(gca,'position');
if currAxPos(end) ==1
    set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);axis on
else
    set(gca,'position',[-0.07 0 1.2 1.2 ]);axis off
    %set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);
end

clear currAxPos


clear filename
gcf;
if ~exist('filename','var')
    filename='Example15comp.png';
end
set(gcf,'PaperPositionMode','auto')
print('-dpng','-r300',filename)




figure(3)


currAxPos = get(gca,'position');
if currAxPos(end) ==1
    set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);axis on
else
    set(gca,'position',[-0.07 0 1.2 1.2 ]);axis off
    %set(gca,'position',[  0.1300    0.1100    0.7750    0.8150 ]);
end

clear currAxPos


clear filename
gcf;
if ~exist('filename','var')
    filename='Example15HE.png';
end
set(gcf,'PaperPositionMode','auto')
print('-dpng','-r300',filename)

