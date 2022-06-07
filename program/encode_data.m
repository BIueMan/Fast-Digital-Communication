function [Enc,Pol,CL]=encode_data(Bit)
ScramSeq=scrambler(Bit);
Pol=[133,171];%the carcteristic polynom
CL=7;%number of delays elements+1;
trellis=poly2trellis(CL,Pol); 
Enc=convenc(ScramSeq,trellis);

end