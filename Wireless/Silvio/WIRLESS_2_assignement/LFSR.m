function pre= LFSR()
    chainLen=8;
    Np=100+chainLen;
    pattern=[0;0;0;1;1;1;0;1];
    temp=ones(Np,1);
    
    for i=1:(Np-chainLen-1)
        temp(i+chainLen,1)=mod((temp(i:i+chainLen-1,1).')*pattern,2);      
    end
    pre=2.*temp(1:Np-chainLen,1)-1;
    sum(pre)
end