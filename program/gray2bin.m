function b = gray2bin(g)
    [L,W]=size(g);
    b=zeros(L,W);
    b(:,1) = g(:,1);
    [L,W]=size(g);
    for i = 2 : W
        x = xor((b(:,i-1)), (g(:,i)));
        b(:,i) = x;
    end
end