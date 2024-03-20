% Program to implement training for CBIR
n = 1000 * 15;  % No. of training images
fv1 = 181;      % Length of feature vector
X = zeros(n, fv1);  % Initialize feature vector database
classNames = cell(n, 1);  % Initialize cell array to store class names

dwtmode('per');

classFolders = {'Bean', 'Bitter_Gourd', 'Bottle_Gourd', 'Brinjal', 'Broccoli','Cabbage', 'Capsicum', 'Carrot', 'Cauliflower', 'Cucumber', 'Papaya', 'Potato', 'Pumpkin', 'Radish', 'Tomato'};

count = 1;

for classIdx = 1:length(classFolders)
    currentClass = classFolders{classIdx};
    
    for imgIdx = 1:1000
        % Read Images
        imgPath = sprintf('./vege-train/%s/%04d.jpg', currentClass, imgIdx);
        I = imread(imgPath);
        
        % -----------Color Feature Vector-------------------
        cld = findcld(I);  % Finding CLD
        cld = cld / max(cld);
        [cofA, ~] = dwt(cld, 'sym4');  % DWT of CLD
        colfv = cofA;  % Approx. Coeff. as color feature vector

        % ------------Texture Feature Vector----------------
        [C, L] = wavedec2(rgb2gray(I), 2, 'sym4');  % Wavelet Decomposition
        cA = appcoef2(C, L, 'sym4');  % Getting Approximation coeff.
        [cH, cV, cD] = detcoef2('all', C, L, 2);  % Getting Detailed coeff.
        F = [cA, cH; cV, cD];
        texfv = findehd(F);  % Finding EHD
        texfv = texfv / max(texfv);
        fv = [colfv, texfv];  % Getting the total feature vector
        X(count, :) = fv;  % Storing all features
        classNames{count} = currentClass;  % Storing the class name
        count = count + 1;
    end
end

