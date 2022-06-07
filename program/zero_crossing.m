function [Zero_cr]=zero_crossing(Sig,Ref_lines,modulation)

Zero_cr = {};

switch modulation
        case 'PSK'
            ZC_t = [];
            for ref_line=Ref_lines
                [ZC] = zero_crossing_idx(real(Sig),ref_line);
                ZC_t = [ZC_t;ZC];
            end
            Zero_cr.Re = sort(ZC_t);
            
            Zero_cr.Im = [];
            return
            
        case {'QPSK', 'QAM16', 'QAM64'}
            % real
            ZC_t = [];
            for ref_line=Ref_lines
                [ZC] = zero_crossing_idx(real(Sig),ref_line);
                ZC_t = [ZC_t;ZC];
            end
            Zero_cr.Re = sort(ZC_t);
            % imag
            ZC_t = [];
            for ref_line=Ref_lines
                [ZC] = zero_crossing_idx(imag(Sig),ref_line);
                ZC_t = [ZC_t;ZC];
            end
            Zero_cr.Im = sort(ZC_t);
            return
        case {'8PSK', '16PSK', '32PSK'}
% real
            ZC_t = [];
            for ref_line=Ref_lines
                [ZC] = zero_crossing_idx(real(Sig),ref_line);
                ZC_t = [ZC_t;ZC];
            end
            Zero_cr.Re = sort(ZC_t);
            % imag
            ZC_t = [];
            for ref_line=Ref_lines
                [ZC] = zero_crossing_idx(imag(Sig),ref_line);
                ZC_t = [ZC_t;ZC];
            end
            Zero_cr.Im = sort(ZC_t);
            return



            % angle
%             ZC_t = [];
%             for ref_line=Ref_lines
%                 [ZC] = anglular_zerocrossing(Sig,ref_line);
%                 ZC_t = [ZC_t;ZC];
%             end
%             Zero_cr.Ang = sort(ZC_t);
%             return
            
        end

end