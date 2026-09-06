%%Part2 Coding function
function coded_sig = coding_freq(message,bit_rate)

    fs = 100;
    coded_sig =[];
    mapset = create_mapset();

    % 1- Turning the message into a binary number
    Nch = 32;
    message_len = strlength(message);
    message_bin = cell(1,message_len);
    for i=1:message_len
        ch = message(i);
        for j=1:Nch
            if ch == mapset{1,j}
                message_bin{i} = mapset{2,j};
            end
        end
    end
    binarymessage = cell2mat(message_bin);
    binarymessage_len = length(binarymessage);

    % 2- Creating the coded signal
    f_step = floor((fs/2^bit_rate)/2);
    for z=1:bit_rate:binarymessage_len
        if z+bit_rate-1<=binarymessage_len
            bin_to_write = binarymessage(z:z+bit_rate-1);
        else
            bin_to_write = binarymessage(z:binarymessage_len);
            dec_to_write = bin2dec(bin_to_write);
            for q=length(bin_to_write):bit_rate-1
                dec_to_write = bitshift(dec_to_write,1);
            end
            bin_to_write = dec2bin(dec_to_write);
        end
        decimal = bin2dec(bin_to_write);
        frequency = f_step*decimal+ceil(f_step/2);
        t=(z/bit_rate):(1/fs):(z/bit_rate)+1-(1/fs);
        to_write = sin(2*pi*frequency*(t-(z/bit_rate)));
        coded_sig = [coded_sig to_write];
    end
    
end