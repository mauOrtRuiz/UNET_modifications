# UNET_modifications
In this research experiment, we explore different UNET architectures

The main goal of this experiment is to propose a modified UNET that might improve segmentation for multiclass breast cancer segmentation. We use images from the Breast Cancer Semantic Segmentation (BCSS) https://bcsegmentation.grand-challenge.org/

Previous work

UNET network is an optimal network for image semantic semgmentation presented by Ronnenberg in 2015. Is a network of deconvolutional type DNN in which the input image follows a set of encoder blocks followed by a decoder blocks.
The novelty of this type of network, is that it includes feature channels at the upsamping blocks that consist of direct connections at higher resoilution layers which makes the expansive path symmetric to the contracting path, which makes it with a U-type shape.

The network does not have fully connected layers and only uses convoilutional networks. From Ronnenberg UNET:



![Unet1](https://user-images.githubusercontent.com/44585823/212437526-5e6ab62c-b725-4bc6-a56a-f395f0640470.png)


Some work have been dono  with modifications to UNET. In the next references we will se how UNET has been improved.

1.  UNET with residual connections. Motivation: An increase in number of layers in deep network does not necesarily improves the network performance because a vanishing problem arises that affects convergence. This has been adressed by normalisation at initial and also at intermediate layers. However, when  deep network starts converging accuracy gets saturated and  a degradation arises, there is a  higher trainingerror when adding more layers. This indicates that not all systems are similrily easy to optimize [2]. A solution is done by residual blocks, in which added layers are identical from previous learned layers. This indicates that a deeper model produces no more training error


![Residual_block](https://user-images.githubusercontent.com/44585823/212440640-af958081-17d8-4dbb-b077-e4759b199669.png)

 
  Residual blocks were introduced into a UNET network by [3] for liver tumor segmentation which is a combination of UNET and short-range residual connection from ResNet. This network was ranked first at the LiTS Challenge at ISBI 2017 Conference with a Dice score of 0.67. The network architechture is shown the following figure, we can see that at every encoder level there is a residual conection.


![ResUnet1](https://user-images.githubusercontent.com/44585823/212437599-83a2d1dd-861d-43f9-9bd1-0d8abdfc61b6.png)



2.  RMS-UNET. This network is based in residual connections as well but it also includes added convolutions a different dilations, named Atrous convolution which is based in a 3x3 kernel convolution with different dilation rates. It was presented by [4]. In the next figure we can see dilation at rates of 1,2,4


![Dilation_Atrous](https://user-images.githubusercontent.com/44585823/212441494-a82f6890-b4ea-42c9-ad64-2d841cb9345a.png)


This opertion is used to increase the receptiove view of input images.  The network presented by Khan combines Atrous convolutions as well as residual connections and also was utilised for liver lesion segmentation. It was tested on 4 public availabnle datasets:  Dircadb, LiTS, Sliver07, and Chaos datasets, that outperformed previous results. The network proposed is the following



![RMS_UNET](https://user-images.githubusercontent.com/44585823/212442790-3eceee99-9e6e-41b1-bb58-e1feb01a630f.png)

4.- MultiResUNet.  A more profound study of UNET behaviour was presented by [5]. In this study Ibtehaz speculate that there exists a semantic gap between encoder and decoder at each level between the direct connection, which is part of UNET. In  the direct connection is replaced by the proposed Residual Path
![image](https://user-images.githubusercontent.com/44585823/212443264-81d12979-f096-4753-84a6-6b0e2c070ee2.png).

They also replace inception  module, with convolutions in parallel of sizes 3x3, 5x5 and 7x7 are replaced by a series set of 3x3 filters. The MultiRes block also includes a Resual connection
![image](https://user-images.githubusercontent.com/44585823/212484326-edd4d99a-9f5c-48c3-b094-879494862027.png)

Then the proposed network is called  Multi Res UNET, which can be seen in the following diagram
![image](https://user-images.githubusercontent.com/44585823/212443436-5afcb07b-4b8e-4d3c-89a0-fd0858aaf45a.png)

Multi Res UNET advantages presented by [5] are

a) It can obtain better results in less number of epochs
b) weak boundaries are better delineated
c) Is more immune to perturbations
d) MultiResUNet is more reliable against outliers






Modification analysis



![image](https://user-images.githubusercontent.com/44585823/214163041-30211124-8400-4ca7-9e5e-5740876aa8c1.png)



Batch size
Modification | Baseline|A | B | C | D |E |F |
--- | --- | --- | --- | --- |--- | --- |--- |
Test | UNET 3 depth | 3 input dilations DPB | 5 extended ditations DPB| DPB-at each level | Residual UNET |Residual UNET | Atrous in series| 

 ![](img src="https://user-images.githubusercontent.com/44585823/214160420-8eef85ba-0b0a-4601-a896-d213e07eaf39.png")| UNET 3 depth | 3 input dilations DPB | 5 extended ditations DPB| DPB-at each level | Residual UNET |Residual UNET | Atrous in series| 


[1] Ronneberger, O., Fischer, P., & Brox, T. (2015). U-Net: Convolutional Networks for Biomedical Image Segmentation. En N. Navab, J. Hornegger, W. M. Wells, & A. F. Frangi (Eds.), Medical Image Computing and Computer-Assisted Intervention – MICCAI 2015 (pp. 234-241). Springer International Publishing. https://doi.org/10.1007/978-3-319-24574-4_28

[2] He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep Residual Learning for Image Recognition. 2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 770-778. https://doi.org/10.1109/CVPR.2016.90

[3] Han, X. (2017). Automatic Liver Lesion Segmentation Using A Deep Convolutional Neural Network Method. ArXiv.Org. https://doi.org/10.1002/mp.12155

[4] Khan, R. A., Luo, Y., & Wu, F.-X. (2022). RMS-UNet: Residual multi-scale UNet for liver and lesion segmentation. Artificial Intelligence in Medicine, 124, 102231. https://doi.org/10.1016/j.artmed.2021.102231

[5] Ibtehaz, N., & Rahman, M. S. (2020). MultiResUNet: Rethinking the U-Net architecture for multimodal biomedical image segmentation. Neural Networks, 121, 74-87. https://doi.org/10.1016/j.neunet.2019.08.025


