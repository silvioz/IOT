clear
sign=load('task2.mat');
SNRdb=1:2:10;
sigH=sqrt((10^(-SNRdb/10))/2);
noise=randn(1,length(sign.signal))*sigH+1i*randn(1,length(sign.signal))*sigH;
received=sign.signal+noise.';
