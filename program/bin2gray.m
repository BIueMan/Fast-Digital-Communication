function g = bin2gray(b)
    [L,W]=size(b);
    g=zeros(L,W);
    g(:,1) = b(:,1);
    for i = 2 : W;
        x = xor(b(:,i-1), b(:,i));
        g(:,i) = x;
    end

end