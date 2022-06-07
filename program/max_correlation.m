function [idx,val]=max_correlation(Data,Pattern)
load Tx_data;
[RefPattern]=generate_refcode_signal(Pattern,Tx_data);

C=conv(Data,flip(RefPattern),'same');
global to_plt
if to_plt
figure(143);
plot(C/10)
xlabel("Sample")
ylabel("Amp")
title("Signal correlation");
end

[val,idx]=max(C);
%remove half of center of pattern to get starting point
idx=idx-floor(length(Pattern)/2);
end