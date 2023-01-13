# UNET_modifications
In this research experiment, we explore different UNET architectures

The main goal of this experiment is to propose a modified UNET that might improve segmentation for multiclass breast cancer segmentation. We use images from the Breast Cancer Semantic Segmentation (BCSS) https://bcsegmentation.grand-challenge.org/

Previous work

UNET network is an optimal network for image semantic semgmentation presented by Ronnenberg in 2015. Is a network of deconvolutional type DNN in which the input image follows a set of encoder blocks followed by a decoder blocks.
The novelty of this type of network, is that it includes feature channels at the upsamping blocks that consist of direct connections at higher resoilution layers which makes the expansive path symmetric to the contracting path, which makes it with a U-type shape.

The network does not have fully connected layers and only uses convoilutional networks. From Ronnenberg UNET:


![Unet1](https://user-images.githubusercontent.com/44585823/212410421-2416cec5-c912-4d80-a4dc-2e05cc2489a3.png)

Some work have been presented with modifications to UNET.

1.  UNET with residual connections.

A residual block has been used and it has been demostrated its superiority [Reference Jasmin]
