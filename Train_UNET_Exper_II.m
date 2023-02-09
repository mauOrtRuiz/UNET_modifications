
%  This is the Train, Test and Validation data prepared for semantic
%  segmentation. The next routine is used to train a UNET for Semantic Segmentation
%  This is where GT data is
%outFolder='D:\Mauricio_daddy\Breast_Cancer_Det\MUIA_Breast_classif_A\Breast_Tissue_classif\Data\ROI_Tumor_Segmentation64';

outFolder='D:\Research_Breast_Cancer\data_out\January_Images';
% This is Train Data
imgDir = fullfile(outFolder,'images');
imds = imageDatastore(imgDir);

% This is Validation data
valDir = fullfile(outFolder,'Test_images');
imdsv = imageDatastore(valDir);

% This is Test Data
%TesDir = fullfile(outFolder,'Test_images');
%imdsTest = imageDatastore(TesDir);

classes = [
    "other"           %==1
    "tumor"           %==2  
    "stroma"          %==3
    "inflammatory"    %==4
    "necrosis"        %==5
    ];

pixelLabelID = [1 2 3 4 5];
cmap = camvidColorMapSS;

% This is Train Labels
labelDir = fullfile(outFolder,'labels');
pxds = pixelLabelDatastore(labelDir,classes,pixelLabelID);

% This is Validation Labels
labelDis = fullfile(outFolder,'Test_labels');
pxdss = pixelLabelDatastore(labelDis,classes,pixelLabelID);

% This is Test Labels
%labelDirt = fullfile(outFolder,'Test_labels');
%pxdsTest = pixelLabelDatastore(labelDirt,classes,pixelLabelID);


tbl = countEachLabel(pxds);

imdsTrain=imds;
imdsVal=imdsv;

pxdsTrain=pxds;
pxdsVal=pxdss;

numTrainingImages = numel(imdsTrain.Files);
numValImages = numel(imdsVal.Files);
numClasses = numel(classes);




imageFreq = tbl.PixelCount ./ tbl.ImagePixelCount;
classWeights = median(imageFreq) ./ imageFreq;

pxLayer = pixelClassificationLayer('Name','labels','Classes',tbl.Name,'ClassWeights',classWeights);






% Unet is defined
%imageSize = [64 64 3];
imageSize = [256 256 3];
numClasses = 5;

%next we follow UNET instructions from matlab help

%encoderDepth = 3;
load netII;
lgraph=netII;
%lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth)
%load addedNet4;
%lgraph=addedNet4;



ds = combine(imds,pxds);
%lgraph = deeplabv3plusLayers(imageSize, numClasses, "resnet18");
%lgraph = deeplabv3plusLayers(imageSize, numClasses, "resnet50");
%lgraph = deeplabv3plusLayers(imageSize, numClasses, "mobilenetv2");

% CHANGED DIC 2022
%lgraph = replaceLayer(lgraph,"classification",pxLayer);

pximdsVal = pixelLabelImageDatastore(imdsVal,pxdsVal);

options3 = trainingOptions('adam', ...
  'LearnRateSchedule','piecewise',...
  'LearnRateDropPeriod',10,...
  'LearnRateDropFactor',0.3,...
  'InitialLearnRate',1e-3, ...
  'L2Regularization',0.000, ...
  'ValidationData',pximdsVal,...
  'MaxEpochs',12, ...  
  'MiniBatchSize',8, ...
  'Shuffle','every-epoch', ...
  'CheckpointPath', tempdir, ...
  'VerboseFrequency',2,...
  'Plots','training-progress',...
  'ValidationPatience', 200);



doTraining = true;
if doTraining 
    disp(' It starts training...automated 1')
    [net, info] = trainNetwork(ds,lgraph,options3);
    net_Expe_II=net;
    save net_Expe_II net_Expe_II;
    info_net_Expe_II=info;
    save info_net_Expe_II info_net_Expe_II

   
else
   %load netUNET64e;
   %net=netUNET64e; 
end



