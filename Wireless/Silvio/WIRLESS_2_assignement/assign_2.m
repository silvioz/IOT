clear
sign=load('task2.mat');
SNRdb=1;
sigH=sqrt((10^(-SNRdb/10))/2);
noise=randn(1,length(sign.signal))*sigH+1i*randn(1,length(sign.signal))*sigH;
received=sign.signal+noise.';
pattern=(LFSR);
convVect=zeros(length(pattern),1);
convVal=zeros(length(sign.signal),1);
for i=1:(length(sign.signal)-length(pattern))
    convVect(:,1)=received(i:i+length(pattern)-1,1);
    convVal(i)=(abs(pattern'*convVect)^2)/abs(convVect'*convVect);
end

plot(convVal)