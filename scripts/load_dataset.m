function [images, labels] = load_dataset()
% ucitavanje slika

datasetPath = fullfile('..', 'Finger Vein Database');
folders = dir(datasetPath);
folders = folders([folders.isdir]); % 
folders = folders(~ismember({folders.name}, {'.','..'}));

images = {};
labels = [];

for i = 1:length(folders)
    personID = str2double(folders(i).name);
    personFolder = fullfile(datasetPath, folders(i).name);
    sides = {'left', 'right'};
    for s = 1:length(sides)
        sideFolder = fullfile(personFolder, sides{s});
        imageFiles = dir(fullfile(sideFolder, '*.bmp'));
        
        for j = 1:length(imageFiles)
            imagePath = fullfile(sideFolder, imageFiles(j).name);
            % ignoriranje thumbs.db (oni su samo u 001 i 002)
            if contains(lower(imageFiles(j).name), 'thumbs.db')
                continue
            end
            image = imread(imagePath);
            images{end+1} = image;       %#ok
            labels(end+1) = personID;  %#ok
        end
    end
end

images = images';
labels = labels';
fprintf('Ucitan %d slika iz %d osoba\n', length(images), length(folders));
end
