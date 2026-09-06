function [sorted_coordinates, sorted_variances] = blocking_image(img,block_size)

[img_height, img_width] = size(img);
num_blocks_y = img_height / block_size;
num_blocks_x = img_width / block_size;
variances = zeros(fix(num_blocks_y), fix(num_blocks_x));

for i = 1:num_blocks_y
    for j = 1:num_blocks_x
        row_start = (i-1) * block_size + 1;
        row_end = i * block_size;
        col_start = (j-1) * block_size + 1;
        col_end = j * block_size;
        block = img(row_start:row_end, col_start:col_end);

        variances(i, j) = var(double(block(:)));
    end
end

variances_flat = variances(:);

[sorted_variances, sorted_indices] = sort(variances_flat, 'descend');

sorted_coordinates = zeros(length(sorted_indices), 2);
for k = 1:length(sorted_indices)
    [row, col] = ind2sub(size(variances), sorted_indices(k));
    sorted_coordinates(k, :) = [(col-1) * block_size + 1, (row-1) * block_size + 1];
end
end

