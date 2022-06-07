function Signal=add_distortion(Signal,Tx_noise)
%add convertion from SNR(Energy) to awgn factor

fct_noise = Tx_noise.AWGN_snr;%SNR
fct_AWGN_ph = Tx_noise.phase_dist;

np_psk = length(Signal);

PH=asin(Signal);

%noise variance calculation
signal_power = sum(abs(Signal).^2);%
signal_length = length(Signal);
noise_std=0;%sqrt(10^(fct_noise/20)*signal_power);
noise_std=sqrt(signal_power*10^(-fct_noise/10)/signal_length/2);
if isreal(Signal)
    noise_std=noise_std*sqrt(2);
    
end

AWGN_ph_rad=fct_AWGN_ph*pi*randn(np_psk,1);
PH_w_noise=PH+AWGN_ph_rad;

PSK_sig_w_ph_noise=sin(PH_w_noise);

AWGN_ampl = noise_std*randn(np_psk,1);%AWGN= additive white gausian noise
if ~isreal(Signal)
    AWGN_ampl = AWGN_ampl + j*noise_std*randn(np_psk,1);%AWGN= additive white gausian noise
end
Signal=Signal+AWGN_ampl;

% 
% figure(1)
% plot(Signal)
% grid on
% hold on
% plot(AWGN_ampl)
% hold off
% 
% noise_pwr = sqrt(sum(abs(AWGN_ampl).^2));
% signal_pwr = sqrt(sum(abs(Signal).^2));


return