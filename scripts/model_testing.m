function testAccuracy = model_testing(trainedModel, testImages, testLabels)
% testiranje SVM modela
% testImages - array testnih slika
% testLabels - stvarni id osoba za test slike
% izlaz- testAccuracy - tocnost modela na test skupu

totalNumberOfTestImages = length(testImages);
testFeatureMatrix = zeros(totalNumberOfTestImages, 64*64);

for i = 1:totalNumberOfTestImages
    originalTestImage = testImages{i};                  % uzmi testnu sliku
    preprocessedTestImage = image_preprocess(originalTestImage); % predobrada
    testImageFeatures = feature_extract(preprocessedTestImage);  % ekstrakcija feature-a
    testFeatureMatrix(i, :) = testImageFeatures;        % spremi u matricu
end

predictedLabels = predict(trainedModel, testFeatureMatrix);

numCorrectPredictions = sum(predictedLabels == testLabels);
testAccuracy = (numCorrectPredictions / totalNumberOfTestImages) * 100;

fprintf('Tocnost modela na test skupu: %.2f %%\n', testAccuracy);

end
