function [BER]= functionBER(Nbits, SNRdB)
dimOutput = length(SNRdB);
BER = zeros(1, dimOutput);
seed = 15;
rng(seed);
BitsTX= randi([0 1],Nbits,1);
NSymbols = Nbits/2;
temp = ((reshape(BitsTX, 2, []))*2 -1)*(1/(sqrt(2)));
temp(2,:) = temp(2,:) * 1i;
Symbols = temp(1,:) + temp(2,:);
w1 = randn(1,NSymbols);
w2 = randn(1,NSymbols);

for i = 1:dimOutput
    sigma_square = 10^(-SNRdB(i)/10);
    sigma = sqrt(sigma_square);
    w = (sigma/(sqrt(2)))*w1 + (sigma/(sqrt(2)))*1i*w2;
    Noisy = Symbols + w;
    angles = angle(Noisy).';
    receivedBits1 = zeros(1,NSymbols);
    receivedBits2 = zeros(1,NSymbols);

   
    receivedBits1(angles < (pi/2) & angles > 0) = 1;
    receivedBits2(angles < (pi/2) & angles > 0) = 1;
    receivedBits1(angles > (pi/2) & angles < pi) = 0;
    receivedBits2(angles > (pi/2) & angles < pi) = 1;
    receivedBits1(angles > -(pi/2) & angles < 0) = 1;
    receivedBits2(angles > -(pi/2) & angles < 0) = 0;
    receivedBits1(angles < -(pi/2) & angles > -pi) = 0;
    receivedBits2(angles < -(pi/2) & angles > -pi) = 0;

    received = [receivedBits1; receivedBits2];

    received = reshape(received, 1, []);
    errors = sum (xor(received, BitsTX.'));
    BER(i) = errors / Nbits;
end
