clear
%this is the entry point script
%in "prova" there's a test of the correlator with the pure LFSR sequence
%findGamma is a Script that help to find the optimal value of gamma
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
profsave