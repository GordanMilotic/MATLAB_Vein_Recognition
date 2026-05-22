function feature_vector = feature_extract(input_image)

feature_vector = extractHOGFeatures(input_image, 'CellSize', [8 8]);

end
