function ro = p3_corfunc(t, tau, ts, Transmission_Signal)
    ro = zeros(size(t));
    for i=1:length(t)-int64(tau/ts)
        temp_signal = zeros(size(t));
        temp_signal(i:i+(tau/ts)-1) = 1;
        ro(i) = sum(temp_signal .* Transmission_Signal);
    end
end

