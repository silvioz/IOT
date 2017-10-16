function pre= LFSR()

    pattern = [1;0;1;1;1;0;0;0];
    Np = 100;
    Bits = ones(Np,1);
    for i = 1:Np-8
       Bits(i+8,1) = mod((Bits(i:i+7,1).' * pattern),2);
    end
    Bits = Bits*2 -1;
    pre = Bits;
end    
    