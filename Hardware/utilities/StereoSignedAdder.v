module StereoSignedAdder(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [31:0] O
    );
    wire signed [15:0] Chanel1A=A [15:0];
    wire signed [15:0] Chanel1B=B [15:0];
    wire signed [15:0] Chanel2A=A [31:16];
    wire signed [15:0] Chanel2B=B [31:16];
    
    assign O = {Chanel2A+Chanel2B,Chanel1A+Chanel1B};
endmodule