clc,clearvars,close all;
%% 1.1
[filename, filepath] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, 'Select an Image');
imagepath = fullfile(filepath, filename);
image = imread(imagepath);
%% 1.2
image = imresize(image, [300,500]);
figure;
imshow(image);
%% 1.3
gray_image = mygrayfun(image);
figure;
imshow(gray_image);
%% 1.4
binary_image = mybinaryfun(gray_image, 100);
figure;
imshow(binary_image);
%% 1.5
filtered = myremovecom(~binary_image, 300);
background = myremovecom(~binary_image, 2300);
characters = (filtered - background);
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
%% 1.6
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
%% 1.7
folderPath = './Map Set';
fileNames = dir(fullfile(folderPath, '*.bmp'));
numFiles = length(fileNames);

imageData = cell(numFiles, 2);

for i = 1:numFiles
    imagePath = fullfile(folderPath, fileNames(i).name);
    image = imread(imagePath);
    
    [~, fileName, ~] = fileparts(fileNames(i).name);
    imageData{i, 1} = image;
    imageData{i, 2} = fileName;
end
%% 1.1.8
res = '';
for i = 1:n
    [row, col] = find(labeled == i);
    y = characters(min(row):max(row), min(col):max(col));
    y = imresize(y,[42,24]);
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
fprintf("Estimated plate number: %s", res);res = '';
file=fopen("output.txt","a");
fprintf(file, "Estimated plate number : %s \n", res);
%% 1.2.8
tests = ['Test Images/1.jpg'; 'Test Images/2.jpg'; 'Test Images/3.jpg'];
for k = 1:3
    
    image = imread(tests(k,:));
    image = imresize(image, [300,500]);
    figure('Position', [0 0 900 400]);
    subplot(1,2,1);
    imshow(image);
    title('image');
    
    gray_image = mygrayfun(image);
    bianry_image = mybinaryfun(gray_image, 100);
    filtered = myremovecom(~bianry_image, 300);
    background = myremovecom(~bianry_image, 2300);
    characters = (filtered - background);
    [n, labeled] = mysegmentation(characters);
    
    propied=regionprops(labeled,'BoundingBox');
    subplot(1,2,2);
    imshow(~characters);
    title('detected characters');
    hold on
    for m=1:size(propied,1)
        rectangle('Position',propied(m).BoundingBox,'EdgeColor','b','LineWidth',2)
    end
    hold off
    
    res = '';
    for i = 1:n
        [row, col] = find(labeled == i);
        y = characters(min(row):max(row), min(col):max(col));
        y = imresize(y,[42,24]);
        corr_max = -inf;
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
    fprintf("Estimated plate number: %s \n", res);
end