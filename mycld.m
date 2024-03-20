
% Program to compare two images on the basis of Color Layout Descriptor
% (CLD)

[filename1,pathname1] = uigetfile('*.*','Select Color RGB Image 1');
filewithpath1 = strcat(pathname1,filename1);
img1 = imread(filewithpath1);

[filename2,pathname2] = uigetfile('*.*','Select Color RGB Image 2');
filewithpath2 = strcat(pathname2,filename2);
img2 = imread(filewithpath2);

% Finding CLD for img
cld1 = findcld(img1); 
cld2 = findcld(img2);

% Plotting CLDs
plot(cld1); hold on; plot(cld2);

% Separating CLD components for weighted distance (Y Cb Cr)
cldY1=cld1(1:64); cldCb1=cld1(65:128); cldCr1=cld1(129:192);
cldY2=cld2(1:64); cldCb2=cld2(65:128); cldCr2=cld2(129:192);

% Weighted Distance between CLD1 and CLD2 (Weights: 2, 2, 4 for Y, Cb, Cr)
Dw=sqrt(sum(2*((cldY1-cldY2).^2)))+sqrt(sum(2*((cldCb1-cldCb2).^2)))+sqrt(sum(4*((cldCr1-cldCr2).^2)));
disp(strcat('Weighted Distance = ', num2str(Dw)));

% L2 Distance between CLD1 and CLD2
D2=sqrt(sum(((cld1-cld2).^2))); 
disp(strcat('L2 Distance = ', num2str(D2)));

% L1 Distance between CLD1 and CLD2
D1=sum(abs(cld1-cld2));
disp(strcat('L1 Distance = ', num2str(D1)));

