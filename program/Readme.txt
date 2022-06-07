this the code of project:Coding and decoding Technics of binary data
The code was writen by
 Idan Tzachi&Dan Ben-David supervised by Avi Biran.
 
 The main file is new_main.m.
 it runs the bits generator, encoder and the decoder and presents the errors of each iteration.
 It will loop 100 times for each modulation/SNR
 
 files:
 add_distortion.m-adding AWGN noise and phase noise to the Signal
 analyze_local_maximum.m-find minim of graph.
 bin2gray.m-binary data to gray code.
 calculate_psk_nwv.m- a method to detect nwv from signal
 circle.m-plots a circle on plot.
 conv_encoder_7.m-encode using convolution encoder
 correlation_peaks.m-returns the potion of correlations that passes cirten Threshhold
 decode_bits.m-decodes the binary data.
 discremenator.m-returns the optimal detraction accordion to the modulation.
 detect_signal.m-main function of detection the signal from the samples
 detected_words.m-gets the words from the sampled packet.
 encode_data.m-encoder function
 error_hamming.m-returns the hamming error between 2 vectors.
 eval_zc-returns the ZC points on ref_line.
 eye_pattern.m-plots eye pattern diagram
 find_nwv-algorythem to find nwv
 generate_refcode_signal.m-generates the reference signal.
 generate_referance_code.m-generates reference code.
 generate_signal.m-genaretes the siganl according th Tx parametes
 gray2bin.m-transkate graycode to binary.
 max_correlation.m-finds the position of the maximum correlation.
 modulation_bits_factor-the number if bits per modulation
 new_main-main file.
 plot_err-plots error the results of new main.
 RaisedCosine.m-raised cosine window siganl generator
 ref_lines.m-the reference line of ZC for each modultaion
 sample_points.m-the points that represent the detected signal in the samples
 scrambler.m-scrabling the bits.
 word_demapper.m-demodulate the word to bits
 word_mapper.m-build words from the bits.
 zero_crossing.m-get the zero crossing by each modulation.
 zero_crossing_idx.m-indexes of the ZC of the signal
 