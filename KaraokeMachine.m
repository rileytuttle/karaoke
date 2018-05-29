%Karaoke Machine

function KaraokeMachine(filename);
% clear workspace
clear all
clc
% read in wav file

try
  [g,fs] = wavread(filename); % octave command
catch
  [g,fs] = audioread(filename); % matlab command
end

left = g(:,1);
right = g(:,2);
fftL = fft(left);
fftR = fft(right);

for i = 1:683550 %in my example 683550
  dif = fftL(i,1) / fftR(i,1);
  dif = abs(dif);
  if (dif > 0.7 & dif < 1.5)
    fftL(i,1) = 0;
    fftR(i,1) = 0;
  end;
end;

leftOut = ifft(fftL);
rightOut = ifft(fftR);
yOut(:,1) = leftOut;
yOut(:,2) = rightOut;

sound(yOut,fs);
