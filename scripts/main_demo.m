clc; clear; close all;

modelFile = fullfile(pwd, 'trainedModel.mat');
if ~isfile(modelFile)
    error('Nije pronaden spremljeni model');
end
S = load(modelFile, 'trainedModel');
trainedModel = S.trainedModel;

numSamples = 5;
selectedImages = cell(numSamples,1);

for i = 1:numSamples
    [filename, pathname] = uigetfile('*.bmp', sprintf('Odaberite sliku %d', i));
    if isequal(filename,0)
        error('Nije odabrana slika');
    end
    selectedImages{i} = fullfile(pathname, filename);
end % ovo je za sad rucni odabir slike

for i = 1:numSamples
    imgPath = selectedImages{i};
    img = imread(imgPath);

    figure(1); imshow(img); title(sprintf('Slika %d', i));
    
    featureVector = feature_extract(image_preprocess(img));
    predictedLabel = predict(trainedModel, featureVector);
    
    fprintf('Slika %d: Predikcija = %d\n', i, predictedLabel);
    
    pause(1);
end
