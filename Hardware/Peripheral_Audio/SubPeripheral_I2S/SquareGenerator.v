module SquareGenerator(
    input             CLK,
    output reg [31:0] data
    );
    reg [31:0] count;
    initial begin count=0; end

    always@(posedge CLK)begin
        if(count<100000)begin
            data=32'h1FFF8FFF;
            count=count+1;
        end else if(count<200000)begin
            data=32'h8FFF1FFF;
            count=count+1;
        end else begin
            count=0;
        end      
    end

endmodule