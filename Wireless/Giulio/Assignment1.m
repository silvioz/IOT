% Start time measurement
tic();

% Source: Generate random bits
txbits = randi([0 1],1000000,1);

% Mapping: Bits to symbols
tx = 2*txbits - 1;

% Channel: Apply BSC  and Demapping: Symbols to bits
rx = rand(1,1000000);
rxbits = (sign (rx - 0.2))';

% BER: Count errors
errors = sum (xor(rxbits, txbits));

% Output result
disp(['BER: ' num2str(errors/1000000*100) '%'])

% Stop time measurement
toc()
