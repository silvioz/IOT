function [syncOut]=syncronizer(signal,SNRdB,addNoise,gamma)
%profile on
%gamma=9;
%gamma found with experiment: 17 or near (other matlab test code)
%signal=load('task2.mat');
%SNRdb=-5;
%addNoise='n';
if addNoise=='y'
    sigH=sqrt((10^(-SNRdB/10))/2);
    noise=randn(1,length(signal.signal))*sigH+1i*randn(1,length(signal.signal))*sigH;  
    received=signal.signal+noise.';
else
    received=signal.signal;
end
pattern=(LFSR);
convVal=null(length(signal.signal),1);
%correlator

for i=1:(length(signal.signal)-length(pattern))
    convVal(i)=(abs(pattern'*received(i:i+length(pattern)-1,1))^2)/abs(received(i:i+length(pattern)-1,1)'*received(i:i+length(pattern)-1,1));
end

sync=round((sign(convVal-gamma)+1)./2);
syncOut=find(sync==1)+length(pattern);
sync(sync==0)=NaN;
plot(convVal)
hold on
plot(sync.*gamma,'ro');
%profile off
%profile viewer