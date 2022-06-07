function [min_idx,New_Err] =analyze_local_maximum(Err)
        RErr=fliplr(Err);
        dr1=diff(sign(diff(RErr)));
        FF=find(dr1==-2);
        if isempty(FF)
            error('no local maximom was found')
        end
        idx_local_max=FF(1);
        RErr=RErr(idx_local_max+1:end);
        New_Err=fliplr(RErr);
        [mn,min_idx]=min(New_Err);




return