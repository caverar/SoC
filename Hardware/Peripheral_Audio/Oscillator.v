module Oscillator#(parameter limit=128, parameter bits=18)(
    input CLK,
    output reg [15:0] data 
);
    reg [bits-1:0]count;
    initial begin 
        count=0;
        data=0; 
    end  
    
    always@(posedge CLK) begin
        if(count<limit/2)begin
            count<=count+1;
            data<=16'h1FFF;
        end else if(count<limit)begin
            count<=count+1;
            data<=16'h9FFF;
        end else begin
            count<=0;
        end
    end

endmodule