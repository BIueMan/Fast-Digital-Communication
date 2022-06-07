function DecBits=decode_bits(Data)
try
Pol=[133,171];%the carcteristic polynom
CL=7;%number of delays elements+1;
trellis=poly2trellis(CL,Pol); 
VitSeq=vitdec(Data,trellis,32,'trunc','hard');
DecBits=scrambler(VitSeq');
catch
    DecBits=zeros(length(Data),1);
end
end