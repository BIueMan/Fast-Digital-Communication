function [error_word]=detect_signal()
load RefCode;
load Tx_data;
load TSignal;
Signal=TSignal;
scl_fct = Tx_data.scl_fct;
ts=Tx_data.ts;
%nwv=Tx_data.nwv;
%np_bit=Tx_data.np_bit;
%npZeros=Tx_data.npZeros;
modulation=Tx_data.modulation;
%nPackets=Tx_data.nPackets;
nwv_det=find_nwv(Signal, RefCode);
np_bit=Tx_data.np_bit;
np_words = Tx_data.np_words;
%Data_seq=Signal(floor(nwv/2):nwv:end);
np_refcode=length(RefCode);
[RefPattern]=generate_refcode_signal(RefCode,nwv_det);
np_refpattern = length(RefPattern);
peaks_idx=correlation_peaks(Signal,RefPattern,np_refpattern);
%pk_start=max_correlation(Signal,RefCode);
%Seq_bit=Tx_data.Seq_bit;
%packet not found!
if(length(peaks_idx)<2)
    error_word=length(Tx_data.Words);
    warning('packet not found')
    return
end
first_packet_start=peaks_idx(1)-np_refcode*nwv_det;

second_packet_start=peaks_idx(2)-np_refcode*nwv_det;
try
if(first_packet_start<1)
    first_packet_start=peaks_idx(2)-np_refcode*nwv_det;
    second_packet_start=peaks_idx(3)-np_refcode*nwv_det;
end
catch
    beep
    error('number of packets less than 3. this program stopped')
end
Signal=Signal(first_packet_start+1:second_packet_start);
A_signal = abs(Signal);
%np_min = nwv * np_refcode * 2;
%ff = find(d_zcr < nwv_det*0.7);

n1 = np_refcode*nwv_det+1;
n2 = n1 + np_refcode;
if(n1>=n2||n2>length(Signal))
    error_word=length(Tx_data.Words);
    warning('packet not found')
    return
end
pwr_sig = sum( abs(Signal(n1:n2)) )/(n2-n1);
thr = 0.1*pwr_sig;

ff = find(flipud(A_signal)>thr);
Packet = 1/scl_fct * Signal(np_refpattern:end-ff(1)+1);

% remove zeros from the end of the packet, base on the energy
energy_cumsum = sqrt(cumsum(abs(flip(Packet).^2)));
[m,num_zeros] = max(diff(energy_cumsum));
Packet = Packet(1:end-num_zeros);


% find all zc
[Zero_cr] = zero_crossing(Packet,Tx_data.Ref_line,Tx_data.modulation);


% [nwv_det ,D_zcr,Zero_cr_detected] = eval_zc(ZC_t, Packet, RefCode);
% Smp_points=sample_points(round(Zero_cr_detected),nwv,np_words*nwv);
% % Words=Packet(round(Smp_points));
% Words=descremenator(Words,Tx_data.modulation);
Words=detected_words(Packet,Zero_cr,Tx_data,RefCode, nwv_det);
% error_word=sum(abs(Tx_data.Words/Tx_data.scl_fct-Words));
%error_word=sum(abs(Tx_data.Words-Words));

RefWords=(Tx_data.Words).';
switch modulation
        case {'QPSK','8PSK','PSK','16PSK','32PSK'}
            RefWords=RefWords./scl_fct;
end
error_word=0;
    if(~isrow(RefWords))
        RefWords=RefWords.';
    end 
    if(~isrow(Words))
        Words=Words.';
    end
if Tx_data.is_encoded
    L1=length(Words);
    L2=length(RefWords);
    if(L1<L2)
        Words=[Words,RefWords((L1+1):end)];
    end

    DetectedBits=word_demapper(Words,modulation,false);
    DecodedBits=decode_bits(DetectedBits);
    error_word=error_hamming(DecodedBits,Tx_data.Original_bits);%bits not words
    else
        error_word=error_hamming(RefWords,Words);
end
% IndicatorCrossing=40*ones(length(Signal),1);
% IndicatorCrossing(ZeroCross)=0;
% figure(6)
% plot(Signal)
% grid on;
% hold on
% stem(IndicatorCrossing,'o','LineStyle','none')
end