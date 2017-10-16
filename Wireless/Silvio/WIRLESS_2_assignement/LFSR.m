function pre= LFSR()
<<<<<<< HEAD

    pattern = [1;0;1;1;1;0;0;0];
    Np = 100;
    Bits = ones(Np,1);
    for i = 1:Np-8
       Bits(i+8,1) = mod((Bits(i:i+7,1).' * pattern),2);
    end
    Bits = Bits*2 -1;
    pre = Bits;
end    
    
=======
    chainLen=8;
    Np=100+chainLen;
    pattern=wrev([0;0;0;1;1;1;0;1]);
    temp=ones(Np,1);
    
    for i=1:(Np-chainLen)
        temp(i+chainLen,1)=mod((temp(i:i+chainLen-1,1).')*pattern,2);      
    end
    pre=2.*temp(1:Np-chainLen,1)-1;
    pre=(2.*temp(1:Np-chainLen,1)-1)+0i;
end
>>>>>>> 77e92aa0c0800da45c517624d739c58ff43bb784
