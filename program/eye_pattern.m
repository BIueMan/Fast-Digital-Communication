function eye_pattern(Signal,nwv,modulation)
    np_signal = length(Signal);
    R_signal=real(Signal);
    I_signal=imag(Signal);
    n_bit_eye =5;
    np_bit=nwv;
    n_seg = min(np_signal/n_bit_eye,50);
    np_eye = np_bit*n_seg*n_bit_eye;
    offset = 5*nwv;
    Nn = offset:(np_eye+offset-1);

    Eye_mat = reshape(R_signal(Nn),np_bit*n_bit_eye,n_seg);
    global to_plt
    if to_plt
        figure(11);
    
        plot(Eye_mat,'b');
        title(['Eye pattern modulation = ',modulation])
        xlabel('sample point')
        %xline(12);
        %xline(22);
        %xline(32);
        grid;
    end




return