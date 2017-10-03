% Start time measurement

tic();
n=100;

% Source: Generate random bits
txbits = randi([0 1],n,1);

% Mapping: Bits to symbols
tx=2.*txbits-1;

% Channel: Apply BSC
rx = (round(rand(n,1)-0.7)*2+1).*tx;

% Demapping: Symbols to bits
rxbits=(rx+1)./2;

% BER: Count errors
errors=sum(xor(rxbits,txbits));

% Output result
disp(['BER: ' num2str(errors/n*100) '%']);

% Stop time measurement
toc()

% Optimized time for    :       100 bits: 0.000210 4 times better (disp function dominant)
% Optimized time for    : 1'000'000 bits: 0.034827 64 times better
% NOT Optimized time for:       100 bits: 0.000824 (best one on first launch)
% NOT Optimized time for: 1'000'000 bits: 2.220075 (best one on first launch)
