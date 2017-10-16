function out=RRC_filter(rx_signal,rx_filterlen,alfa,OS)
    
    %rx_signal is a column vector
   
    taps=rrc(OS, alfa, rx_filterlen);
    extension=zeros((length(taps)-1)/2,1);
    rx_signal_long=cat(1,extension,rx_signal,extension);
    out=zeros(length(rx_signal),1);
    for i=1:length(rx_signal)
        out(i)=rx_signal_long(i:i+length(taps)-1,1).'*taps;
    end

end