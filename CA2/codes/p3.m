%% 3
clc,clearvars,close all;
%% photo of the car and doing the same work like p2(finding the plate and correlation with the set)
template = imread('origin.jpg');
filedest = "p3/";
for k = 1:3
    image = imread(filedest +k+ ".jpg");
    
    image = imresize(image, [200, 300]);
    template = imresize(template, [20, 10]); 
    
    template = im2double(template);
    image = im2double(image);
    
    correlationMapR = normxcorr2(template(:,:,1), image(:,:,1));
    correlationMapG = normxcorr2(template(:,:,2), image(:,:,2));
    correlationMapB = normxcorr2(template(:,:,3), image(:,:,3));
    wR = 1;
    wG = 1;
    wB = 1;
    correlationMap = (wR * correlationMapR + wG * correlationMapG + wB * correlationMapB) / (wR + wG + wB);
    
    [maxCorrelationValue, maxIndex] = max(correlationMap(:));
    [maxRow, maxCol] = ind2sub(size(correlationMap), maxIndex);
    templateHeight = size(template, 1);
    templateWidth = size(template, 2);
    matchedRegionRow = maxRow - templateHeight + 1;
    matchedRegionCol = maxCol - templateWidth + 1;
    
    
    figure;
    subplot(1,2,1);
    imshow(image);
    hold on;
    rectangle('Position', [matchedRegionCol, matchedRegionRow, templateWidth, templateHeight], 'EdgeColor', 'r', 'LineWidth', 2);
    rectangle('Position', [matchedRegionCol-10, matchedRegionRow-10, 7 * templateHeight, 2 * templateHeight], 'EdgeColor', 'g', 'LineWidth', 2);
    hold off;
    plate = imcrop(image, [matchedRegionCol-10, matchedRegionRow-10, 7 * templateHeight, 2 * templateHeight]);
    subplot(1,2,2);
    imshow(mybinaryfun(mygrayfun(imresize(plate, [100, 500])), 0.4));
    figure;
    image = imresize(plate, [100,500]);
    subplot(1,3,1);
    title('original');
    imshow(image);
    gray_image = mygrayfun(image);
    subplot(1,3,2);
    title('grayscaled');
    imshow(gray_image);
    binary_image = mybinaryfun(gray_image, 0.4);
    subplot(1,3,3);
    title('binarized');
    imshow(binary_image);
    filtered = myremovecom(~binary_image, 150);
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
    [n, labeled] = mysegmentation(characters);
    fprintf("Number of segments: %d ", n);
    figure('Position', [0 0 900 400]);
    propied=regionprops(labeled,'BoundingBox');
    imshow(~characters);
    title('detected characters')
    hold on
    for m=1:size(propied,1)
        rectangle('Position',propied(m).BoundingBox,'EdgeColor','b','LineWidth',2)
    end
    hold off
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
    fprintf("The plates numbers are: %s \n", res);
    
    end