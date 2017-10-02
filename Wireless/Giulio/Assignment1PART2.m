clear
SNRdB = 10;
sigma_square = 10^(-SNRdB/10);
sigma = sqrt(sigma_square);
my = load('image.mat');

n = 4*prod(my.image_size);

w1 = randn(n,1);
w2 = randn(n,1);
w1 = (sigma/(sqrt(2)))*w1;
w2 = (sigma/(sqrt(2)))*w2;

w = w1 + 1i*w2;

received = my.signal + w;
plot(real(received), imag(received), 'og','MarkerSize', 5);
hold on;
plot(real(my.signal), imag(my.signal), 'ok');


angles = angle(received);

receivedBits1(angles < (pi/2) & angles > 0) = 1;
receivedBits2(angles < (pi/2) & angles > 0) = 1;
receivedBits1(angles > (pi/2) & angles < pi) = 0;
receivedBits2(angles > (pi/2) & angles < pi) = 1;
receivedBits1(angles > -(pi/2) & angles < 0) = 1;
receivedBits2(angles > -(pi/2) & angles < 0) = 0;
%receivedBits1(angles < -(pi/2) & angles > -pi) = 0;
%receivedBits2(angles < -(pi/2) & angles > -pi) = 0;

received = [receivedBits1; receivedBits2];

received = reshape(received, 1, []);

image_decoder(received, my.image_size);











