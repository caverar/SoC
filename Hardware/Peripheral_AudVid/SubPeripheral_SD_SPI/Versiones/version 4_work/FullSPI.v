module FullSPI(
    output reg  [7:0] InputData,
    input  wire [7:0] OutputData,
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    input  wire       SPI_MISO,
    input  wire       SPI_InputCLK,
    output reg        DataClk,
    input  wire       SPI_Enable
    );

    reg [2:0] count;
    reg [7:0] Data;

    initial begin 
        count=7; 
        DataClk=0;
    end

    always@(negedge SPI_InputCLK) begin
        
        if (count==7) begin   
            DataClk<=1;
            InputData<=Data;                        
        end else if (count==3) begin     
            DataClk<=0;
        end       

        count<=count+1;
        
    end

    always@(posedge SPI_InputCLK)begin

        Data[7-count]<=SPI_MISO;   
    end

    assign SPI_MOSI=OutputData[7-count];
    assign SPI_CLK=(SPI_Enable)? SPI_InputCLK: 1;

endmodule