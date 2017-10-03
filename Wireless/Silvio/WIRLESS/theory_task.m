sym1=[3+3i,3-3i,-3+3i,-3-3i];
sym2=[3,-3,3i,-3i,6+6i,-6-6i];

figure (1)
plot(real(sym1),imag(sym1),'or');
hold on
plot(real(sym2),imag(sym2),'ob');
grid on


Emean1=(sym1*sym1')./size(sym1,2);
Emean2=(sym2*sym2')./size(sym2,2);

newSym1=sym1./sqrt(Emean1);
newSym2=sym2./sqrt(Emean2);

EmeanNew1=(newSym1*newSym1')./size(newSym1,2);
EmeanNew2=(newSym2*newSym2')./size(newSym2,2);

figure (2)
plot(real(newSym1),imag(newSym1),'or');
hold on
plot(real(newSym2),imag(newSym2),'ob');
grid on

%it's possible to observe that in the second constellation the "farest"
%symbols (the more energetic ones) shrink the central part of the
%constellation once we try to normalize: this fact could lead to an higher
%number of error