%%Part2 Coding function
function coded_sig = coding_amp(message,bit_rate)

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
    for z=1:bit_rate:binarymessage_len
        bin_to_write = binarymessage(z:z+bit_rate-1);
        decimal = bin2dec(bin_to_write);
        cons = decimal/((2^bit_rate)-1);
        t=(z/bit_rate):(1/fs):(z/bit_rate)+1-(1/fs);
        to_write = cons*sin(2*pi*(t-(z/bit_rate)));
        coded_sig = [coded_sig to_write];
    end
    
end