function [fct_bit]=modulation_bits_factor(modulation)

    switch modulation
        case 'PSK'
            fct_bit=1;
        case 'QPSK'
            fct_bit=2;
        case 'QAM16'
            fct_bit=4;
        case 'QAM64'
            fct_bit=6;
        case '8PSK'
            fct_bit=3;
        case '32PSK'
            fct_bit=5;

    end


return