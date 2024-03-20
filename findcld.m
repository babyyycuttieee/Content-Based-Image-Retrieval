function cld=findcld(img)

% Finding image size
[r,c]=size(img(:,:,1));
r=ceil(r/8); c=ceil(c/8);
r8=8*r; c8=8*c;

% Resizing image to make it divisible by 8
img=imresize(img,[r8,c8]);
oneblock=ones(r,c);
%Function for Finding CLD Feature Vector

% Defineing mask to capture only DC coefficient of DCT
mask=[1 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0];

% Get the average color of image in each block
avg0 = @(block_struct) oneblock.*mean(mean(block_struct.data));

% Image with Average intensity
imgavg = uint8(blockproc(img,[r c],avg0));

% Resizing to make block of 8by8
imgavg8 = imresize(imgavg,[64,64],'nearest');

% Changing color space to YCbCr
YCbCr=double(rgb2ycbcr(imgavg8));

% Block Processing for DCT Computation
dctop = @(block_struct) dct2(block_struct.data).*mask;  %DCT operation
Ydct = blockproc(YCbCr(:,:,1),[8 8],dctop); %Getting DCT of Y
Cbdct = blockproc(YCbCr(:,:,2),[8 8],dctop); %Getting DCT of Cb
Crdct = blockproc(YCbCr(:,:,3),[8 8],dctop); %Getting DCT of Cr

% Collecting DC coefficients of DCT-Y, DCT-Cb and DCT-Cr
[~,~,Yfv]=find(Ydct); [~,~,Cbfv]=find(Cbdct); [~,~,Crfv]=find(Crdct);
cld1=[Yfv Cbfv Crfv]; [rcld,ccld]=size(cld1);
cld=reshape(cld1,[1,rcld*ccld]);    % Getting final CLD vector of size 1by192




