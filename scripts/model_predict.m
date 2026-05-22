function predictedLabel = model_predict(trainedModel, imagePath)
% Predikcija klase za jednu sliku

if ~isfile(imagePath)
    error('Ne mogu naci datoteku: %s', imagePath);
end

img = imread(imagePath);

preprocessedImg = image_preprocess(img);
testFeature = feature_extract(preprocessedImg);
predictedLabel = predict(trainedModel, testFeature);

end