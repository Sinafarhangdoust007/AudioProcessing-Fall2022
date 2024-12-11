%recording the audio
fs = 8000;
channels=1;
bits=16;
r = audiorecorder(fs , bits , channels);
duration = 5;
disp('recording started');
recordblocking(r,duration);
disp('recording stopped');
x = getaudiodata(r);
sound(x,fs,bits);
t = 0:1/fs:(length(x)-1)/fs;
subplot(4,1,1);
plot(t,x,'linewidth',1.5);
xlabel('time (sec)');
ylabel('amp');
title('time domain plot of the recording signal');
pause(5);
%fourier plane
n = length(x);
F=0:(n-1)*fs/n;
Y = fft(x,n);
F_0 = (-n/2 : n/2-1).*(fs/n);
Y_0 = fftshift(Y);
AY_0 = abs(Y_0);
subplot(4,1,2);
plot(F_0,AY_0,'linewidth' ,1.5');
xlabel('frequency (Hz)');
ylabel('amp');
title('frequency domain plot of audio signal');
pause(2);
%reversing the audio
z=flipud(x);
sound(z,fs,bits);
subplot(4,1,3);
plot(t,z,'linewidth',1.5);
pause(5);
%filter for reducing the noise
windowsize = 50 ;
b = (1/windowsize) * ones(1,windowsize);
a=1;
q = filter(b,a,x);
subplot(4,1,4);
plot(t,q);
sound(q);

