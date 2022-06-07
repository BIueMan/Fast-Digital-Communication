function [nwv_det ,D_zcr,Zero_cr_detect] = eval_zc(zero_cr, Signal, Ref_code, nwv_det)


    D_zcr = diff(zero_cr);
    zero_cr_1 = [zero_cr(1); cumsum(D_zcr)+zero_cr(1)];

    %nwv_det = calculate_psk_nwv(D_zcr);
    %nwv_det2 = find_nwv(Signal,Ref_code);
    %nwv_det = nwv_det2;
    
    avr = nwv_det;

    %fct = 0.2;
    %ff = find(D_zcr < fct*avr);
    %D_zcr(ff) = [];
    
    fct = 0.2;
    tmp_sum = 0;
    D_zcr_tmp = [];
    for zc = D_zcr.'
        %zc = D_zcr(indx);
        if zc < nwv_det*fct
            tmp_sum = tmp_sum + zc;
        else
            D_zcr_tmp(end+1) = zc + tmp_sum;
            tmp_sum = 0;
        end
    end
    
    D_zcr = D_zcr_tmp.';
    
    %nwv_det=calculate_psk_nwv(D_zcr);
    %nwv_det = nwv_det2;
    Zero_cr_detect=[zero_cr(1);zero_cr(1)+cumsum(D_zcr)];
    global to_plt
    if to_plt
        figure(10)
        hist(D_zcr,1000)
    end
    
%     % find N
%     top_pick = mean(d_zcr);
%     d_zcr = d_zcr(d_zcr > 0.7*top_pick);
%     d_zcr = d_zcr(d_zcr <= 1.3*top_pick);
%     hist(d_zcr,100)
%     
%     N = round(mean(d_zcr));

return