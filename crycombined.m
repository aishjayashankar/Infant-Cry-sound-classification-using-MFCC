%%Program to plot speech segment, Log magnitude spectrum and real cepstrum
clc
clear all
close all
csvwrite('C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\pitchdata.csv','');
for i=1:1:70
x1='cry (';
x2=i;
x3=').wav';
name1=strcat(x1,num2str(x2),x3);
namex='C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\try2\';
namef=strcat(namex,name1);
[y,Fs]=audioread(namef);%%input: speech segment
audioIn=audioread(namef);
audioIn = audioIn(1*44100:7*44100);

nn = 7;
beginFreq = 700 / (Fs/2);
endFreq = 12000 / (Fs/2);
[b,a] = butter(nn, [beginFreq, endFreq], 'bandpass');
fOut = max(filter(b, a, audioIn));

ener=rms(audioIn);
zeros2=zeros(1:(512-length(y)));
zeros3=zeros(1:(1512-length(y)));
max_value=max(abs(y));
y=y/max_value;
t=(1/Fs:1/Fs:(length(y)/Fs))*1000;
subplot(2,1,1);plot(t,y);
y=[y zeros2];
yy=[y zeros3];
dfty=abs(fft(y));
dftyy=abs(fft(yy));
dfty1=dfty(1:length(dfty)/2);
dftyy1=dftyy(1:length(dftyy)/2);
tt=linspace(1/Fs,Fs/2,length(dftyy1));
dftylog=log10(dfty);
dftyylog=log10(dftyy);
dftylog1=dftylog(1:length(dftylog)/2);
dftyylog1=dftyylog(1:length(dftyylog)/2);
yy=10*dftylog1;
yyy=10*dftyylog1;
subplot(2,1,2);
plot(tt,yyy);
real_ceps=abs(ifft(dftylog));
real_ceps=real_ceps(1:length(real_ceps)/2);
t=(1/Fs:1/Fs:(length(y)/Fs))*1000;
t=(t(1:length(t)/2));
%subplot(3,1,3);
%plot(t,real_ceps);
real_ceps_pitch=real_ceps(16:length(real_ceps));
max1=max(real_ceps_pitch);
for uu=1:length(real_ceps_pitch)
  real_ceps_pitch(uu);
    if(real_ceps_pitch(uu)==max1)
      sample_no=uu;
    end 
end
  pitch_period_To=(16+sample_no)*(1/Fs);
  pitch_freq_FO=1/pitch_period_To;
  b=pitch_freq_FO/5;
  a(i)= b;
  pD = audiopluginexample.SpeechPitchDetector;
%visualize(pD);
%audioTestBench(pD);
[~,pitch] = process(pD,audioIn');
mini(i)=min(pitch);
maxi(i)=max(pitch);





dlmwrite('C:\Users\aishu\Downloads\VIT\sem6\paper\Cry\pitchdata.csv',horzcat(mini(i),maxi(i),a(i),ener,fOut(1)),'-append');
end
%mini(isnan(mini(:,1)),:) = [];
%out = mini(:,any(~isnan(mini)));
%out = mini(any(~isnan(mini),2),:); 