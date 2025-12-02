clc; clear; close all;

% Ucitaj spremljeni model
load("trainedModel.mat", "trainedModel");

disp("Demo predikcija");

% Otvori file selector 
[filename, pathname] = uigetfile('*.bmp', 'Odaberite sliku za predikciju iz datoteke');
if isequal(filename,0)
    disp('nije odabrana slika');
else
    slika = fullfile(pathname, filename);  % potpuna putanja do slike
    try
        rezultat = model_predict(trainedModel, slika);
        disp("Predikcija za tu sliku je:"); %nije dobra predikcija, treba model prepravit
        disp(rezultat);
    catch ME
        warning('Pogreska pri predikciji: %s', ME.message);
    end
end
