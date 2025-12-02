function trainedModel = model_training(images, labels)

numberOfImages = length(images);
featureMatrix = zeros(numberOfImages, 64*64); 

fprintf('Zapocinjem ekstrakciju featurea za %d slika\n', numberOfImages);

progressStep = floor(numberOfImages / 10); 
if progressStep == 0
    progressStep = 1;
end

for i = 1:numberOfImages
    originalImage = images{i};                     % uzmi originalnu sliku
    preprocessedImage = image_preprocess(originalImage);   % predobrada
    imageFeatures = feature_extract(preprocessedImage);    % ekstrakcija feature
    featureMatrix(i, :) = imageFeatures;  

    if mod(i, progressStep) == 0 || i == numberOfImages
        percentage = round((i / numberOfImages) * 100);
        fprintf('Feature extraction: %d%% (%d/%d slika)\n', ...
                percentage, i, numberOfImages);
    end
end

fprintf('Feature extraction gotov\n');

fprintf('zapocinjem treniranje modela \n');
%fprintf('Verbose mode: on\n');

trainedModel = fitcecoc(featureMatrix, labels, 'Verbose', 1);

fprintf('Model uspjesno treniran na %d slika\n', numberOfImages);

end
