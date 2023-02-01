# Modified UNET
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
c) Is more immune to perturbations!
d) MultiResUNet is more reliable against outliers





![15_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907587-908ce960-4b7d-4b4a-8b22-4bb77ee80885.png)
![1_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907588-da76f074-e1c9-43d5-9b84-20461e726117.png)
![1_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907590-629a43f2-7e37-4b71-af49-17604df7d6c7.png)
![2_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907591-8921849e-8aa0-4828-8455-8a3c2546fefe.png)
![2_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907593-c4909b68-c05a-4dce-956f-c6aead358a8e.png)
![3_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907595-3a389efb-5405-4bf0-a72f-3c9ce69592bf.png)
![3_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907596-d08e7424-d482-4664-8211-2cb273964cef.png)
![4_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907597-68abbf86-15b8-4210-a0e7-1214f716ba1f.png)
![4_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907599-c799de51-3d75-429d-9c86-4f9a7459fdaf.png)
![5_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907600-567bab1b-a9a1-4903-b42d-360a4ff8cd46.png)
![5_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907603-76865cf8-b8f6-41c5-8e2d-c366f6ac26d8.png)
![6_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907605-ec8975a0-ef53-48b6-b05d-e0b0961ce12c.png)
![6_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907606-0b9dd051-2b6b-4c87-a97a-2278d54b7f7e.png)
![7_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907607-6100b241-669c-4dae-81bf-09f716adbf2f.png)
![7_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907610-a21b5a95-1ef4-4332-929c-7aa6ded26fa4.png)
![8_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907612-f5363f45-931a-4adc-9333-aeda8316dd98.png)
![8_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907613-104594fc-3c15-4b8b-8edb-3c2bcaee7bae.png)
![9_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907614-148a8d94-b6cc-479e-9983-05935139fe43.png)
![9_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907615-166918eb-3516-424b-a576-50218f76f4a5.png)
![10_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907616-6f1f420f-fdd0-4051-96b3-47b8bd215c69.png)
![10_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907618-a7c1bd0c-c9fa-47e4-b341-12a5387b1ccd.png)
![11_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907619-843b6773-8d68-4166-8e6b-666ad3ce9705.png)
![11_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907621-c0aab19b-c9a5-4ae9-a3f6-4ca083bb6078.png)
![12_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907622-1a7fdcf1-8385-4652-8ef7-a0a7559a3319.png)
![12_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907624-f3e9948c-0c85-4eed-a272-bbc983909d1b.png)
![13_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907625-582bc0b3-9d30-42fd-aaf4-e601e85a2c62.png)
![13_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907626-084c4bb9-5144-445c-b73d-7da57ac7f431.png)
![14_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907629-65b1d6ac-ddad-44ee-ae3e-74281cd69089.png)
![14_UNET_AtrousRes_P2P](https://user-images.githubusercontent.com/44585823/215907630-e1cddb04-f935-40bb-ba3a-f2b7f9025888.png)
![15_UNET_AtrousRes](https://user-images.githubusercontent.com/44585823/215907631-f6cd86ce-88d5-4d30-995a-ba25590313f9.png)







![15_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235902-f26277fd-3072-436e-b51d-af8b9fca0521.png)
![1_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235904-6d409e0d-935e-4c3f-a44b-546b6724e2cb.png)
![1_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235905-916c1c89-e959-4fdf-a252-46b7079e49be.png)
![2_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235906-d9ed90a3-de0a-44f0-9352-2e9e2a1594fe.png)
![2_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235907-7741c0cc-54ef-41f4-9a32-abc368acecea.png)
![3_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235909-417df29f-866d-4b33-9bb3-e73c111941a6.png)
![3_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235910-76d0ccdc-7ae2-4564-82a6-b9b395dcdf1a.png)
![4_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235911-a0a9e934-485a-445b-8980-a7ea8ba661fa.png)
![4_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235912-9be856f5-61d4-4553-abd2-e8a6ba7fe1bd.png)
![5_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235913-d1ba97ba-83b0-4921-85cd-603401f3dfd0.png)
![5_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235914-11b119ed-f4fd-4358-8829-a8ab4cff1a73.png)
![6_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235915-690a6b2a-65dd-42a7-967e-70e8899319b0.png)
![6_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235916-79e184ed-6495-4e63-8282-389a22ac30a2.png)
![7_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235917-db54695e-7b83-4b21-adc2-01c8ac013e2f.png)
![7_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235920-b0b1ca03-a7ef-4438-8629-43f35804c70e.png)
![8_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235921-37b85f0c-0d6e-4345-8445-ec6408e111b4.png)
![8_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235924-631b3a7d-01c7-4531-a705-4245e536c650.png)
![9_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235925-6c01a654-e1c1-4cd1-95c5-9733ca1c52da.png)
![9_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235926-bcf9eff5-33ef-482d-9378-172c74de2e80.png)
![10_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235927-82f73256-7b41-4ae0-b9e4-9940bd65be61.png)
![10_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235930-f4d70bf9-0a9f-4055-a0a2-7d806f013cd8.png)
![11_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235931-e50667dd-4c21-482e-a211-63246cb79934.png)
![11_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235932-5d1e1f99-71ac-409e-8ed9-352e1892d0d2.png)
![12_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235933-1063e4f7-579b-4b1b-836f-9a9f7204586b.png)
![12_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235934-a440ba3a-9b6b-438e-b8ca-ae40c2c05492.png)
![13_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235935-0c23007b-1dfb-4b14-9272-a25c13841fd5.png)
![13_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235936-ce8d2b4d-50dc-42a7-8977-e49865304e5a.png)
![14_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235937-cff55c64-5658-41e1-9575-c3f31c047e51.png)
![14_UNET_Atrous_series_3P2P](https://user-images.githubusercontent.com/44585823/215235938-77b7a106-e75e-4167-804d-7f943564a5c8.png)
![15_UNET_Atrous_series_3](https://user-images.githubusercontent.com/44585823/215235939-8b496eb5-eb0c-4114-b901-c67794332c2a.png)




![15_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235803-ad3d187f-abd9-4027-a347-620dbc84a4ab.png)
![15_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235804-c409f603-0d36-4cad-b4fa-00ae9d711828.png)
![1_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235805-7a3a910f-1bb7-4235-9aab-49341817746f.png)
![1_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235806-b0dcb406-3814-4bbc-843d-d4b4718907ff.png)
![2_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235808-82f3680a-7ce8-487a-a8e5-1afab9e3711c.png)
![2_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235809-2a272176-e23f-4665-a900-371b868d6498.png)
![3_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235810-eda4c36d-d66f-4e7b-afe9-a6b7b4ced9fd.png)
![3_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235811-ab751b1b-9915-4bea-874a-943c2df0b1cc.png)
![4_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235812-762e27f1-f635-4aff-bfa8-89aaa1604c5a.png)
![4_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235813-90233233-620d-4f39-ba9e-df3d2e76867d.png)
![5_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235815-636a7be6-2cce-4549-ba85-fc3887215ef0.png)
![5_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235816-adda9755-3119-492a-82c5-15c2b89919dc.png)
![6_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235818-b2d5725d-77ab-42c9-b697-ceb7d9da0d9e.png)
![6_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235819-fecffdb0-3bf0-4437-b7f3-32c73569fcd8.png)
![7_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235821-dc82f072-444c-414f-84e0-911cb9c9e59d.png)
![7_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235822-fef1e29e-e7dd-44b5-b577-1345cc12367c.png)
![8_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235823-98dda3a7-2d87-4fec-acfa-cba6719bdb70.png)
![8_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235824-cf1fa5c2-cf6b-4407-b6e8-e1b821676e2d.png)
![9_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235825-2325b84f-b286-4878-ab5d-d67068610aa8.png)
![9_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235826-9caa377b-575e-4ac3-afa1-40739611587d.png)
![10_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235827-d0c12f54-297f-41ab-97bb-34932c7f0260.png)
![10_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235828-9daad9da-ea26-4c56-baec-da5348a2a7f1.png)
![11_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235829-f2cd8287-4f76-49b3-a33f-30be5586d969.png)
![11_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235831-2ba3ffbd-71a5-44bb-8516-8122367bdd16.png)
![12_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235832-cc2c0918-06ac-4521-b68d-11163146f17e.png)
![12_UNET_FullDilat](https://user-images.githubusercontent.com/44585823/215235833-04951b13-1674-4bf5-8720-36e0a7b87ca4.png)
![13_UNET_5_FullDilate](https://user-images.githubusercontent.com/44585823/215235835-02f8466f-cc83-4fbe-babc-242ab6f815a3.png)
![13_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235837-503adcd6-611a-4180-833a-55ae280e29ba.png)
![14_UNET_5_FullDilate](https://user-images.githubusercontent.com/44585823/215235838-f4d2a99d-8d79-4c08-8b3a-15637eb73337.png)
![14_UNET_5_FullDilateP2P](https://user-images.githubusercontent.com/44585823/215235839-1b321156-ed1b-4874-a236-49fb16d630be.png)










![2_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124967-6e03b03a-d3ea-4001-85bd-a562836f43b4.png)
![2_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124973-2db27a96-aa74-4a64-b062-e028bd349aa9.png)
![3_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124974-c1370ada-f63a-4030-b7b0-1b0b60554150.png)
![3_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124976-de3367ec-a821-43ca-9a33-8c142b1b839d.png)
![4_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124979-444d2252-49de-4649-8906-7df9b3d0e8de.png)
![4_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124982-559e3820-946c-495a-a688-ab29bb0eed7f.png)
![5_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124985-4622ca78-bb98-4093-b9fa-71a1d1bed2b7.png)
![5_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124986-b8975ca2-9be6-4946-ab82-789e57848981.png)
![6_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124988-f33de0a9-c10c-4e2a-9852-1eb302adedf3.png)
![6_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124992-119d29fe-c00c-4061-b05b-7f61097027dc.png)
![7_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124993-b3d4da59-bd79-4a9f-9314-72ff6222a00a.png)
![7_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124995-4fae9a0c-dc48-4e28-9705-95157bb7ba5f.png)
![8_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124996-fc4d41b6-3af4-46ac-853b-7b44c3ee2c13.png)
![8_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216124997-ec011600-8b85-42f0-b083-7ba1d4fd1abc.png)
![9_UNET_FResi](https://user-images.githubusercontent.com/44585823/216124999-21e225e9-b583-42ef-ab72-817be41d19d4.png)
![9_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125001-ee37399a-5cbf-499f-966b-02060203f4a1.png)
![10_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125003-5f5cd764-1f84-45d9-9d6d-94de56cd9f41.png)
![10_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125005-3460fb71-11e4-47ee-b23e-2a143915fd85.png)
![11_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125008-86437e45-0c8f-4522-8698-52aacec1e0d0.png)
![11_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125010-be49d207-c719-4754-a9dc-7b5fcdcfe323.png)
![12_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125012-69f25b35-4e8a-4927-8a60-f4089c3014c1.png)
![12_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125014-302a9dc8-bce8-435b-98fa-762493dd03b8.png)
![13_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125016-b52339a0-f1d1-431f-84c5-fbd280f65ae2.png)
![13_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125018-31d40e34-e1ee-4999-8368-afc100ee7fd8.png)
![14_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125020-e7aae149-c448-4324-a417-8bb0eab95a8c.png)
![14_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125026-dae4d9c6-2db8-4b53-8387-24a34ca3e8be.png)
![15_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125027-a802ce8f-4d3c-4d8b-aa87-cc31739a58a3.png)
![15_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125028-ccf7230d-1394-4f1c-aca8-209d86d67d27.png)
![1_UNET_FResi](https://user-images.githubusercontent.com/44585823/216125030-bbf8260d-2bf8-471b-af1f-8a430747b8a6.png)
![1_UNET_FResiP2P](https://user-images.githubusercontent.com/44585823/216125034-c0eafd25-8ac9-4329-bb2e-a7d144e45733.png)






Segmentation results
No |Original | Ground-Truth|UNET Depth-3 | UNET DPB-3 at Input| UNET DPB-5 at Input | DPB-3 at each level |E | F|
--- | --- | --- | --- | --- |--- | --- |--- |--- |
 |  | Original | GT |UNET Depth-3 |UNET DPB-3 at Input |UNET DPB-5 at Input | DPB-3 at each level| DPB-at each level|
 1 | <img src="https://user-images.githubusercontent.com/44585823/214163041-30211124-8400-4ca7-9e5e-5740876aa8c1.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214166505-3c635ab5-84fd-4660-83a7-df9d839c7e72.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214175136-35ba6974-7d05-4155-9676-56776b09f358.png" width="90" height="60"> | <img src="https://user-images.githubusercontent.com/44585823/214448151-07530146-d408-4846-8574-82c659ef20aa.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214729267-dfea7063-9056-40f6-a47e-160c401c5c3c.png" width="90" height="60"> | <img src="https://user-images.githubusercontent.com/44585823/214990028-9d51b222-ee37-413e-9b9a-ab86eb51037d.png" width="90" height="60"> |Residual UNET | Atrous in series| 
2 | <img src="https://user-images.githubusercontent.com/44585823/214182562-ce938393-0e24-4cd0-8675-b21d53a34d84.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214183275-c1393987-ab02-42d6-80a4-03c917d24f70.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214184412-f656745c-fa4d-42a9-90cd-81c2b4e826de.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214450294-85583997-0047-46ba-9e95-0900300a8039.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214729270-9e53bf61-0248-4068-b41e-a80c98904ad3.png" width="90" height="70"> |<img src="https://user-images.githubusercontent.com/44585823/214990032-e08cd1e8-1409-4606-8dc6-ac814dc76b01.png" width="90" height="70"> |Residual UNET | Atrous in series| 
3 | <img src="https://user-images.githubusercontent.com/44585823/214186850-c928a042-2557-44e7-bd88-53bb1da6fd82.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214186890-88809b8f-c9ae-47eb-b226-3c6afd300179.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214186956-fb47fda8-fb34-4d78-b342-ae52c4d06ae6.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214617089-4299237d-191c-4df4-8bd2-26bb467d2e59.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214729274-012402fc-fbad-4430-a5ab-a734686618d6.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214990042-17733bee-1703-47c8-905f-26e7a4955b42.png" width="90" height="50"> |Residual UNET | Atrous in series| 
4 | <img src="https://user-images.githubusercontent.com/44585823/214189550-6839bc39-2c43-4c32-bef5-82f0a5ca851d.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214189546-865825c5-36a1-4cfe-a3da-b1ea43429614.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214189552-ca49ce81-6d3c-443c-a309-c7021d44ca63.png" width="60" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214617094-4b3d0d1f-c4ee-4c47-9262-4dbc86b09f51.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214729278-96cfe5d3-64e8-431b-abb7-c49471d016d7.png" width="60" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214990052-168fbd9c-46a6-4a32-878a-cec0e72f0224.png" width="60" height="90"> |Residual UNET | Atrous in series| 
5 | <img src="https://user-images.githubusercontent.com/44585823/214191679-da4d09c2-0247-455b-97fb-125c85a610d5.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214191677-cbd4889f-78d9-4b72-95d1-0e62fa3e46b5.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214191681-82776e2a-0386-4251-bcb1-55f9751ac919.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214617103-0045e9d2-e292-4a5b-b969-f1612492095e.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214729280-668d7990-1af1-48a0-8de6-e0b11242baf4.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214990076-5087cc91-cb72-4c37-a0fa-ef9ee187e97c.png" width="90" height="90"> |Residual UNET | Atrous in series| 
6 | <img src="https://user-images.githubusercontent.com/44585823/214192636-ae3e0c0e-a682-453b-82d7-3073cb6b7b53.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214192635-88de5fd9-7250-4b0a-a61c-b579ef64d289.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214192637-ef1ab476-160f-4341-876f-889c328dc881.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214617109-0eff1d48-7996-43c1-868a-d8a3063dee5c.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214729282-f436f363-9b64-44da-ab69-313dc4b2fb47.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214990068-d2f38c55-0fdf-4474-93f6-3eb951637076.png" width="90" height="35"> |Residual UNET | Atrous in series| 
7 | <img src="https://user-images.githubusercontent.com/44585823/214194275-091fbf10-910e-478c-a7ac-2ca8787b2465.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214194273-1941cd91-6bcf-44a4-90db-32dd6fae9a47.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214194276-00aa48d1-d39f-4017-a66c-5b6b55ac9d9d.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214617115-4f019ade-fa10-4824-9e6b-011f8b526ddb.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214729287-f8053e43-be03-49b4-870e-a7a522b538b5.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214990073-be85a65c-42dd-4d1f-919e-948c2c8a68bb.png" width="90" height="50"> |Residual UNET | Atrous in series| 
8 | <img src="https://user-images.githubusercontent.com/44585823/214346151-66999704-dbd0-486e-b6d7-a279b16d463b.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214346149-f26fbe30-3111-4754-ba2a-65dd52a5d7b5.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214346154-f26de91e-94ed-4209-b439-4f338c24f0c9.png" width="90" height="40"> | <img src="https://user-images.githubusercontent.com/44585823/214617122-5ce6a774-7c86-4493-8877-4dd9b81a524d.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214729289-fbeaa4c9-0804-4d8d-a790-93bcef49b0a9.png" width="90" height="40"> |<img src="https://user-images.githubusercontent.com/44585823/214990076-5087cc91-cb72-4c37-a0fa-ef9ee187e97c.png" width="90" height="40"> |Residual UNET | Atrous in series| 
9 | <img src="https://user-images.githubusercontent.com/44585823/214347796-17c6d210-54a0-4954-99e5-62a64ee2d2fa.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214347793-47266dbe-96c2-4ace-b4d5-afcbea2ed336.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214347798-a9097a5e-ace2-4205-9523-a9f1d060f27c.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214617130-487e42ef-e4b1-49b8-a193-a84b2fbef23c.png" width="90" height="35">| <img src="https://user-images.githubusercontent.com/44585823/214729293-c034acee-ac4e-4df6-9d5c-77dd7b40ddfc.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214990081-9af94b4d-edff-42f3-a8d8-cbba26186b9e.png" width="90" height="35"> |Residual UNET | Atrous in series| 
10 | <img src="https://user-images.githubusercontent.com/44585823/214348696-34c3fc9a-1d46-414d-bdc9-8813911fc966.png" width="90" height="75">| <img src="https://user-images.githubusercontent.com/44585823/214348690-55b3ad27-2999-4f3f-b07c-b42fe5df6452.png" width="90" height="75">| <img src="https://user-images.githubusercontent.com/44585823/214348698-f7e55164-d96b-4ea4-ac3a-e0a5aff42a31.png" width="90" height="75"> | <img src="https://user-images.githubusercontent.com/44585823/214617134-77485e69-998b-4cd6-9458-2dfe6209a8d0.png" width="90" height="75">| <img src="https://user-images.githubusercontent.com/44585823/214729295-fd340ade-7c61-4eac-ab88-8c4c0115a214.png" width="90" height="75"> | <img src="https://user-images.githubusercontent.com/44585823/214990086-e0bbcb90-3919-4964-b223-d6e4c9a6268f.png" width="90" height="75"> |Residual UNET | Atrous in series|
11 | <img src="https://user-images.githubusercontent.com/44585823/214349786-52fa504b-70aa-4d54-a576-db3408ccb66d.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214349782-a3d4e132-9b64-48e0-a779-c1d0c15753f8.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214349787-4ab3177b-5a34-4196-94e7-fe3db1a9c8a9.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214617139-86619503-3d3e-472d-9469-52189a57a886.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214729298-5ef07697-1002-42e9-9e7d-8efa0048039e.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214990092-85e98eb4-21de-48be-974d-cd5f82c84345.png" width="90" height="90"> |Residual UNET | Atrous in series|
12 | <img src="https://user-images.githubusercontent.com/44585823/214352075-282ddd09-e123-4ab4-bb98-8a253d528b36.png" width="90" height="30">| <img src="https://user-images.githubusercontent.com/44585823/214352070-07b303b2-70fc-4d7e-b919-788351bf1e0e.png" width="90" height="30">| <img src="https://user-images.githubusercontent.com/44585823/214352076-dd1c49c3-9900-4adc-a968-2a5aef513138.png" width="90" height="30"> | <img src="https://user-images.githubusercontent.com/44585823/214617142-c85384e5-2e96-4855-8e0d-113be9a7f745.png" width="90" height="30">| <img src="https://user-images.githubusercontent.com/44585823/214729302-641ae32c-b86d-473b-b3ae-58d5233db281.png" width="90" height="30"> | <img src="https://user-images.githubusercontent.com/44585823/214990099-44feb362-0441-44cf-85b5-a0528e6775a5.png" width="90" height="30"> |Residual UNET | Atrous in series|
13 | <img src="https://user-images.githubusercontent.com/44585823/214353016-308aa5ae-a81d-418b-b350-652204b5efb6.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214353013-d4591a35-aa8f-487e-ac75-b228a0abe77f.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214353018-3302134a-3fb7-48ab-8030-6538dbb6def0.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214617152-7bc7ff7c-90fe-4fc0-b328-7824c3c3d38d.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214729311-7003255c-1a40-43d5-a6db-55e948f76a19.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214990104-4bf64339-97f5-4b5b-ab84-01f051f8c1b2.png" width="90" height="70"> |Residual UNET | Atrous in series|
14 | <img src="https://user-images.githubusercontent.com/44585823/214353775-1eb4aed0-dfea-47bd-8aaa-5f7dfe31d135.png" width="55" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214353771-ff2a086f-20ef-42d0-a1a5-ed9edc8b08fc.png" width="55" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214353780-83debfb7-ac37-4b18-b4ae-b56bc08ccdb9.png" width="55" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214617155-db941807-3f5c-4e98-889d-b58ffd561efa.png" width="55" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214729315-0471919f-2a9a-49d7-8b6f-14e2a3fd5dbd.png" width="55" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214990108-05a1b24f-568c-4c67-9397-cd25506dda01.png" width="55" height="90"> |Residual UNET | Atrous in series|
15 | <img src="https://user-images.githubusercontent.com/44585823/214354884-af304950-7100-438d-acab-c31892e1a358.png" width="70" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214354880-81ab25c6-6141-400f-8bde-962bae302bea.png" width="70" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214354887-fd2b9300-c192-43fe-95df-9324fe11588c.png" width="70" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214617083-3d159c4d-7070-4c80-8ef4-c8a677a388c4.png" width="70" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214729264-d709db71-f41c-4c69-914a-b43fd177e2c3.png" width="70" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214990022-5cca4b33-0bd8-4f14-9aa2-5ed6bd523c90.png" width="70" height="90"> |Residual UNET | Atrous in series|








Segmentation results Pixel to pixel
No |Original |UNET Depth-3 | UNET DPB-3 at Input| UNET DPB-5 at Input | DPB-3 at each level | D |E | F|
--- | --- | --- | --- | --- |--- | --- |--- |--- |
  | |   |  |  |  |  |  |
 1 | <img src="https://user-images.githubusercontent.com/44585823/214163041-30211124-8400-4ca7-9e5e-5740876aa8c1.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214176752-3f90545f-741a-4e50-a98d-9ba14b48d3ee.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214448153-9db175c6-d627-4c49-a8b1-40a0264d378d.png" width="90" height="60"> | <img src="https://user-images.githubusercontent.com/44585823/214729268-ee78fcc3-1904-4daf-b50e-1415505c6617.png" width="90" height="60">| <img src="https://user-images.githubusercontent.com/44585823/214990025-a7dd4f73-1c02-46ae-a386-1d12de712de1.png" width="90" height="60">| Residual UNET |Residual UNET | Atrous in series| 
  |  |  |0.8499|0.8443|0.8456|0.8441| | |
2 | <img src="https://user-images.githubusercontent.com/44585823/214182562-ce938393-0e24-4cd0-8675-b21d53a34d84.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214185506-007ae6f7-102d-4ea2-a1d0-ce609fea814e.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214450300-28eaddf4-75b0-4343-a58e-d10912ddac9d.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214729271-fa194804-6960-4e3b-b552-d6a25b71ddbe.png" width="90" height="70">| <img src="https://user-images.githubusercontent.com/44585823/214990029-dca8286c-343a-4aea-88c9-5ab3aeed0031.png" width="90" height="70"> | Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.7864|0.7836|0.7299|0.8053| | |
3 | <img src="https://user-images.githubusercontent.com/44585823/214186850-c928a042-2557-44e7-bd88-53bb1da6fd82.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214187052-8a11059e-a1e6-4027-a502-e7cb8f370aa7.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214617091-bb004eca-21b0-4511-af52-68eb3d8480a3.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214729277-6a03fabd-5d23-459b-a72b-7f308aa72f1b.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214990038-1f62924e-40c6-457a-b0d5-1cfa5082df2f.png" width="90" height="50"> | Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.8171|0.8384|0.8056|0.7867| | |
4 | <img src="https://user-images.githubusercontent.com/44585823/214189550-6839bc39-2c43-4c32-bef5-82f0a5ca851d.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214189532-f1fdc8b2-e888-432e-b8af-40259f18ccc8.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214617100-7b91ccfa-360b-4e3a-80d2-df6b1fa260a6.png" width="60" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214729279-453d5a40-fcb7-4c80-8fbf-d03b4fe1f019.png" width="60" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214990051-11ab47e8-0e0f-467b-a505-6afbe33877f4.png" width="60" height="90">| Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.6801|0.6221|0.7288|0.6250| | |
5 | <img src="https://user-images.githubusercontent.com/44585823/214191679-da4d09c2-0247-455b-97fb-125c85a610d5.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214191676-9ef192ef-8063-42e2-88ed-cefd782ec826.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214617106-45902434-583c-40b1-8989-815837aae344.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214729281-02bda428-75bc-467d-b8c3-033d3d3b28b7.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214990057-d943c875-b60a-44d4-b3e4-4400a9a2f911.png" width="90" height="90"> | Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.8426|0.8699|0.8776|0.8614| | |
6 | <img src="https://user-images.githubusercontent.com/44585823/214192636-ae3e0c0e-a682-453b-82d7-3073cb6b7b53.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214192633-8a8f34cc-02f8-456c-abc0-a386c6b0f6b3.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214617112-82bea6d9-acd9-4c98-bf75-20a22e48683f.png" width="90" height="40"> | <img src="https://user-images.githubusercontent.com/44585823/214729283-1cc338aa-c41f-4451-98d3-1aa0fa811e27.png" width="90" height="40">| <img src="https://user-images.githubusercontent.com/44585823/214990067-e442cad1-5c15-42db-a95d-6ebf2fd2348e.png" width="90" height="40"> | Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.7729|0.7604|0.7783|0.7675| | |
7 |<img src="https://user-images.githubusercontent.com/44585823/214194275-091fbf10-910e-478c-a7ac-2ca8787b2465.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214194271-2a2acbd6-9df2-4ea5-98d0-dc0b04ad7e1e.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214617118-8c980271-4d6c-4d2f-b616-14daedf60bb0.png" width="90" height="50"> | <img src="https://user-images.githubusercontent.com/44585823/214729288-f81f3015-0436-47c1-97b6-e06feaae69da.png" width="90" height="50">| <img src="https://user-images.githubusercontent.com/44585823/214990070-02cc68a1-30b0-4e51-bd10-e1a50da9ca7a.png" width="90" height="50">| Residual UNET |Residual UNET | Atrous in series| 
 |  |  |0.7775|0.8346|0.8528|0.8386| | |
8 |<img src="https://user-images.githubusercontent.com/44585823/214346151-66999704-dbd0-486e-b6d7-a279b16d463b.png" width="90" height="40"> |<img src="https://user-images.githubusercontent.com/44585823/214346146-3c53929e-d18e-4501-9b46-cf853d31e9f5.png" width="90" height="40"> | <img src="https://user-images.githubusercontent.com/44585823/214617127-1571950f-44db-43d4-b586-e6d37c17ba7c.png" width="90" height="40"> | <img src="https://user-images.githubusercontent.com/44585823/214729291-81eee966-2cc7-480d-ad18-3dbe559e021c.png" width="90" height="40"> |<img src="https://user-images.githubusercontent.com/44585823/214990075-a6b11243-f474-4845-ba6a-660bbfd8022c.png" width="90" height="40"> | Atrous in series| 
 |  |  |0.7866|0.7746|0.8139|0.7800| | |
9 |<img src="https://user-images.githubusercontent.com/44585823/214347796-17c6d210-54a0-4954-99e5-62a64ee2d2fa.png" width="90" height="35"> |<img src="https://user-images.githubusercontent.com/44585823/214347787-1ce4b760-aa0f-40a3-991b-06491c4fe664.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214617131-00f26598-5374-48fc-b39a-c897e7451e66.png" width="90" height="35"> | <img src="https://user-images.githubusercontent.com/44585823/214729294-7b508ab1-d7ce-4639-93f3-079ed204683d.png" width="90" height="35"> |<img src="https://user-images.githubusercontent.com/44585823/214990079-879b094d-fc28-4fe6-9b4f-f34a3751a2c3.png" width="90" height="35"> | Atrous in series| 
 |  |  |0.8384|0.7617|0.8073| 0.8645| | |
10 |<img src="https://user-images.githubusercontent.com/44585823/214348696-34c3fc9a-1d46-414d-bdc9-8813911fc966.png" width="90" height="75"> |<img src="https://user-images.githubusercontent.com/44585823/214348685-343446c8-811e-4671-85a9-d47049e4c4f8.png" width="90" height="75"> | <img src="https://user-images.githubusercontent.com/44585823/214617137-9b7d6f72-34b7-41a8-a8e2-553ed0cdf838.png" width="90" height="75"> | <img src="https://user-images.githubusercontent.com/44585823/214729297-1f8f7c4d-8038-440c-b75b-3452e6c27b56.png" width="90" height="75">  |<img src="https://user-images.githubusercontent.com/44585823/215235579-a46aff07-f52d-4ff4-b078-0112397b30e4.png" width="90" height="75">| Atrous in series| 
 |  |  |0.8628| 0.7985|0.8302|0.8701| | |
11 |<img src="https://user-images.githubusercontent.com/44585823/214349786-52fa504b-70aa-4d54-a576-db3408ccb66d.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214349779-facba38f-387b-4500-88c0-a765663b80dd.png" width="90" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214617140-20eb214a-f156-4d3f-a4ea-86fcdf4b9a7d.png" width="90" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214729299-b07fd279-947e-4aa2-9843-e3135d39927d.png" width="90" height="90"> |<img src="https://user-images.githubusercontent.com/44585823/214990089-8a799af5-c853-4eba-866c-c40cd65c4ed5.png" width="90" height="90"> | Atrous in series| 
 |  |  |0.8375|0.8179|0.8076|0.8391| | |
12 |<img src="https://user-images.githubusercontent.com/44585823/214352075-282ddd09-e123-4ab4-bb98-8a253d528b36.png" width="90" height="30"> | <img src="https://user-images.githubusercontent.com/44585823/214352066-f227be59-2c02-4d3a-b735-9149289a7d1e.png" width="90" height="30">| <img src="https://user-images.githubusercontent.com/44585823/214617146-20c327b3-d709-4229-a6ca-7fd14bd4ca87.png" width="90" height="30"> | <img src="https://user-images.githubusercontent.com/44585823/214729304-c127f4fc-34f1-4321-bbd2-25727dda4e7f.png" width="90" height="30"> |<img src="https://user-images.githubusercontent.com/44585823/214990097-bb05f94f-5f28-4768-a9e4-581d013f2fe5.png" width="90" height="30"> | Atrous in series| 
 |  |  |0.8139|0.8219|0.8025|0.8113| | |
13 |<img src="https://user-images.githubusercontent.com/44585823/214353016-308aa5ae-a81d-418b-b350-652204b5efb6.png" width="90" height="70"> |<img src="https://user-images.githubusercontent.com/44585823/214353008-ec4a80d6-5130-477e-a122-697d8e259b98.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214617154-edcc42ca-35f7-4a49-8831-9bc7aa376ab9.png" width="90" height="70"> | <img src="https://user-images.githubusercontent.com/44585823/214729314-22748526-8b35-4fde-a5ba-263a422fa6b4.png" width="90" height="70"> |<img src="https://user-images.githubusercontent.com/44585823/214990101-2d833675-93c9-4ba7-842b-0d9c81b7521b.png" width="90" height="70"> | Atrous in series| 
 |  |  |0.7046|0.7614|0.7468|0.7410| | |
14 |<img src="https://user-images.githubusercontent.com/44585823/214353775-1eb4aed0-dfea-47bd-8aaa-5f7dfe31d135.png" width="55" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214353770-01a182c3-5bd5-46a1-b77a-c37192effeb2.png" width="55" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214617159-615f9ec0-2eca-4fbb-a9e2-64ca10b6341d.png" width="55" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214729317-a6672d3d-5e41-468d-81bf-a6338b9653e4.png" width="55" height="90"> |<img src="https://user-images.githubusercontent.com/44585823/214990106-0f339872-9068-4cfc-8b55-e18f4e96e129.png" width="55" height="90"> | Atrous in series| 
 |  |  |0.7539|0.7562|0.7412|0.8392| | |
15 |<img src="https://user-images.githubusercontent.com/44585823/214354884-af304950-7100-438d-acab-c31892e1a358.png" width="70" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214354877-c7685967-3873-4278-b132-bbc0edff24f5.png" width="70" height="90">| <img src="https://user-images.githubusercontent.com/44585823/214617088-9fb5dc0c-1ea6-464f-8cb3-8f7739e05e4b.png" width="70" height="90"> | <img src="https://user-images.githubusercontent.com/44585823/214729266-a301ccbb-bbb8-474e-833a-49d452e21028.png" width="70" height="90"> |<img src="https://user-images.githubusercontent.com/44585823/214990019-60859c16-607e-41a1-aa0c-73cbd56801c0.png" width="70" height="90"> | Atrous in series| 
 |  |  |0.8281|0.8378|0.8064|0.8304| | |




[1] Ronneberger, O., Fischer, P., & Brox, T. (2015). U-Net: Convolutional Networks for Biomedical Image Segmentation. En N. Navab, J. Hornegger, W. M. Wells, & A. F. Frangi (Eds.), Medical Image Computing and Computer-Assisted Intervention – MICCAI 2015 (pp. 234-241). Springer International Publishing. https://doi.org/10.1007/978-3-319-24574-4_28

[2] He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep Residual Learning for Image Recognition. 2016 IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 770-778. https://doi.org/10.1109/CVPR.2016.90

[3] Han, X. (2017). Automatic Liver Lesion Segmentation Using A Deep Convolutional Neural Network Method. ArXiv.Org. https://doi.org/10.1002/mp.12155

[4] Khan, R. A., Luo, Y., & Wu, F.-X. (2022). RMS-UNet: Residual multi-scale UNet for liver and lesion segmentation. Artificial Intelligence in Medicine, 124, 102231. https://doi.org/10.1016/j.artmed.2021.102231

[5] Ibtehaz, N., & Rahman, M. S. (2020). MultiResUNet: Rethinking the U-Net architecture for multimodal biomedical image segmentation. Neural Networks, 121, 74-87. https://doi.org/10.1016/j.neunet.2019.08.025


