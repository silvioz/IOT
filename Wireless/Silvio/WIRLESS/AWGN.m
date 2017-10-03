clear
sign=load('image.mat');
SNRdb=10;
constellation=[1+1i,1-1i,-1+1i,-1-1i]/sqrt(2);
sigH=sqrt((10^(-SNRdb/10))/2);
noise=randn(1,4*prod(sign.image_size))*sigH+1i*randn(1,4*prod(sign.image_size))*sigH;
received=sign.signal+noise.';
%plot(real(received),imag(received),'or');
%hold on
%plot(real(constellation),imag(constellation),'ob');
ang=angle(received);

receivedBit=ones(2,4*prod(sign.image_size));
receivedBit(1,ang>0 & ang<pi/2)=1;
receivedBit(1,ang>pi/2 & ang<pi)=0;
receivedBit(1,ang>-pi/2 & ang<0)=1;
receivedBit(1,ang>-pi & ang<-pi/2)=0;

receivedBit(2,ang>0 & ang<pi/2)=1;
receivedBit(2,ang>pi/2 & ang<pi)=1;
receivedBit(2,ang>-pi/2 & ang<0)=0;
receivedBit(2,ang>-pi & ang<-pi/2)=0;
received_vec=reshape(receivedBit,1,[]);

compressed_decoder(received_vec, sign.image_size)