SNRdB = linspace(-10,15,300);
Nbits = 10^6;
BER1 = functionBER(Nbits, SNRdB);
BER2 = functionBER2(Nbits, SNRdB);

figure(1)
semilogy(SNRdB, BER1)
hold on
semilogy(SNRdB, BER2)
grid on
xlabel('SNRdB')
ylabel('BER')