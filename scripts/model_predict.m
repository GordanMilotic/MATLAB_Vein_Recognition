function predictedLabel = model_predict(trainedModel, imagePath)
% Predikcija klase za jednu sliku

% 1) Provjera da file postoji
if ~isfile(imagePath)
    error('Ne mogu naci datoteku: %s', imagePath);
end

% 2) Ucitaj i konvertiraj u grayscale ako je potrebno
img = imread(imagePath);
if size(img,3) == 3
    imgGray = rgb2gray(img);
else
    imgGray = img;
end

% 3) Resize na 64x64 (isto kao kod treninga)
imgResized = imresize(imgGray, [64 64]);

% 4) Flatten u feature vektor
testFeature = double(imgResized(:))'; % 1 x 4096

% 5) Predikcija
predictedLabel = predict(trainedModel, testFeature);

end
