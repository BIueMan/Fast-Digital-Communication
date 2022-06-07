function err=error_hamming(Words,DetectedW)
    %err=sum(real(Words')~=real(DetectedW'))+sum(imag(Words')~=imag(DetectedW'));
    if(~isrow(DetectedW))
        DetectedW=DetectedW.';
    end 
    if(~isrow(Words))
        Words=Words.';
    end
    RWords = real(Words);
    RDect = real(DetectedW);
    lenRW = length(RWords);
    lenRD = length(RDect);
    
    IWords = imag(Words);
    IDect = imag(DetectedW);
    lenIW = length(IWords);
    lenID = length(IDect);
    
    min_len = min([lenIW, lenID, lenRW, lenRD]);
    if sum([lenIW, lenID, lenRW, lenRD]) - 4*min_len >0
        disp('Warning: mismatch between number of words detected')
    end
    
    NN = 1:min_len;
    global to_plt
    if to_plt
        figure(40)
        plot(cumsum(abs(sign(round(real(Words(NN))-real(DetectedW(NN)), 10)))));
        figure(20)
        plot(cumsum(abs(sign(round(imag(Words(NN))-imag(DetectedW(NN)), 10)))));
    end
    errI=sum(abs(sign(round(real(Words(NN))-real(DetectedW(NN)),10))));
    errQ=sum(abs(sign(round(imag(Words(NN))-imag(DetectedW(NN)),10))));
    err=errI+errQ;
end