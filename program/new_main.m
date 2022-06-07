close all;
nPackets=4;
ts=0.1; %in [usec]
f_span=1/ts; % in [MHz]
nwv=10;
np_bit = 1024;
SNRV =[40:-2:4];
%SNRV = [100];
beta=-1;%0.50000005;%0.50000005;%beta==-1 is rectangular window
fct_AWGN_ph=0.0000001;

global to_plt
to_plt = false;
ErrV2=zeros(2,100,length(SNRV));
Mods={'QPSK','PSK','QAM16','QAM64'};
for mod_loop=1:(length(Mods)-1)
    mod=Mods(mod_loop);
    Tx_data.is_encoded=true;
    Tx_data.modulation=char(mod);%QPSK,PSK,QAM16,QAM64,8PSK,32PSK
    Tx_data=ref_lines(Tx_data);
    np_bit_mod=np_bit*modulation_bits_factor(Tx_data.modulation);

    Tx_data.ts=ts;
    Tx_data.nwv=nwv;
    Tx_data.np_bit=np_bit_mod;
    Tx_data.np_words = np_bit;
    Tx_data.RC_beta=beta;

    Rand_seq=(randn(np_bit_mod,1));
    
    Seq_bit_PSK = (sign(Rand_seq)+1)/2;
    Tx_data.Original_bits=Seq_bit_PSK;
    if Tx_data.is_encoded
        [Seq_bit_PSK,Pol,CL]=encode_data(Seq_bit_PSK);
    end
    
    Seq_bit_clk = (1+(-1).^(0:np_bit_mod-1))/2;
    Seq_bit=Seq_bit_PSK;
    %        Seq_bit=Seq_bit_clk;%replace with Seq_bit_PSK

    Tx_data.Seq_bit=Seq_bit;

    Tx_noise.phase_dist=fct_AWGN_ph;
    Tx_data.Tx_noise=Tx_noise;%SNR
    Tx_data.npZeros = max(nwv*np_bit/16,32)+45;%+5 for alignment in detection;
    Tx_data.nPackets=nPackets;

    [Signal,window,Words] = generate_signal(Tx_data);
    Tx_data.Words=Words;


    np_psk = length(Signal);
    T = [0:np_psk-1]*ts;
    % frequncy domain(FD) analysis
    df=1/T(end);
    FR=[0:np_psk-1]*df;
    for j_loop=1:100
        for i_snr=1:length(SNRV)
            SNR=SNRV(i_snr);
            Tx_noise.AWGN_snr=SNR;%SNR
            TSignal = add_distortion(Signal,Tx_noise);
            global to_plt
            if to_plt
                figure(1)
                plot(T(1:20*nwv),real(TSignal(1:20*nwv)),'linewidth',2);
                xlabel('Time[usec]')
                ylabel('Signal(Ampl)')
                grid;
                title(['Generated ',Tx_data.modulation ,' signal,real part,SNR=',num2str(SNR)])
            end



            HW=fftshift(fft(TSignal));
            AHW=abs(HW);
            AHW_db=20*log10(AHW/np_bit);
            %generate eye pattern diagram
            eye_pattern(TSignal,nwv,Tx_data.modulation)

            %%%%%%%%%%%%%Save signal as ascii
            I=real(TSignal);
            Q=imag(TSignal);
            MT=[I,Q];
            % fileName=['C:\Users\idan.tz\Desktop\project\','sig_',Tx_data.modulation,'.dat'];
            % save -ascii fileName MT
            %cd 'C:\Users\idan.tz\Desktop\project\experiment';
            %cd PSK_files
            pause(0.5);
            save TSignal TSignal
            save Tx_data Tx_data
            err=detect_signal;
            if err > 0
                disp(['SNR[dB]=', int2str(round(SNR)),' - Detected words error, modulation= ',Tx_data.modulation,': ',int2str(err)]);
            else
                disp(['SNR[dB]=', int2str(round(SNR)),' - No errors detected, modulation= ',Tx_data.modulation,': ',int2str(err)]);
            end

            ErrV2(mod_loop,j_loop,i_snr)=err;
        end
    end
    global to_plt
    if to_plt
    figure (664)
    plot(SNRV,ErrV2)
    title(['Detected Error vs. SNR ',Tx_data.modulation])
    end
end




