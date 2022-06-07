function [Words]=descremenator(Vals,modulation)


switch modulation
        case 'PSK'
            Words=real(Vals);
            Words=(Words>0)*2-1;
            return
        case 'QPSK'
            Re=real(Vals);
            Im=imag(Vals);
            Words =((Re>0)*2-1)+j*((Im>0)*2-1);
            Words=Words./abs(Words);
         return
        case '8PSK'
            psk_num = 8;
            Ang=angle(Vals);
            Words=round((Ang/(pi/psk_num)-1))*2*pi/psk_num;
            Words=cos(Words)+j*sin(Words);
            return
        case '16PSK'
            psk_num = 16;
            Ang=angle(Vals);
            Words=round((Ang/(pi/psk_num)-1))*2*pi/psk_num;
            Words=cos(Words)+j*sin(Words);
            return
        case '32PSK'
            psk_num = 32;
            Ang=angle(Vals);
            Words=round((Ang/(pi/psk_num)-1))*2*pi/psk_num;
            Words=cos(Words)+j*sin(Words);
            return
          
        case 'QAM16'
            Re=real(Vals);
            desc_lines=[-Inf, -2; -2, 0; 0, 2; 2, Inf];
            word_lines = [-3,-1,1,3];
            
            Words_re = zeros(1, size(Vals));
            for ii = 1:size(desc_lines)[1]
                Words_re = Words_re + word_lines(ii) * (desc_lines(ii,1) < Re && desc_lines(ii,2) >= Re);
            end
            
            Im=real(Vals);
            Words_im = zeros(1, size(Vals));
            for ii = 1:size(desc_lines)[1]
                Words_im = Words_im + word_lines(ii) * (desc_lines(ii,1) < Im && desc_lines(ii,2) >= Im);
            end
            
            return
        case 'QAM64'%(real =1,2,3)+j(img=4,5,6)
            Re=real(Vals);
            desc_lines=[-Inf, -6; -6, -4; -4, -2; -2, 0; 0, 2; 2, 4; 4, 6; 6 Inf];
            word_lines = [-7,-5,-3,-1,1,3,5,7];
            
            Words_re = zeros(1, size(Vals));
            for ii = 1:size(desc_lines)[1]
                Words_re = Words_re + word_lines(ii) * (desc_lines(ii,1) < Re && desc_lines(ii,2) >= Re);
            end
            
            Im=real(Vals);
            Words_im = zeros(1, size(Vals));
            for ii = 1:size(desc_lines)[1]
                Words_im = Words_im + word_lines(ii) * (desc_lines(ii,1) < Im && desc_lines(ii,2) >= Im);
            end
           return
     case '32PSK'
            return
        end
    
   
 


end