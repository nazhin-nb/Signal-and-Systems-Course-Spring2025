function DcodedMessageBin = decoding(X, mapset, threshold, block_size)

Alphabet = strjoin(mapset(1, :), '');

[sorted_coordinates, sorted_variances] = blocking_image(X, block_size);

flag=1;
DcodedMessageBin=[];

while flag
    message_index = 1;
    for k = 1:length(sorted_variances)
        if(sorted_variances(k) < threshold)
            flag = 0;
            break
        end
        coords = sorted_coordinates(k, :);
        row_start = coords(2);
        col_start = coords(1);

        block = X(row_start:row_start+(block_size-1), col_start:col_start+(block_size-1));

        for i = 1:block_size
            characterbin=zeros(1,block_size);
            for j = 1:block_size
                pixel_value = block(i, j);
                pixel_bin = dec2bin(pixel_value);
                characterbin(j)=str2double(pixel_bin(end));
                message_index = message_index + 1;
            end
            num=sum(characterbin.*(2.^(4:-1:0)))+1;
            DcodedMessageBin=[DcodedMessageBin Alphabet(num)];
            if strcmp(Alphabet(num),';')
                flag=0;
            end
            if flag == 0
                break;
            end
        end
        if flag == 0
            break;
        end

    end
end

end
