%Program to test CBIR
clc;
n=1000*15; %No. of trained image
[filename,pathname]=uigetfile('*.*','Select the Input Color Image');
filewithpath=strcat(pathname,filename);
I=imread(filewithpath);

dwtmode('per');

%-----------Color Feature Vector-------------------
cld=findcld(I);     %Finding CLD
cld=cld/max(cld);
[cofA,~]=dwt(cld,'sym4');   %DWT of CLD
colfv=cofA; %Approx. Coeff. as color feature vector

%------------Texture Feature Vector----------------
[C,L]=wavedec2(rgb2gray(I),2,'sym4');   %Wavelet Decomposition
cA=appcoef2(C,L,'sym4');    %Getting Approximation coeff.
[cH,cV,cD]=detcoef2('all',C,L,2);   %Getting Detailed coeff.
F=[cA, cH; cV, cD];
texfv=findehd(F);   %Finding EHD
texfv=texfv/max(texfv);
fv=[colfv,texfv];   %Getting total feature vector

%--------------------------------------------------
distarray=zeros(n,1);   %Initialize difference array
for i=1:n
    distarray(i)=sum(abs(X(i,:)-fv));   %Finding L1 distance
end

[diff,index]=sort(distarray);   %Sorting the difference

%---------------Plotting Retrived Images------------
subplot(231)
imshow(I);
title('Query Image');

for i = 1:5
    % Adjust the indexing to retrieve the original image names (0001 to 1000)
    if index(i) > 1000
        temp = mod(index(i), 1000) / 1000;
        fprintf('%f\n', temp);
        originalIndex = round(temp * 1000);
    else
        originalIndex = index(i);
    end

    originalImageName = sprintf('%04d.jpg', originalIndex);
    
    subplot(2, 3, i + 1);
    matchImage = imread(fullfile('./vege-train/', classNames{index(i)}, originalImageName));
    imshow(matchImage);
    title(['Match ' num2str(i) ': ' classNames{index(i)}]);
end








