% For 16-QAM

% Startup stuff
clear all;
close all;

% Given values
timebase = 1;
tpoints = 0: timebase/100: timebase;
carrfreq = 5;

q = sin(2 * pi * carrfreq * tpoints);
i = cos(2 * pi * carrfreq * tpoints);

numbits = 64;
intel = [0 0 0 0 0 0 0 1 0 0 1 1 0 0 1 0 0 1 1 0 0 1 1 1 0 1 0 1 0 1 0 0 1 1 0 0 1 1 0 1 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 0 0 1 1 0 0 0]; % Grey code
%intel = rand(1, numbits);
%intel = round(intel);

inittime = 0;
fintime = timebase;

% Find phase and amplitude of wave
% Analyze 4 bits at a time
for index = 1: 4: numbits - 3
  tpoints = [inittime: 0.01: fintime];
  
  % Change amplitude of portion of wave
  % Assume First two bits are cosine
  if intel(index) == 1 && intel(index + 1) == 1
    intelamp = 3 * ones(1, length(tpoints));
  
  elseif intel(index) == 1 && intel(index + 1) == 0  
    intelamp = 1 * ones(1, length(tpoints));
  
  elseif intel(index) == 0 && intel(index + 1) == 1
    intelamp = -1 * ones(1, length(tpoints));
  
  else % intel(index) == 0 && intel(index + 1) == 0
    intelamp = -3 * ones(1, length(tpoints));
  end
  
  isig(index, :) = i .* intelamp; % Waveform of first 2 bits
  
  % Assume last two bits are sine
  if intel(index + 2) == 1 && intel(index + 3) == 1
    intelamp = 3 * ones(1, length(tpoints));
  
  elseif intel(index + 2) == 1 && intel(index + 3) == 0  
    intelamp = 1 * ones(1, length(tpoints));
  
  elseif intel(index + 2) == 0 && intel(index + 3) == 1
    intelamp = -1 * ones(1, length(tpoints));
  
  else % intel(index + 2) == 0 && intel(index + 3) == 0
    intelamp = -3 * ones(1, length(tpoints));
  end
  
  qsig(index, :) = q .* intelamp; % Waveform of last 2 bits
  
  qpsk = isig + qsig; % Waveform of all 4 bits
  
  % Plot 4-bit portion of waveform
  subplot(4, 1, 2);
  plot(tpoints, qpsk(index,:));
  title('QPSK Signal');
  xlabel('Time (t)');
  ylabel('s(t)');
  grid on;
  hold on;
  
  % Go to next portion of signal (next 4 bits)
  inittime = inittime + timebase;
  fintime = fintime + timebase;
end
hold off;

% Plot stem graph of binary data
subplot(4, 1, 1);
stem(intel);
title('Binary Data Bits');
xlabel('Bit Number (n)');
ylabel('b(n)');
grid on;

% Plot carrier1 (cos) signal
% Plots carrfreq waves for each bit
tn = 0: timebase / 100: numbits * timebase;
c1 = sqrt(2 / timebase) * cos(2 * pi * carrfreq * tn);
subplot(4, 1, 3);
plot(tn, c1);
title('Carrier Signal');
xlabel('Time (t)');
ylabel('c1(t)');
grid on;

% Plot carrer2 (sin) signal
% Plots carrfreq waves for each bit
tn = 0: timebase / 100: numbits * timebase;
c2 = sqrt(2 / timebase) * sin(2 * pi * carrfreq * tn);
subplot(4, 1, 4);
plot(tn, c2);
title('Carrier Signal');
xlabel('Time (t)');
ylabel('c2(t)');
grid on;
