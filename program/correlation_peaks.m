function [Idx,Val]=correlation_peaks(Data,RefPattern,Treshhold)
load Tx_data;

%C=conv(Data,flip(RefPattern),'same');
C=filter(flipud(conj(RefPattern)),1,Data);
[Idx]=find(C>=Treshhold*0.98);
Val = C(Idx);
%remove half of center of pattern to get starting point
%Idx=Idx-floor(length(RefPattern)/2);

end