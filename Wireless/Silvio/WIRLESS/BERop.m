function [out]=BER(Bits,SNRdB)
    tic
    NBits=4*800000;
    SNRdB=linspace(-6,12,40);
    Bits=randi(2,NBits,1) - 1;
    
    SNRdB=reshape(SNRdB,1,[]);
    if mod(length(Bits),2)~=0
        return;
    end
    temp=2.*(reshape(Bits,2,[]))-1;
    symb=(temp(1,:)+ temp(2,:)*1i);
    
    symb2(symb==1+1i)=-1-1i;
    symb2(symb==1-1i)=-1+1i;
    symb2(symb==-1+1i)=1+1i;
    symb2(symb==-1-1i)=1-1i;
    
    symb=symb/sqrt(2);
    symb2=symb2/sqrt(2);
    
    sigH=(sqrt((10.^(-SNRdB./10))/2));
    
    sigH=repmat(sigH.',1,length(symb));
    symb=repmat(symb,size(sigH,1),1);
    symb2=repmat(symb2,size(sigH,1),1);
    
    noise=randn(size(sigH,1),size(sigH,2)).*sigH+1i*randn(size(sigH,1),size(sigH,2)).*sigH;
    temp=symb+noise;
    temp2=symb2+noise;
    ang=reshape((angle(temp).'),1,[]);
    ang2=reshape((angle(temp2).'),1,[]);
    
    clear temp temp2 noise sigH symb symb2
    toc
    tic
    receivedBits=ones(2,length(ang));
    receivedBits2=ones(2,length(ang2));
    receivedBits(1,ang>0 & ang<pi/2)=1;
    receivedBits(1,ang>pi/2 & ang<pi)=0;
    receivedBits(1,ang>-pi/2 & ang<0)=1;
    receivedBits(1,ang>-pi & ang<-pi/2)=0;
        
    receivedBits(2,ang>0 & ang<pi/2)=1;
    receivedBits(2,ang>pi/2 & ang<pi)=1;
    receivedBits(2,ang>-pi/2 & ang<0)=0;
    receivedBits(2,ang>-pi & ang<-pi/2)=0;
        
    receivedBits2(1,ang2>0 & ang2<pi/2)=0;
    receivedBits2(1,ang2>pi/2 & ang2<pi)=1;
    receivedBits2(1,ang2>-pi/2 & ang2<0)=0;
    receivedBits2(1,ang2>-pi & ang2<-pi/2)=1;
        
    receivedBits2(2,ang2>0 & ang2<pi/2)=1;
    receivedBits2(2,ang2>pi/2 & ang2<pi)=0;
    receivedBits2(2,ang2>-pi/2 & ang2<0)=0;
    receivedBits2(2,ang2>-pi & ang2<-pi/2)=1;
    toc
    tic
    received=reshape(receivedBits,1,[]);
    received2=reshape(receivedBits2,1,[]);
    received=vec2mat(received,length(Bits));
    received2=vec2mat(received2,length(Bits));
    toc
    tic
    clear ang
    ber=sum(xor(received.',repmat(Bits,1,size(received,1))),1)/(length(Bits));
    ber2=sum(xor(received2.',repmat(Bits,1,size(received2,1))),1)/(length(Bits));
    toc
    tic
    figure (1)
    semilogy(SNRdB,ber,'--r');
    xlabel('SNRdb')
    ylabel('BER')
    grid on
    hold on
    semilogy(SNRdB,ber2,'-.b');
    toc
    out=toc;
    clear
    
end


