clear
profile off
profile on
signal=load('task2.mat');
SNRdB=-5;
addNoise='n';
Nsymb=666000;
imgSyze=[333 500];
gamma=3.3;

firstFrame=syncronizer(signal,SNRdB,addNoise,gamma);
symbols=signal.signal(firstFrame(1):(firstFrame(1)+Nsymb-1));
b=demapper(symbols);
image_decoder(b,imgSyze);


profile off
profile viewer