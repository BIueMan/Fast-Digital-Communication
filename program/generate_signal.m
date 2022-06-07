function [Signal,Window,Words]=generate_signal(Tx_data)
load RefCode
ts=Tx_data.ts;
nwv=Tx_data.nwv;
np_bit=Tx_data.np_bit;
npZeros=Tx_data.npZeros;
scl_fct = Tx_data.scl_fct;
modulation=Tx_data.modulation;
beta=Tx_data.RC_beta;
nPackets=Tx_data.nPackets;
%generate PSK with convolutionTx_data


Seq_bit=Tx_data.Seq_bit;
[Seq_word]=word_mapper(Seq_bit,modulation);
Words=Seq_word;
np_word=length(Seq_word);


%WND = ones(nwv,1);
[x,WND] = RaisedCosine(5,nwv,beta);
global to_plt
if to_plt
figure(99);
plot(x,WND);
title('Shaping window');
end

WND = WND';
np_wnd = length(WND);

 Dseq = zeros(np_word*nwv,1);
 IDX_delta= [nwv/2:nwv:np_word*nwv];
 Dseq(IDX_delta)=Seq_word;
 ref_CSignal=conv(WND,Dseq);
 LWND=length(WND);
 CSignal=ref_CSignal((LWND-1)/2+1:end-(LWND-1)/2);
Signal_flt=CSignal;
% %generate signal with filter
% a=[1];
% Dseq = zeros(np_word*nwv,1);
% IDX_delta=[1:nwv:np_word*nwv];
% Dseq(IDX_delta)=Seq_word;
% Signal_flt=filter(WND,a,Dseq);

%pad with zeros and add ref code
RefSignal=repmat(RefCode',nwv,1);
RefSignal=RefSignal(:);
Packet=[zeros(npZeros,1);RefSignal;Signal_flt*scl_fct];

Signal=repmat(Packet,nPackets,1);

%truncate trace
if nPackets>1
nStart=round(npZeros*1.2);
nEnd=length(Signal)-round(npZeros*1.25);
Signal=Signal(nStart:nEnd);
end
global to_plt
if to_plt
   figure(31)
    plot(complex(Signal))
    title('Trajectory diagram.')
    grid;
   axis square;
   hold on;
   plot(complex(Signal(5*nwv+1:nwv:end)),'O','linewidth',2.5,...
    'color','y')
   
   hold off;
end

A_signal=abs(Signal);
%peak to average (crest factor)
pk2avr=max(A_signal)/mean(A_signal);
pk2avr_db=20*log10(pk2avr);
global to_plt
if to_plt
    figure(1)
    plot(real(Signal))
    xlabel('');
    ylabel('')
    grid;
    title([]);
end

mx = max(abs(Signal));
Signal_normalized=Signal/mx;%normalized
Window=WND;
%end

        % plot graff for words
        DP_size = 20; % data plot size
        global to_plt
if to_plt
        figure(21)
        stem(Seq_bit(1:DP_size)*2-1)
        xlabel('Sample');
        ylabel('Amplitude[Hz]')
        grid;
        title("Input Data");
        
        figure(22)
end
        S_plot = Signal_flt(50:(DP_size*nwv + 50));
        global to_plt
if to_plt
        plot(imag(S_plot))
        xlabel('Time[sec]');
        ylabel('Amplitude[Hz]')
        grid;
        xlim([0 length(S_plot)])
        title('Imaginary Part');
        
        figure(23)
        plot(real(S_plot))
        xlabel('Time[sec]');
        ylabel('Amplitude[Hz]')
        grid;
        xlim([0 length(S_plot)])
        title('Real Part');
end

return