clear
tic
os_factor = 4;
SNR = 5;
M=[-1 3 -3 1; 3 -6 3 0;-2 -3 6 -1;0 6 0 0]./6;

load pn_sequence
load ber_pn_seq
data_length=length(ber_pn_seq)/2;
% convert SNR from dB to linear
SNRlin = 10^(SNR/10);

% add awgn channel
rx_signal = signal + sqrt(1/(2*SNRlin)) * (randn(size(signal)) + 1i*randn(size(signal)) ); 

% Matched filter
filtered_rx_signal = matched_filter(rx_signal, os_factor, 6); % 6 is a good value for the one-sided RRC length (i.e. the filter has 13 taps in total)

% Frame synchronization
data_idx = frame_sync(filtered_rx_signal, os_factor); % Index of the first data symbol
%data_idx =0;

data = zeros(1,data_length);

cum_err = 0;
diff_err = zeros(1,data_length);
epsilon  = zeros(1,data_length);
exp_vect=[1 ; -i ; -1 ; i];

for i=1:data_length
    
     idx_start  = data_idx+(i-1)*os_factor;
     idx_range  = idx_start:idx_start+os_factor-1;
     segment    = filtered_rx_signal(idx_range);
     diff_err(i)= (abs(segment).^2).'*exp_vect;
     
     cum_err=cum_err+diff_err(i);
     epsilon(i)=(-1/(2*pi)).*angle(cum_err);
     
     start_interpolator_indx= idx_start+floor(4*epsilon(i));
     x=abs((4*epsilon(i))-floor(4*epsilon(i)));
     X=[x^3 ; x^2 ; x ; 1];
     F=[filtered_rx_signal(start_interpolator_indx-1) ; filtered_rx_signal(start_interpolator_indx) ; filtered_rx_signal(start_interpolator_indx+1) ; filtered_rx_signal(start_interpolator_indx+2)];
     %Lot of possibility for emprovement: M*F COULD be determinated in a
     %more generic way outside the for loop
     data(i)=X.'*(M*F);  
end
bits=demapper(data);
ber=sum(xor(bits,ber_pn_seq))/length(bits)
figure;
plot(epsilon);
toc

%As the "compareson.m" show (in a really dumb way) it's clear that the
%extimation of epsilon converge faster to the true value (0.1) BUT this
%kind of algorithm also require two times the execution time than the first
%one