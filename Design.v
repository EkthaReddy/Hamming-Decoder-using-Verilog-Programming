module Hamming_Decoder(
    input [6:0] code,
    output reg [3:0] data_out,
    output reg [2:0] syndrome,
    output reg error_detected,
    output reg error_corrected
);

    wire p1, p2, p4;

    // Calculate parity bits
    assign p1 = code[0] ^ code[2] ^ code[4] ^ code[6];
    assign p2 = code[1] ^ code[2] ^ code[5] ^ code[6];
    assign p4 = code[3] ^ code[4] ^ code[5] ^ code[6];

    always @(*) begin
        // Form the syndrome
        syndrome = {p4, p2, p1};

        // Error detection
        error_detected = (syndrome != 3'b000);

        if (error_detected) begin
            error_corrected = 1'b1;
            case (syndrome)
                3'b001: data_out = {code[6], code[5], code[4], ~code[0]};
                3'b010: data_out = {code[6], code[5], ~code[1], code[0]};
                3'b011: data_out = {code[6], ~code[2], code[4], code[0]};
                3'b100: data_out = {~code[3], code[5], code[4], code[0]};
                3'b101: data_out = {code[6], code[5], ~code[4], code[0]};
                3'b110: data_out = {code[6], ~code[5], code[4], code[0]};
                3'b111: data_out = {~code[6], code[5], code[4], code[0]};
                default: data_out = {code[6], code[5], code[4], code[0]};
            endcase
        end else begin
            error_corrected = 1'b0;
            data_out = {code[6], code[5], code[4], code[0]};
        end
    end
endmodule
