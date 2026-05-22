function trainedModel = model_training(images, labels)

numberOfImages = length(images);

% odredi duljinu featurea iz prve slike
originalImage = images{1};
preprocessedImage = image_preprocess(originalImage);
firstFeature = feature_extract(preprocessedImage);
featureLen = length(firstFeature);

featureMatrix = zeros(numberOfImages, featureLen); 

fprintf('Zapocinjem ekstrakciju featurea za %d slika\n', numberOfImages);

progressStep = floor(numberOfImages / 10); 
if progressStep == 0
    progressStep = 1;
end

for i = 1:numberOfImages
    originalImage = images{i};                     
    preprocessedImage = image_preprocess(originalImage);   
    imageFeatures = feature_extract(preprocessedImage);    
    featureMatrix(i, :) = imageFeatures;  

    if mod(i, progressStep) == 0 || i == numberOfImages
        percentage = round((i / numberOfImages) * 100);
        fprintf('Feature extraction: %d%% (%d/%d slika)\n', ...
                percentage, i, numberOfImages);
    end
end

fprintf('Feature extraction gotov\n');

fprintf('zapocinjem treniranje modela \n');

trainedModel = fitcecoc(featureMatrix, labels, 'Verbose', 1);

fprintf('Model uspjesno treniran na %d slika\n', numberOfImages);

end
