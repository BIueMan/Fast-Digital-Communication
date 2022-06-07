function [Word]=word_mapper(BitSeq, modulation)
    %mapper
    np_bit=length(BitSeq);
    n_shift=0;
    chr=[];
%     if SNR>20
         chr='o';
%     end
    switch modulation
        case 'PSK'
            Word=complex(2*BitSeq-1);
            
        if ~isempty(chr)
            global to_plt
            if to_plt
            figure(30)
            plot(Word,chr,'linewidth',1.5);
            if false
                hold on;
                circle(0,0,1);
            end
            title("Constellation Diagram")
            grid;
            axis square;
            end
            return
        end
        case 'QPSK'%(real =odds)+j(img=even)
         
            
            Idx_Real=1:2:np_bit;
            Idx_Img=2:2:np_bit;
            
            BinWords=reshape(BitSeq,np_bit/4,4);
            BinWords=bin2gray(BinWords);
            BitSeq=reshape(BinWords,np_bit,1);
            BitSeq = 2*BitSeq-1;
            Word=(BitSeq(Idx_Real)+ 1j*BitSeq(Idx_Img));
            Word=Word/max(abs(Word));
            global to_plt
            if to_plt
            figure(30)
            plot(Word,chr,'linewidth',1.5)
            hold on;
            circle(0,0,1);
            title("QPSK constellation diagram")
            hold off;
            grid;
            axis square;
            end
            return
        case 'QAM16'%(real =1,2)+j(img=3,4)
            Jumps4=1:4:np_bit;
            Idx_Real = sort([Jumps4,(Jumps4+1)]);
            Idx_Img = sort([Jumps4+2,Jumps4+3]);
            
            BinWords=reshape(BitSeq,np_bit/4,4);
            BinWords=bin2gray(BinWords);
            BitSeq=reshape(BinWords,np_bit,1);
            
            I_stream_mat=reshape(BitSeq(Idx_Real),2,np_bit/4);
            Q_stream_mat=reshape(BitSeq(Idx_Img),2,np_bit/4);
            I_dec=bi2de(I_stream_mat')';
            Q_dec=bi2de(Q_stream_mat')';
            Word=I_dec+j*Q_dec;
            E_word=sum(abs(Word).^2);
            E_word_bit=E_word/np_bit;
            n_shift=-3;
            %I=[-1,3,-3,-1,-1,1,3,3,-3,1];
            %Q=[-1,-3,-1,1,-1,-1,1,3,3,-1];
        case 'QAM64'%(real =1,2,3)+j(img=4,5,6)
           
            
            Jumps4=1:6:np_bit;
            Idx_Real = sort([Jumps4,Jumps4+1,Jumps4+2]);
            Idx_Img = sort([Jumps4+3,Jumps4+4,Jumps4+5]);
            
            BinWords=reshape(BitSeq,np_bit/6,6);
            BinWords=bin2gray(BinWords);
            BitSeq=reshape(BinWords,np_bit,1);
            
            I_stream_mat=reshape(BitSeq(Idx_Real),3,np_bit/6);
            Q_stream_mat=reshape(BitSeq(Idx_Img),3,np_bit/6);
            I_dec=bi2de(I_stream_mat')';
            Q_dec=bi2de(Q_stream_mat')';
            Word=I_dec+ j*Q_dec;
            E_word=sum(abs(Word).^2);
            E_word_bit=E_word/np_bit;
            n_shift=-7;
        case '8PSK'
            BitSeq_mat=reshape(BitSeq,3,np_bit/3)';
            BitSeq_dec=bi2de(BitSeq_mat);
            
            
            BinWords=reshape(BitSeq,np_bit/3,3);
            BinWords=bin2gray(BinWords);
            BitSeq=reshape(BinWords,np_bit,1);
            
            Ph=(pi/4)*BitSeq_dec;
            Word=exp(j*Ph)/2;%delete the 2 when grey code
            E_word=sum(abs(Word).^2);
            E_word_bit=E_word/np_bit;
                n_shift=0;
     case '32PSK'
                BitSeq_mat=reshape(BitSeq,5,np_bit/5);
                BitSeq_dec=bi2de(BitSeq_mat');


                BinWords=reshape(BitSeq,np_bit/5,5);
                BinWords=bin2gray(BinWords);
                BitSeq=reshape(BinWords,np_bit,1);

                Ph=(pi/16)*BitSeq_dec;
                Word=exp(j*Ph)/2;%delete the 2 when grey code
                E_word=sum(abs(Word).^2);
                E_word_bit=E_word/np_bit;
                n_shift=0;
        end
    %constelation diagram
    global to_plt
    if to_plt
        figure(30)
    end
        Word=2*Word+n_shift*(1+1j);
        global to_plt
if to_plt
        if ~isempty(chr)
        plot(Word,chr,'linewidth',1.5)
        title('Constelation diagram.')
        grid;
       axis square;
       hold on;
       %circle(0,0,1);
       % Word_normalized=Word/max(abs(Word));
       %plot(Word_normalized,chr,'linewidth',1.5,'color','m')
       %legend('not normalized','normalized')
       hold off;
        end
    end
   
 

    return