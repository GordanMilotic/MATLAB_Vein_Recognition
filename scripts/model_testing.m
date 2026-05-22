function testAccuracy = model_testing(trainedModel, testImages, testLabels)
% testiranje SVM modela
% testImages - array testnih slika
% testLabels - stvarni id osoba za test slike
% izlaz- testAccuracy - tocnost modela na test skupu

totalNumberOfTestImages = length(testImages);

% odredi duljinu featurea iz prve testne slike
originalTestImage = testImages{1};
preprocessedTestImage = image_preprocess(originalTestImage);
firstFeature = feature_extract(preprocessedTestImage);
featureLen = length(firstFeature);

testFeatureMatrix = zeros(totalNumberOfTestImages, featureLen);

for i = 1:totalNumberOfTestImages
    originalTestImage = testImages{i};                  
    preprocessedTestImage = image_preprocess(originalTestImage); 
    testImageFeatures = feature_extract(preprocessedTestImage);  
    testFeatureMatrix(i, :) = testImageFeatures;        
end

predictedLabels = predict(trainedModel, testFeatureMatrix);

numCorrectPredictions = sum(predictedLabels == testLabels);
testAccuracy = (numCorrectPredictions / totalNumberOfTestImages) * 100;

fprintf('Tocnost modela na test skupu: %.2f %%\n', testAccuracy);

end
