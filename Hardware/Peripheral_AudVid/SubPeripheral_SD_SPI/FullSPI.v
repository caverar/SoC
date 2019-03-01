module FullSPI(
    output reg  [7:0] InputData,
    input  wire [7:0] OutputData,
    output reg        SPI_MOSI,
    output reg        SPI_CLK,
    input  wire       SPI_MISO,
    input  wire       MasterCLK,
    input  wire       SPI_InputCLK_posedge,
    input  wire       SPI_InputCLK_negedge,
    output reg        DataClk,
    input  wire       SPI_Enable
    );

    reg [2:0] count;
    reg [7:0] Data;

    initial begin 
        count=7; 
        DataClk=0;
    end

    always@(posedge SPI_InputCLK_negedge) begin
        
        if (count==7) begin   
            DataClk<=1;
            InputData<=Data;                        
        end else if (count==3) begin     
            DataClk<=0;
        end       

        count<=count+1;
        
    end

    always@(posedge SPI_InputCLK_posedge)begin

        Data[7-count]<=SPI_MISO;   
    end
    always@(posedge MasterCLK)begin

        if(SPI_Enable)begin
            SPI_MOSI<=OutputData[7-count];
            SPI_CLK<=SPI_InputCLK_posedge;
        end else begin
            SPI_MOSI<=1;
            SPI_CLK<=1;
        end
    end
    //assign SPI_MOSI=(SPI_Enable)? OutputData[7-count]: 1;
    //assign SPI_CLK=(SPI_Enable)? SPI_InputCLK_posedge: 1;

endmodule