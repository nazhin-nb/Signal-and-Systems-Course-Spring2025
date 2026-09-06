function[i,j] = find_any(matrix)
    for j = 1:size(matrix,2)
        for i = 1:size(matrix,1)
            if(matrix(i,j) == 1)
                return;
            end
        end
    end
    i = -1;
    j = -1;
end