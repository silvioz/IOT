clear all
close all
clc
tic 
%796.701554 seconds with n=500000; taps_r=1:200;
n=500000;
SNRdB=8;
L=4;
taps_t=41;
alfa=0.22;
taps_r=1:200;

sig= sqrt(10^(-SNRdB/10)/2);
tx_b=randi([0 1],n/2,2);
GrayMap = 1/sqrt(2) * [(-1-1j) (-1+1j) ( 1-1j) ( 1+1j)];

%MAPPING
sym_tx = GrayMap(bi2de(tx_b)+1).';
%OVERSAMPLING
sym_tx_L=zeros(L*length(sym_tx),1);
sym_tx_L(1:L:length(sym_tx_L))=sym_tx;
%FILTERING
tx=RRC_filter(sym_tx_L,taps_t,alfa,L);

%NOISE
tx_n=tx+sig*(randn(size(tx)) + 1i*randn(size(tx)));
%RECIVE
rx=tx_n;

BER=zeros(1,length(taps_r));

for i=1:length(taps_r)
    i
    %"CONJUGATE" FILTER
    sym_rx_L=RRC_filter(rx,taps_r(i),alfa,L);
    %DECIMATION
    sym_rx=sym_rx_L(1:L:length(sym_rx_L));
    %DECODEING
    %plot(real(sym_rx-sym_tx.'),imag(sym_rx-sym_tx.'),'o')
    ang=angle(sym_rx);
    rx_b=zeros(n/2,2);

    rx_b(ang>0 & ang<pi/2,1)=1;
    rx_b(ang>0 & ang<pi/2,2)=1;

    rx_b(ang>pi/2 & ang<pi,1)=1;
    rx_b(ang>pi/2 & ang<pi,2)=0;

    rx_b(ang>-pi/2 & ang<0,1)=0;
    rx_b(ang>-pi/2 & ang<0,2)=1;

    rx_b(ang>-pi & ang<-pi/2,1)=0;
    rx_b(ang>-pi & ang<-pi/2,2)=0;
    %BER CALCULUS
    BER(1,i)=sum(sum(xor(rx_b,tx_b)))/n;

end
plot(taps_r,BER)

toc



