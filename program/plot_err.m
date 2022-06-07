load ErrV
load ErrDNoPSK
Mods={'QPSK','PSK','QPSK','QAM16','QAM64','8PSK','32PSK'};%{'QPSK','PSK','QPSK','QAM16','QAM64','8PSK','32PSK'};
SNRV =[40:-2:4];
for i=1:3
Err=reshape(ErrV(i,:,:),[100,19]);
AvgErr=mean(Err,1);
ErrDecoding=reshape(ErrDNoPSK(i,:,:),[100,19]);
AvgErrDecoding=mean(ErrDecoding,1);
figure(i);
plot(SNRV,AvgErr,'LineWidth',6);
hold on;
title(['Avg Error for modulation ',char(Mods(i))]);
legend('without decoding','with decoding')
xlabel('SNR')
ylabel('Average Error for 100 iterations');

hold off;
grid on

end