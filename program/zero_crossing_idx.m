function [zero_cr]=zero_crossing_idx(Sig,ref_line)
    %none_neg_idx = find(sig>=0);
    %neg_idx = find(sig<0);
    %level the signal to the refernce line
    Sig=Sig-ref_line;
    
    DD=diff(sign(Sig));
    cr_pos_idx=find(DD==2);
    cr_neg_idx=find(DD==-2);
    cr_idx=sort([cr_pos_idx;cr_neg_idx]);
    
    
    y_i = Sig(cr_idx);
    y_i_1 = Sig(cr_idx+1);
    a = y_i./(y_i-y_i_1);
    
    
    zero_cr = cr_idx+a;
    return
    
return