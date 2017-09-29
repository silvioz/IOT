clear
E=[0    1/3     0   0;
   0    0       1/2 0; 
   1/2  1/3     0   0; 
   1/2  1/3     1/2 0];
l=length(E);
it=100;
x0=rand(l,1);
x0=x0/sum(x0);
p=0.15;

lam=zeros(1,l);
lam(sum(abs(E))==0)=1;
M=(1-p).*(E+(1/l).*ones(1,l).'*lam)+p*ones(l,l)./l;

[V,D]=eig(E);
lamb=D*ones(l,1);
v=V(:,abs(lamb)==max(abs(lamb)));
lamb=max(abs(lamb));
v=v/sum(v);
diff=ones(it,1);   
for iter=1:it
    x0=M*x0;
    diff(iter)=norm(x0-v);
end

plot(diff);


