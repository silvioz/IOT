%Based on the assumption that in task2.mat is present only 1 sync pattern:

clear
sign=load('task2.mat');
%analizing with a more extend possible gammas (10:100), it's clear that the
%choice will fall in the low gamma
possibleGamma=linspace(14, 25, 1000);
gammaHit=zeros(length(possibleGamma),1);

SNRdB=linspace(-5,10,40)';
sigH=sqrt((10.^(-SNRdB/10))./2);
noise=sigH*randn(1,length(sign.signal))+1i*(sigH*randn(1,length(sign.signal)));
received=repmat(sign.signal.',length(sigH),1)+noise;
pattern=(LFSR);
convVect=zeros(1,length(pattern));
convVal=zeros(length(sign.signal),1);
for j=1:length(SNRdB);
    j
    for i=1:(length(sign.signal)-length(pattern))
        convVect(1,:)=received(j,i:i+length(pattern)-1);
        convVal=(abs(pattern'*convVect.')^2)/abs(convVect*convVect');
        gammaHit(possibleGamma<convVal)=gammaHit(possibleGamma<convVal)+1;
    end
end

plot(possibleGamma,(gammaHit./(length(SNRdB))))