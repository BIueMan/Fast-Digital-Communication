function [Tx_data]=ref_lines(Tx_data)
    Ref_line=[0];
    scl_fct = 1;
    switch Tx_data.modulation
        case 'QPSK'
            scl_fct=1/sqrt(2);
        
        case 'QAM16'
            Ref_line=[-2,0,2];
            scl_fct=1/sqrt(10);
            
        case 'QAM64'%(real =1,2,3)+j(img=4,5,6)
            Ref_line=[6:-2:-6];
            scl_fct=1/sqrt(42);
            
        case '8PSK'
              sq2=sqrt(2)/2;
              Ref_line=[(1+sq2)/2,sq2/2,-sq2/2,-(1+sq2)/2];
%             psk_num = 8;
%             step = (2*pi/psk_num);
%             Ref_line = (0:step:2*pi-step) + step/2;
            
        case '16PSK'
            psk_num = 16;
            step = (2*pi/psk_num);
            Ref_line = (0:step:2*pi-step) + step/2;

        case '32PSK'
            psk_num = 32;
            step = (2*pi/psk_num);
            Ref_line = (0:step:2*pi-step) + step/2;
    
    end
   Tx_data.Ref_line=Ref_line;
   Tx_data.scl_fct=scl_fct;
   
 

    return