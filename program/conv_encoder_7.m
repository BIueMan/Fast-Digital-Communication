function [Out,Pol,CL] = conv_encoder_7(S)
    seed=[0,1,1,0,1,0];
    Pol=[133,171];%the carcteristic polynom
    CL=7;%number of delays elements+1;
    
    
    S_s = [seed, S];
    A = conv(S_s, flip(oct2poly(Pol(1))), "same");
    B = conv(S_s, flip(oct2poly(Pol(2))), "same");
    
    A = A(1:length(S));
    B = B(1:length(S));
    
    vec = [A;B];
    Out = vec(:)';
end


% function [Out,Pol,CL] = conv_encoder_7(S)
%     seed=[0,1,1,0,1,0];
%     Pol=[133,171];%the carcteristic polynom
%     CL=7;%number of delays elements+1;
%     D = seed;
%     Out = [];
%     for i = 1:length(S)
%         % A
%         tmp = xor(xor(D(2), D(3)) , xor(D(5), D(6)));
%         Out(end+1) = xor(S(i), tmp);
%         
%         % B
%         tmp = xor(xor(D(1), D(2)) , xor(D(3), D(6)));
%         Out(end+1) = xor(S(i), tmp);
%         
%         % update delays
%         D = circshift(D,1);
%         D(1) = S(i);
%     end
%     
% end