module FullSPI(
    output reg  [7:0] InputData,
    output wire       DataClk,    
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    output reg        SPI_CS,
    input  wire [7:0] OutputData,
    input  wire       SPI_MISO,
    input  wire       MasterCLK,
    input  wire       SPI_Enable,
    input  wire       SPI_EnableCS
    );
    reg [7:0]  spiCount;
    reg [2:0]  count;
    reg [7:0]  InData;
    reg [7:0]  outData;
    reg        SPI_InputCLK;    
    reg        DataCLK;

    initial begin 
        count=7;
        spiCount=0;
        SPI_InputCLK=0;       
        DataCLK=0;   
        
    end

    //Reloj SPI 400 kHz
    always@(posedge MasterCLK)begin 

        if(spiCount<124)begin
            spiCount<=spiCount+1;
            SPI_InputCLK<=0;
        end else if(spiCount<249)begin
            spiCount<=spiCount+1;
            SPI_InputCLK<=1;
        end else begin
            spiCount<=0;
            SPI_InputCLK<=0;
        end
    end

    always@(negedge SPI_InputCLK) begin
        
        if (count==7) begin   
            DataCLK<=1;
            InputData<=InData;
            outData<=OutputData;
            SPI_CS<=(SPI_EnableCS && SPI_Enable)? 1'b0:1'b1;                       
        end else if (count==3) begin     
            DataCLK<=0;
        end
        count<=count+1;        
    end

    always@(posedge SPI_InputCLK)begin
        InData[7-count]<=SPI_MISO;  
    end

    
    assign SPI_MOSI=(SPI_Enable)? outData[7-count]: 1;
    assign SPI_CLK=(SPI_Enable)? SPI_InputCLK : 1;
    assign DataClk=DataCLK;
endmodule