function image_output = image_preprocess(input_image)

if size(input_image,3) == 3
    image_gray = rgb2gray(input_image);
else
    image_gray = input_image;
end

image_resized = imresize(image_gray, [64 64]);

image_resized = imadjust(image_resized);
image_histeq = adapthisteq(image_resized);

image_output = imgaussfilt(image_histeq, 1);

end



