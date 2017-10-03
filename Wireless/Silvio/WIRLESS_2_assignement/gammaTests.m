%Based on the assumption that in task2.mat is present only 1 sync pattern:

clear
sign=load('task2.mat');
%analizing with a more extend possible gammas, it's clear that the
%choice will fall in the low part of the gammas
%first analysis point a gamma between 15 and 22
possibleGamma=linspace(10, 30, 20000);
gammaHit=zeros(length(possibleGamma),1);

SNRdB=linspace(-5,10,40)';
sigH=sqrt((10.^(-SNRdB/10))./2);
noise=sigH*randn(1,length(sign.signal))+1i*(sigH*randn(1,length(sign.signal)));
received=repmat(sign.signal.',length(sigH),1)+noise;
pattern=(LFSR);
convVect=zeros(length(SNRdB),length(pattern));
convVal=zeros(1,length(SNRdB));
    for i=1:(length(sign.signal)-length(pattern))
        if(mod(i,1000)==0)
            i
        end
        %TODO-->lot of things
        convVect(:,:)=received(:,i:i+length(pattern)-1);
        convVal=(abs(convVect*pattern).^2)./diag(abs(convVect*convVect'));
        gammaHit(possibleGamma<convVal(:,1))=gammaHit(possibleGamma<convVal(:,1))+1;
    end

plot(possibleGamma,(gammaHit./(length(SNRdB))))