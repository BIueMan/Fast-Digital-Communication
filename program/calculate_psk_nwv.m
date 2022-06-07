function [detected_nwv]=calculate_psk_nwv(AR)
Nwv=[2:100];
np_Nwv=length(Nwv);
    for idx =1:np_Nwv
        nwv=Nwv(idx);
     Err(idx)=sum(abs(AR/nwv-round(AR/nwv)));
    end
    global to_plt
    if to_plt
    figure(65)
    plot(Nwv,Err)
    xlabel("Estimated cycle time")
    ylabel("Error")
    end
    
    %analyze error vector.
    [mn,imn]=min(Err);
    if imn>=(length(Err)-2)
        RErr=fliplr(Err);
        global to_plt
        if to_plt
        figure(66)
        plot(RErr)
        end
        %analyze RError local maximum
        [imn,Err]=analyze_local_maximum(Err);
        if imn>=(length(Err)-2)
            [imn,Err]=analyze_local_maximum(Err);
        end

    end
    
    detected_nwv=Nwv(imn);
    
return