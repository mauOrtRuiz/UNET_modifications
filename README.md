# UNET_modifications
In this research experiment, we explore different UNET architectures

The main goal of this experiment is to propose a modified UNET that might improve segmentation for multiclass breast cancer segmentation. We use images from the Breast Cancer Semantic Segmentation (BCSS) https://bcsegmentation.grand-challenge.org/

Previous work

UNET network is an optimal network for image semantic semgmentation presented by Ronnenberg in 2015. Is a network of deconvolutional type DNN in which the input image follows a set of encoder blocks followed by a decoder blocks.
The novelty of this type of network, is that it includes feature channels at the upsamping blocks that consist of direct connections at higher resoilution layers which makes the expansive path symmetric to the contracting path, which makes it with a U-type shape.

The network does not have fully connected layers and only uses convoilutional networks. From Ronnenberg UNET:



![Unet1](https://user-images.githubusercontent.com/44585823/212437526-5e6ab62c-b725-4bc6-a56a-f395f0640470.png)


Some work have been dono  with modifications to UNET. In the next references we will se how UNET has been improved.

1.  UNET with residual connections. A residual block has been used and it has been demostrated its superiority. An increase in number of layers in deep network does not necesarily improves performance becauyse a vanishiong problem arises that affects convergence. This has been adressed by normalisation at initial and also at intermediate layers. However, wher  deep network starts converging accuracy gets saturated and  a degradation arises when rises. Then higher training error arises when adding more layers. 
 
  
    was introduced into a UNET network by [2] for liver tumor segmentation which is a combination of UNET and short-range residual connection from ResNet. This network was ranked first at the LiTS Challenge at ISBI 2017 Conference with a Dice score of 0.67. The network architechture is shown the following figure, we can see that at every encoder level there is a residual conection.


![ResUnet1](https://user-images.githubusercontent.com/44585823/212437599-83a2d1dd-861d-43f9-9bd1-0d8abdfc61b6.png)



2.  






[1] Ronneberger, O., Fischer, P., & Brox, T. (2015). U-Net: Convolutional Networks for Biomedical Image Segmentation. En N. Navab, J. Hornegger, W. M. Wells, & A. F. Frangi (Eds.), Medical Image Computing and Computer-Assisted Intervention – MICCAI 2015 (pp. 234-241). Springer International Publishing. https://doi.org/10.1007/978-3-319-24574-4_28
[2] He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep Residual Learning for Image Recognition. 2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 770-778. https://doi.org/10.1109/CVPR.2016.90

[3] Han, X. (2017). Automatic Liver Lesion Segmentation Using A Deep Convolutional Neural Network Method. ArXiv.Org. https://doi.org/10.1002/mp.12155
