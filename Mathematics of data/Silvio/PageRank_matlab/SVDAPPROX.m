x=imread('img.jpg');
x=double(rgb2gray(x));
[U S V]=svd(x);
imshow(x)