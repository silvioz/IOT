clear
profile on
gamma=linspace(14.5,17,2000);
signal=load('task2.mat');
SNRdB=linspace(-5,10,30);
sigH=sqrt((10.^(-SNRdB/10))./2);
noise=sigH.'*randn(1,length(signal.signal))+1i*sigH.'*randn(1,length(signal.signal));  
received=repmat(signal.signal.',length(SNRdB),1)+noise;
pattern=(LFSR);
convVal=zeros(length(SNRdB),length(signal.signal));

%correlator
for i=1:(length(signal.signal)-length(pattern))
    convVal(:,i)=(abs(received(:,i:i+length(pattern)-1)*pattern).^2)./diag(abs(received(:,i:i+length(pattern)-1)*received(:,i:i+length(pattern)-1)'));
end

sync=zeros(length(gamma));
for i=1:length(gamma)
    sync(i,:)=sum(sum((sign(convVal-gamma(i))+1)./2)./length(SNRdB),2);
    if(mod(i,100)==0)
        i
    end
end
plot(gamma,sync);
profile off
profile viewer