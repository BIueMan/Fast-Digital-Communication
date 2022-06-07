function [Dw]=detected_words(Packet,Zc,Tx_data, RefCode,nwv_det)
modulation=Tx_data.modulation;
%RefCode=Tx_data.RefCode;
np_words=Tx_data.np_words;
scl_fct=Tx_data.scl_fct;
packetLen=length(Packet);
switch modulation
        case 'PSK'
            [a ,D_zcr,Zero_cr_detected] = eval_zc(Zc.Re, Packet, RefCode, nwv_det);
            Smp_points=sample_points(round(Zero_cr_detected),nwv_det,np_words*nwv_det);
            if max(Smp_points) > length(Packet)
                warning('warning, sample point exside packet length.')
                Smp_points = Smp_points( (Smp_points <= length(Packet))  );
            end
            Words=Packet(round(Smp_points));
            
        case {'QPSK'}
            nwv_det_re=nwv_det;
            nwv_det_im=nwv_det;
            [a ,D_zcr_re,Zero_cr_detected_re] = eval_zc(Zc.Re, real(Packet), RefCode, nwv_det);
            Smp_points_re=sample_points(round(Zero_cr_detected_re),nwv_det_re,np_words*nwv_det_re);
            Smp_points_re(find(Smp_points_re>packetLen))=[];
            [nwv_det_im ,D_zcr_im,Zero_cr_detected_im] = eval_zc(Zc.Im, imag(Packet), RefCode, nwv_det);
            
            Smp_points_im=sample_points(round(Zero_cr_detected_im),nwv_det_im,np_words*nwv_det_im);
            Smp_points_im(find(Smp_points_im>packetLen))=[];

            np_r = length(Smp_points_re);
            np_i = length(Smp_points_im);
            np = min(np_r, np_i);
            N = 1:np;

            I_det=real(Packet(Smp_points_re));
            Q_det=imag(Packet(Smp_points_im));
            Words=I_det(N)+j*Q_det(N);
            %Smp_points=sort([Smp_points_re;Smp_points_im]);
            %Words=Packet(round(Smp_points));
        
        case {'QAM16', 'QAM64'}
            nwv_det_re=nwv_det;
            nwv_det_im=nwv_det;
            [a ,D_zcr_re,Zero_cr_detected_re] = eval_zc(Zc.Re, real(Packet), RefCode, nwv_det);
            Smp_points_re=sample_points(round(Zero_cr_detected_re),nwv_det_re,np_words*nwv_det_re);
            Smp_points_re(find(Smp_points_re>packetLen))=[];
            [a ,D_zcr_im,Zero_cr_detected_im] = eval_zc(Zc.Im, imag(Packet), RefCode, nwv_det);
            
            
            Smp_points_im=sample_points(round(Zero_cr_detected_im),nwv_det_im,np_words*nwv_det_im);
            Smp_points_im(find(Smp_points_im>packetLen))=[];

            np_r = length(Smp_points_re);
            np_i = length(Smp_points_im);
            np = min(np_r, np_i);
            N = 1:np;

            I_det=real(Packet(Smp_points_re));
            Q_det=imag(Packet(Smp_points_im));
            Words=I_det(N)+j*Q_det(N);
            Words = Words.';
            %Smp_points=sort([Smp_points_re;Smp_points_im]);
            %Words=Packet(round(Smp_points));
            
        case {'8PSK', '16PSK', '32PSK'}
            nwv_det_re=nwv_det;
            nwv_det_im=nwv_det;
            [a ,D_zcr_re,Zero_cr_detected_re] = eval_zc(Zc.Re, real(Packet), RefCode, nwv_det);
            Smp_points_re=sample_points(round(Zero_cr_detected_re),nwv_det_re,np_words*nwv_det_re);
            Smp_points_re(find(Smp_points_re>packetLen))=[];
            [a ,D_zcr_im,Zero_cr_detected_im] = eval_zc(Zc.Im, imag(Packet), RefCode, nwv_det);
            
            
            Smp_points_im=sample_points(round(Zero_cr_detected_im),nwv_det_im,np_words*nwv_det_im);
            Smp_points_im(find(Smp_points_im>packetLen))=[];

            np_r = length(Smp_points_re);
            np_i = length(Smp_points_im);
            np = min(np_r, np_i);
            N = 1:np;

            I_det=real(Packet(Smp_points_re));
            Q_det=imag(Packet(Smp_points_im));
            Words=I_det(N)+j*Q_det(N);
            Words = Words.';



        %Zc.Ang=angle(Zc.Re+j*Zc.Im);
        %[a ,D_zcr,Zero_cr_detected] = eval_zc(Zc.Ang, Packet, RefCode, nwv_det);
        %Smp_points=sample_points(round(Zero_cr_detected),nwv_det,np_words*nwv_det);
        %if max(Smp_points) > length(Packet)
        %    print('warning, sample point exside packet length.')
        %    Smp_points = Smp_points( (Smp_points <= length(Packet))  );
        %end
        %Words=Packet(round(Smp_points));
            
            
end
Dw=discriminator(Words.',modulation,scl_fct);


switch modulation
    case {'8PSK', '16PSK', '32PSK'}
        Dw = -Dw;
end


end