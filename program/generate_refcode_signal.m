function [RefSig]=generate_refcode_signal(RefCode,nwv)

%generate PSK with convolution


Seq_word=RefCode;
np_word=length(Seq_word);


%WND = ones(nwv,1);
[x,WND] = RaisedCosine(5,nwv,-1);


WND = WND';
np_wnd = length(WND);


%generate signal with filter
a=[1];
Dseq = zeros(np_word*nwv,1);
IDX_delta=[1:nwv:np_word*nwv];
Dseq(IDX_delta)=Seq_word;
Signal_flt=filter(WND,a,Dseq);
RefSig=Signal_flt;
%end
return