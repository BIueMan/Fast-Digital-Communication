function [Points]=sample_points(ZeroCr,nwv,np_bit)
    Points = [];
    pre_cr = 1;
    for cr=ZeroCr'
        Points=[Points;[pre_cr+floor(nwv/2):nwv:cr]'];
       pre_cr=cr; 
    end
    Points=[Points;[pre_cr+floor(nwv/2):nwv:np_bit]'];
    

end