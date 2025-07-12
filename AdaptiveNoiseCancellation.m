fs = input('Enter sampling frequency (Hz): ')  % Sampling Frequency
duration = input('Enter signal duration (seconds): ');  % Duration of signal
freq = input('Enter frequency of desired signal (Hz): ');  % Desired signal frequency
noise_level = input('Enter noise amplitude (0-1): ');  % Noise level
M = input('Enter number of filter taps (M): ');  % Adaptive filter taps
mu = input('Enter learning rate (mu): ');  % Learning rate

% Time Vector
t = 0:1/fs:duration;  

% Generate Signals
desired_signal = sin(2 * pi * freq * t);  
noise = noise_level * randn(size(t));  
primary_signal = desired_signal + noise;  
reference_signal = [zeros(1, 10), noise(1:end-10)];  

% LMS Adaptive Filtering
N = length(primary_signal);
W = zeros(M, 1);
error_signal = zeros(1, N);

for n = M:N
    x = reference_signal(n:-1:n-M+1)';  
    y = W' * x;  
    error_signal(n) = primary_signal(n) - y;  
    W = W + mu * x * error_signal(n);  
end

% Plot Results
figure;
subplot(3,1,1); 
plot(t, primary_signal); 
title('Noisy Primary Signal');
subplot(3,1,2); 
plot(t, error_signal); 
title('Filtered Output (Noise Reduced)');
subplot(3,1,3); 
plot(t, desired_signal); 
title('Original Desired Signal');
sgtitle('Adaptive Noise Cancellation using LMS Algorithm');
