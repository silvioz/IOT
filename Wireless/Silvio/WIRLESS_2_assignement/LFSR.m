function pre= LFSR()
    chainLen=8;
    Np=100+chainLen;
    pattern=wrev([0;0;0;1;1;1;0;1]);
    temp=ones(Np,1);
    
    for i=1:(Np-chainLen)
        buff=(temp(i:i+chainLen-1,1).');
        temp(i+chainLen,1)=mod((temp(i:i+chainLen-1,1).')*pattern,2);      
    end
<<<<<<< HEAD
    pre=2.*temp(1:Np-chainLen,1)-1;
    sum(pre)
=======
    pre=(2.*temp(1:Np-chainLen,1)-1)+0i;
>>>>>>> 59bf552f48af11db87ab9250d2149db86b148e79
end