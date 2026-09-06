function decoded_message = decoding_freq(coded_sig, bit_rate)
    fs = 100;
    f_step = floor((fs/(2^bit_rate))/2);
    mapset = create_mapset();
    decoded_message = [];

    % Extracting binary message
    bin_message = [];
    t = 0:(1/fs):1-(1/fs);
    thresholds = linspace(-fs/2, fs/2 - 1, fs);

    for j = 0:(length(coded_sig)/fs)-1;
        to_check = coded_sig(j*fs + 1 : (j+1)*fs);
        fftx = abs(fftshift(fft(to_check)));
        [~, idx] = max(fftx);
        detected_f = abs(thresholds(idx));
        dec = round((detected_f - ceil(f_step/2)) / f_step);
        dec = max(min(dec, 2^bit_rate - 1), 0);
        bin_message = [bin_message dec2bin(dec, bit_rate)];
    end

    % Turning the binary message into string
    for p = 1:5:length(bin_message)
        bits = bin_message(p:p+4);
        decoded_message(end+1) = mapset{1, bin2dec(bits)+1};
    end
end
