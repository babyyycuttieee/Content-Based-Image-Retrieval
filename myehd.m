% Program to compare two images on the basis of Edge Histogram Descriptor
% (EHD)
[filename1,pathname1] = uigetfile('*.*','Select Image 1');
filewithpath1 = strcat(pathname1,filename1);
img1 = imread(filewithpath1);

[filename2,pathname2] = uigetfile('*.*','Select Image 2');
filewithpath2 = strcat(pathname2,filename2);
img2 = imread(filewithpath2);

% Finding EHD for img
ehd1 = findehd(img1); 
ehd2 = findehd(img2);

figure(1)
subplot(221); imshow(img1); title('Image 1');
subplot(222); bar(ehd1(81:85)); title('Global Bin of Image 1');
subplot(223); imshow(img2); title('Image 2');
subplot(224); bar(ehd2(81:85)); title('Global Bin of Image 2');

figure(2)
plot(ehd1); hold on; plot(ehd2); title('Comparing EHD1 and EHD2');
legend('EHD1','EHD2');  %Plotting EHD

% L2 Distance between EHD1 and EHD2
D2=sqrt(sum(((ehd1-ehd2).^2))); 
disp(strcat('L2 Distance = ', num2str(D2)));

% L1 Distance between CLD1 and CLD2
D1=sum(abs(ehd1-ehd2));
disp(strcat('L1 Distance = ', num2str(D1)));