%% 2
clc, clearvars, close all;
%% 2.1 opening the files
[filename, filepath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an Image');
imagepath = fullfile(filepath, filename);
image = imread(imagepath);
%% 2.2 resize the pictures frome any place and distance to ease the process
image = imresize(image, [100,500]);
figure;
imshow(image);
%% 2.3 making it gray
gray_image = mygrayfun(image);
figure;
imshow(gray_image);
%% 2.4 making it black and white with binary system 0 1 to only finding the plate and numbers
binary_image = mybinaryfun(gray_image, 100);
figure;
imshow(binary_image);
%% 2.5 removing noise and the dots and finding the numbers by suntracking the plate(using threshold)
filtered = myremovecom(~binary_image, 300);
background = myremovecom(~binary_image, 2300);
characters= (filtered - background);

figure;

subplot(1,3,1);
imshow(~filtered);
title('Without noise');

subplot(1,3,2);
imshow(~background);
title('Background');

subplot(1,3,3);
imshow(~characters);
title('characters');
%% 2.6 segmentation
[n, labeled] = mysegmentation(characters);
fprintf("Number of segments: %d", n);
figure;
propied=regionprops(labeled,'BoundingBox');
imshow(~characters);
title('detected characters')
hold on
for m=1:size(propied,1)
    rectangle('Position',propied(m).BoundingBox,'EdgeColor','b','LineWidth',2)
end
hold off
%% 2.7 finding map set(Persian alphabet and numbers)
folderPath = './PersianMapSet';
fileNames = dir(fullfile(folderPath, '*.png'));
numFiles = length(fileNames);

imageData = cell(numFiles, 2);

for i = 1:numFiles
    imagePath = fullfile(folderPath, fileNames(i).name);
    image = imread(imagePath);
    
    [~, fileName, ~] = fileparts(fileNames(i).name);
    imageData{i, 1} = image;
    imageData{i, 2} = fileName;
end
%% 2.8
res = '';
for i = 1:n
    [row, col] = find(labeled == i);
    y = characters(min(row):max(row), min(col):max(col));
    y = imresize(y,[100,80]);
    corr_max = -2;
    i_max = 0;
    for j = 1:numFiles
        corr_j = corr2(y,imageData{j,1});
        if(corr_j > corr_max)
            corr_max = corr_j;
            i_max = j;
        end
    end
    if(corr_max > 0.3)
        res = strcat(res,imageData{i_max,2});
    end
end
fprintf("The plates numbers are: %s", res);
