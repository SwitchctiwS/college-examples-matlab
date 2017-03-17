clear all;
close all;

tb = 1;
t = 0:tb/100:tb;
fc = 5;

q = sin(2 * pi * fc * t);
i = cos(2 * pi * fc * t);

n = 16;
m = rand(1, n);
m = round(m);

t1 = 0;
t2 = tb;

for index = 1:2:n-1
  t = [t1:0.01:t2];
  
  if m(index) == 1
    ms = ones(1, length(t))
  else
    ms = -1 * ones(1, length(t))
  end
  
  isig(index, :) = i .* ms;
  
  if m(index + 1) == 1
    ms = ones(1, length(t));
  else
    ms = -1 * ones(1, length(t));
  end

  qsig(index,:) = q .* ms;
  
  qpsk = isig + qsig;
  
  subplot(4, 1, 2);
  plot(t, qpsk(index,:));
  title('QPSK Signal');
  xlabel('t--->');
  ylabel('s(t)');
  grid on;
  hold on;
  
  t1 = t1 + tb;
  t2 = t2 + tb;
end
hold off;

subplot(4, 1, 1);
stem(m);
title('binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on;

tn = 0:tb/100:n.*tb;
i = sqrt(2/tb)*cos(2 * pi * fc * tn);
subplot(4, 1, 3);
plot(tn, i);
title('carrier signal');
xlabel('t--->');
ylabel('c1(t)');
grid on;

tn = 0:tb/100:n.*tb;
c2 = sqrt(2/tb) * sin(2 * pi * fc * tn);
subplot(4, 1, 4);
plot(tn, c2);
title('carrier signal');
xlabel('t--->');
ylabel('c2(t)');
grid on;
