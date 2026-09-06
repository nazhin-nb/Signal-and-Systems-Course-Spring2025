function encoded_image = coding(message, X, mapset)

message_len=length(message);
message_bin=cell(1,message_len);

for i=1:message_len
    ch=message(i);
    index=strcmp(ch,mapset(1,:));
    message_bin{i}=mapset{2,index};
end

binarymessage=cell2mat(message_bin);
binarymessage_len=length(binarymessage);

block_size = 5;
[sorted_coordinates, sorted_variances] = blocking_image(X, block_size);

encoded_image = X;

threshold = 0.5;
message_index = 1;

for k = 1:length(sorted_variances)
    try
        if(sorted_variances(k) < threshold)
            error("message length is bigger than pixel numbers")
        end
    catch ME
        exit
    end

    coords = sorted_coordinates(k, :);
    row_start = coords(2);
    col_start = coords(1);

    block = encoded_image(row_start:row_start+4, col_start:col_start+4);

    for i = 1:block_size
        for j = 1:block_size
            if message_index <= binarymessage_len
                pixel_value = block(i, j);
                pixel_bin = dec2bin(pixel_value); 
                pixel_bin(end) = binarymessage(message_index);
                block(i, j) = bin2dec(pixel_bin);
                message_index = message_index + 1;
            else
                break;
            end
        end
    end

    encoded_image(row_start:row_start+4, col_start:col_start+4) = block;
    if message_index > binarymessage_len
        break;
    end
end
end

