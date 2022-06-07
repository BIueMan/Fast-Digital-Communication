function SeqBit=word_demapper(Words,modulation,scale)

switch modulation
        case 'PSK'
            SeqBit=(Words+1)/2;
        case 'QPSK'
            if scale
                Words=Words*sqrt(2);
            end
            SeqBitRe=(real(Words)+1)/2;
            SeqBitIm=(imag(Words)+1)/2;
            LenWords=length(Words);
            SeqBit=zeros(LenWords*2,1);
            Odds=1:2:2*LenWords;
            Evens=Odds+1;
            SeqBit(Evens')=SeqBitIm(Evens/2);
            SeqBit(Odds')=SeqBitRe((Odds+1)/2);
            L=length(SeqBit);
            SeqBit=[SeqBit;zeros(mod(L,4),1)];
            L=length(SeqBit);
            SB=reshape(SeqBit,L/4,4);
            GB=gray2bin(SB);
            SeqBit=reshape(GB,[L,1]);
            return
        case 'QAM16'
            LenWords=length(Words);
            SeqBitRe=de2bi(round((real(Words)+3)/2));
            SeqBitIm=de2bi(round((imag(Words)+3)/2));
            I_stream=reshape(SeqBitRe',LenWords*2,1);
            Q_stream=reshape(SeqBitIm',LenWords*2,1);
            SeqBit=zeros(LenWords*4,1);
            SeqBit(1:4:LenWords*4)=I_stream(1:2:LenWords*2);
            SeqBit(2:4:LenWords*4)=I_stream(2:2:LenWords*2);
            SeqBit(3:4:LenWords*4)=Q_stream(1:2:LenWords*2);
            SeqBit(4:4:LenWords*4)=Q_stream(2:2:LenWords*2);
            L=length(SeqBit);
            SB=reshape(SeqBit,L/4,4);
            GB=gray2bin(SB);
            SeqBit=reshape(GB,[L,1]);

            
        case 'QAM64'%(real =1,2,3)+j(img=4,5,6)
            LenWords=length(Words);
            SeqBitRe=de2bi(round((real(Words)+7)/2));
            SeqBitIm=de2bi(round((imag(Words)+7)/2));
            I_stream=reshape(SeqBitRe',LenWords*3,1);
            Q_stream=reshape(SeqBitIm',LenWords*3,1);
            SeqBit=zeros(LenWords*6,1);
            SeqBit(1:6:LenWords*6)=I_stream(1:3:LenWords*3);
            SeqBit(2:6:LenWords*6)=I_stream(2:3:LenWords*3);
            SeqBit(3:6:LenWords*6)=I_stream(3:3:LenWords*3);
            SeqBit(4:6:LenWords*6)=Q_stream(1:3:LenWords*3);
            SeqBit(5:6:LenWords*6)=Q_stream(2:3:LenWords*3);
            SeqBit(6:6:LenWords*6)=Q_stream(3:3:LenWords*3);
            L=length(SeqBit);
            SB=reshape(SeqBit,L/6,6);
            GB=gray2bin(SB);
            SeqBit=reshape(GB,[L,1]);
            
        case '8PSK'
            DecVal=(angle(Words))*4/pi;
            DecVal=DecVal+4*(DecVal<0);
            BitSeq_dec=de2bi(round(DecVal));
            LenWords=length(Words);
            SeqBit=reshape(BitSeq_dec',1,LenWords*3);
            
        case '16PSK'
            psk_num = 16;
            step = (2*pi/psk_num);
            Ref_line = (0:step:2*pi-step) + step/2;

        case '32PSK'
            DecVal=(angle(Words))*16/pi;
            DecVal=DecVal+16*(DecVal<0);
            BitSeq_dec=de2bi(round(DecVal));
            LenWords=length(Words);
            SeqBit=reshape(BitSeq_dec',1,LenWords*5);
    
    end


end