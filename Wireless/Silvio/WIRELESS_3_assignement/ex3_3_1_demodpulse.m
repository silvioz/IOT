function ex3_3_1_demodpulse
% ex3_3_1 - Task 3.3.1
%    Demodulate root raised cosine shaped pulses
%    
% 
% Author(s): Nicholas Preyss
% Copyright (c) 2012 TCL.
% 

alfa=0.1999;

SNR           = 200;
rx_filterlen  = 12; % length of receive filter
os_factor     = 4;  % oversampling factor

% load shaped symbols

load ./task3.mat
data_length = prod(image_size) * 8 / 2;

% convert SNR from dB to linear
SNRlin = 10^(SNR/10);

%asuming E[symb]=0
sig=sqrt(1./(SNRlin./2));
% add awgn channel
noise=(sig*randn(1,length(signal))+1i*sig*randn(1,length(signal))); 
rx_signal=signal+noise.'; 

% apply matched filter
filtered_rx_signal=RRC_filter(rx_signal,rx_filterlen,alfa,os_factor);

% find start of data frame
beginning_of_data = frame_sync(filtered_rx_signal, os_factor); % Index of the first data symbol

% decode image
image_decoder(demapper(filtered_rx_signal(beginning_of_data : os_factor : beginning_of_data + os_factor * (data_length - 1))), image_size);