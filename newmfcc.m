clc
clear all
close all
csvwrite('C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\mfcctry.csv','');
for i=1:1:5
    
x1='cry (';
x2=i;
x3=').wav';
name1=strcat(x1,num2str(x2),x3);
namex='C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\try2\';
namef=strcat(namex,name1);
[y,fs]=audioread(namef);
%y=y1(44100*4:44100*100);
%sound(y,15100);
% plot(y);
y1=filter([1-.95],1,y);
% figure(2);
% plot(y1);
s=y(0.4*length(y):end);
% figure(3);
% plot(s);
n=256;
no_of_frames=round(5*fs/n);
%figure(4);
for k=1:size(y1,2)
    y2{k}=buffer(y1(:,k),256,35);
   % plot(y2{k});
end
x=y2{k};
win=hamming(n);
% figure(5);
% plot(win);
sq=diag(win)*x;
 figure(6);
 plot(sq);
f=fs/n.*(0:n-1);
y3=fft(sq,n);
y3=abs(y3(1:n)./(n/2));
 figure(7);
 plot(f,y3);
n1=256;
n2=1+floor(n/2);
m=melfb(1,n,fs);
z=m*abs(sq(1:n2,:).^2);
c=dct(log(z));
 plot(c)
length(c);
lol = diag(c);

for i=10:20
     ex(i-9)=lol(i);
end
lol(isnan(lol(:,1)),:) = [];
lol(isinf(lol(:,1)),:) = [];
%lol(isnull(lol(:,1)),:) = [];
lol;
%r = spCorrelum(y, fs, [], 'plot');
%f0 = spPitchCorr(r, fs)
%psdestx = psd(spectrum.periodogram,y,'Fs',1,'NFFT',length(y));
% power in frequency interval 1/4 to 1/2
%pwr = avgpower(psdestx,[1/4 1/2]);
%e=pwr(1);
vector=diag(lol);
% if vector(i)==0
%     continue;
% end
%vector(9)=f0;
%vector(10)=e;

% for i=25:length(vector)
%     vector(i)=0;
% end
vector';
dlmwrite('C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\mfcctry.csv',vertcat(vector'),'-append');

end


