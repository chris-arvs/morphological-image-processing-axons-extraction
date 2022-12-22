close all;
clear all;

f1 = figure(1);
Iaxones1 =imread("axones1.png");
Iaxones1 = rgb2gray(Iaxones1);
subplot(2,1,1);
imshow(Iaxones1);
title('Original Image 1');
subplot(2,1,2);
Iaxones2 = imread("axones2.png");
Iaxones2 = rgb2gray(Iaxones2);
imshow(Iaxones2);
title('Original Image 2');

%Denoise (AopenB)closeB

%A open B
f2 = figure(2);
se = strel('disk',1);
open_ax1 = imopen(Iaxones1,se);
open_ax2 = imopen(Iaxones2,se);
%(A open B) close B
Denoise_ax1 =imclose(open_ax1,se);
Denoise_ax2 =imclose(open_ax2,se);
subplot(2,1,1)
imshow(Denoise_ax1);
title('Denoised - axones1');
subplot(2,1,2);
imshow(Denoise_ax2);
title('Denoised - axones2');

%Morphological gradient AdilateB - AerodeB
f3 = figure(3);
morph_grad_ax1 = imdilate(Denoise_ax1,se) - imerode(Denoise_ax1,se);
morph_grad_ax2 = imdilate(Denoise_ax2,se) - imerode(Denoise_ax2,se);
subplot(2,1,1)
imshow(morph_grad_ax1);
title('Enhancement - Morphological gradient axones1');
subplot(2,1,2)
imshow(morph_grad_ax2);
title('Enhancement - Morphological gradient axones2');

%--- Binarization by using Otsu method to find threshold
f4 = figure(4);
Thershold_ax1 = graythresh(morph_grad_ax1);
Thershold_ax2 = graythresh(morph_grad_ax2);
Bin_ax1 = imbinarize(morph_grad_ax1,Thershold_ax1);
Bin_ax2 = imbinarize(morph_grad_ax2,Thershold_ax2);
%eliminate unwanted small objects
Bin_ax1_clean = bwareaopen(Bin_ax1,100);
Bin_ax2_clean = bwareaopen(Bin_ax2,100);
% Filling binirazed image with holes
Fill_Bin_ax1 = imfill(Bin_ax1_clean,'holes');
Fill_Bin_ax2 = imfill(Bin_ax2_clean,'holes');
subplot(2,1,1);
imshow(Fill_Bin_ax1);
title('Binarized and Filled axones1')
subplot(2,1,2);
imshow(Fill_Bin_ax2);
title('Binarized and Filled axones2')

%Skeletalization
f5 = figure(5);
skel_ax1 = bwmorph(Fill_Bin_ax1,'skel',Inf);
skel_ax2 = bwmorph(Fill_Bin_ax2,'skel',Inf);
subplot(2,1,1);
imshow(skel_ax1);
title('Skeleton of axones1');
subplot(2,1,2);
imshow(skel_ax2);
title('Skeleton of axones2');

% Connection of the Skeleton
f6 = figure(6);
Fill_skel_ax1 = imfill(skel_ax1,'holes');
Fill_skel_ax2 = imfill(skel_ax2,'holes');
subplot(2,1,1);
imshow(Fill_skel_ax1);
subplot(2,1,2);
imshow(Fill_skel_ax2);

%----- save figures
saveas(f1,'fig1.png');
saveas(f2,'fig2.png');
saveas(f3,'fig3.png');
saveas(f4,'fig4.png');
saveas(f5,'fig5.png');
saveas(f6,'fig6.png');