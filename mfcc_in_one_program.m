% MFCC feature extraction 
clc;
clear all;
close all;
n = 256;
%since formula for frame length = total samples * time
% In my case it is 220500 (5 sec), and time = 29 ms
[signal,fs] = audioread('C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\4_hu.wav');
figure(1)
plot(signal)
title('Recorded signal');
xlabel('Number of samples');
ylabel('Pitch');
%frame=blockFrames(s, fs, m, n);
%[ signal , fs ] = audioread('speaker10.wav');
s = filter ([1 -.95], 1, signal);
frame_length = 256;
figure(2)
plot(s)
title('Pre emphasis is done');
xlabel('Number of samples');
ylabel('Pitch');
frame_step = 0.025;% The time for each frame
N = 256;
Number_of_frames_without_overlapping = round(5*fs/256)
for K = 1 : size(s,2)
  y{K} = buffer(s(:,K),256,100);
end
figure(3)
plot(y{K})
title('Framing is done');
xlabel('Samples');
ylabel('Amplitude');
%size(s)
%plot(y{1})
x = y{K};
%w(n) = 0.54-0.46*real(cos(2*pi*n/N - 1));
%h=0.54 - 0.46*cos(2.0*pi*(1:N)'/(N+1));
n1 = 0:(N);
% Applying the black man windowing technique
h=0.42-0.5*cos(2*pi*(1:n)'/(N-1))+0.08*cos(4*pi*(1:n)'/(N-1));

y = x.*h;
%Fourier = fft(y);
figure(4)
plot(y)
title('Blackman windowing process');
xlabel('Samples');
ylabel('Amplitude');

y = fft(y);
frame =y.*conj(y);
figure(9);
plot(frame)
title('Fourier transform of the signal');

m = melfb(20, n, fs);
figure(6) 
plot(linspace(0, (16000/2), 129), melfb(20, 256, 44100)')
title('Mel-spaced filterbank'), xlabel('Frequency (Hz)');
n2 = 1 + floor(n / 2);
% z = m * abs(frame(1:n2, :)).^2;
z = m * abs(frame(1:n2, :)).^2;
Feature = dct(log(z));
figure(7)
plot(Feature)
title('Extracted features from the signal');

% Compterssion using VQ method
[M, N] = size(Feature);
for i2=1:M
    for j2=1:N
        if  isinf(Feature(i2,j2))
            Feature(i2,j2) = 0;
        elseif isnan(Feature(i2,j2)) 
            Feature(i2,j2) =0;
        end
    end
end
%d = Feature(:,2:end);
%k = input('Enter the number of centroids : ');
k=64;
figure(8)
codebook1 = vqlbg(Feature,k);
[M, N] = size(codebook1);
for i2=1:M
    for j2=1:N
        if  isinf(codebook1(i2,j2))
            codebook1(i2,j2) = 0;
        elseif isnan(codebook1(i2,j2)) 
            codebook1(i2,j2) =0;
        end
    end
end
codebook{1} = codebook1;
plot(codebook{1})
title('Compressed data');
%codebook{1} = Feature;

