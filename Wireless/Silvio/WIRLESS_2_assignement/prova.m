clear
SNRdb=-5;
pattern=LFSR;
pattern2=zeros(length(pattern)*20,1);
pattern2(length(pattern)*14:length(pattern)*15-1,1)=pattern;
pattern=pattern+0i;
pattern2=pattern2+0i;

sigH=sqrt((10^(-SNRdb/10))/2);
noise=randn(1,length(pattern2))*sigH+1i*randn(1,length(pattern2))*sigH;
pattern2=pattern2+noise.';

convVect=zeros(length(pattern),1);
convVal=zeros(length(pattern2),1);
for i=1:(length(pattern2)-length(pattern))
    convVect(:,1)=pattern2(i:i+length(pattern)-1,1);
    convVal(i)=abs(pattern'*convVect);
end

plot(convVal)