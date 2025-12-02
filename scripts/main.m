clc; clear; close all;

modelFile = fullfile(pwd, 'trainedModel.mat');

if isfile(modelFile)
    fprintf('Pronaden spremljeni model: %s\n', modelFile);
    S = load(modelFile, 'trainedModel');
    trainedModel = S.trainedModel;
else
    fprintf('Nije pronađen spremljeni model, pokrecem trening\n');

    [allImages, allLabels] = load_dataset();

    if isempty(allImages)
        error('Nema ucitanih slika');
    end

    numTotalImages = length(allImages);
    rng(1);
    shuffledIndices = randperm(numTotalImages);

    numTrain = round(0.7 * numTotalImages);
    trainIndices = shuffledIndices(1:numTrain);
    testIndices = shuffledIndices(numTrain+1:end);

    trainImages = allImages(trainIndices);
    trainLabels = allLabels(trainIndices);

    testImages = allImages(testIndices);
    testLabels = allLabels(testIndices);

    fprintf('Treniranje modela\n');
    trainedModel = model_training(trainImages, trainLabels);

    save(modelFile, 'trainedModel');
    fprintf('Model uspjesno spremljen\n');
end

if ~exist('testImages', 'var') || ~exist('testLabels', 'var')
    [allImages, allLabels] = load_dataset();
    numTotalImages = length(allImages);
    rng(1);
    shuffledIndices = randperm(numTotalImages);
    numTrain = round(0.7 * numTotalImages);
    testIndices = shuffledIndices(numTrain+1:end);
    testImages = allImages(testIndices);
    testLabels = allLabels(testIndices);
end

fprintf('testiranje modela\n');
testAccuracy = model_testing(trainedModel, testImages, testLabels);
fprintf('tocnost modela: %.2f %%\n\n', testAccuracy);

disp("demo predikcija");
slika = "Finger Vein Database/010/left/index_5.bmp";
rezultat = model_predict(trainedModel, slika);
disp("Predikcija za tu sliku je:"); %demo_main za brze pokretnjae
disp(rezultat);
