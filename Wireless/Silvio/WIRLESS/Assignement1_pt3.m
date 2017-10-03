function [out]=BER(Bits,SNRdB)
    tic
    NBits=4*800000;
    SNRdB=linspace(-6,12,30);
    Bits=randi(2,NBits,1) - 1;
    
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
    
    ber=zeros(1,length(SNRdB));
    ber2=zeros(1,length(SNRdB));
    receivedBits=zeros(2,length(symb));
    receivedBits2=zeros(2,length(symb2));
    temp=zeros(1,length(symb));
    temp2=zeros(1,length(symb2));
    
    for i=1:length(SNRdB)
        sigH=sqrt((10^(-SNRdB(i)/10))/2);
        noise=randn(1,length(symb))*sigH+1i*randn(1,length(symb))*sigH;
        temp=symb+noise;
        temp2=symb2+noise;
        ang=angle(temp);
        ang2=angle(temp2);
        
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
        
        received=reshape(receivedBits,1,[]);
        received2=reshape(receivedBits2,1,[]);
      
        ber(1,i)=sum(xor(received',Bits))/(length(Bits));
        ber2(1,i)=sum(xor(received2',Bits))/(length(Bits));
        if mod(i,10)==0
            i
        end
    end
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

