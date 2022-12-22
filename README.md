# morphological-image-processing-axons-extraction
The goal of this exercise is to extract the axons of the photos.To do so i use morphological image processing techniques. 

Image Denoising.
 -> (A opening B) closing B.
A is the image 
B is the structural element (in this case it was a disk with radious = 1).

Morphological gradient.
-> (A dialate B) - (A erode B)

Binarization by using Otsu method to find threshold.
->threshold found with the use of graythresh
->convert image to binary
->with bwareopen to remove small objects
->imfill to fill gaps

Connection of skeleton.
->bwmorph(image1,'skel',Inf)
->fill gaps with imfill 
