module Hamming_Decoder_tb;

    // Inputs
    reg [6:0] code;

    // Outputs
    wire [3:0] data_out;
    wire [2:0] syndrome;
    wire error_detected;
    wire error_corrected;

    // Instantiate the Unit Under Test (UUT)
    Hamming_Decoder uut (
        .code(code),
        .data_out(data_out),
        .syndrome(syndrome),
        .error_detected(error_detected),
        .error_corrected(error_corrected)
    );

    // Initial block for simulation
    initial begin
        // Dump the variables to a VCD file for waveform viewing
        $dumpfile("dump.vcd");
        $dumpvars(0);

        // Test case 1: No error
        code = 7'b0110111; // No error
        #10;
        // Check output: data_out should be 0111, syndrome should be 000, error_detected should be 0

        // Test case 2: Error in bit 0
        code = 7'b1110111; // Error at bit 0
        #10;
        // Check output: data_out should be 0111, syndrome should be 001, error_detected should be 1, error_corrected should be 1

        // Test case 3: Error in bit 1
        code = 7'b1010111; // Error at bit 1
        #10;
        // Check output: data_out should be 0011, syndrome should be 010, error_detected should be 1, error_corrected should be 1

        // Test case 4: Error in bit 2
        code = 7'b1111111; // Error at bit 2
        #10;
        // Check output: data_out should be 1001, syndrome should be 011, error_detected should be 1, error_corrected should be 1

        // Test case 5: Error in bit 3
        code = 7'b0111111; // Error at bit 3
        #10;
        // Check output: data_out should be 0111, syndrome should be 100, error_detected should be 1, error_corrected should be 1

        // Test case 6: Error in bit 4
        code = 7'b0101111; // Error at bit 4
        #10;
        // Check output: data_out should be 0101, syndrome should be 101, error_detected should be 1, error_corrected should be 1

        // Test case 7: Error in bit 5
        code = 7'b0111011; // Error at bit 5
        #10;
        // Check output: data_out should be 0110, syndrome should be 110, error_detected should be 1, error_corrected should be 1

        // Test case 8: Error in bit 6
        code = 7'b0011111; // Error at bit 6
        #10;
        // Check output: data_out should be 1111, syndrome should be 111, error_detected should be 1, error_corrected should be 1

        // Finish simulation
        $finish;
    end

endmodule
