module FullSPI(
    output reg  [7:0] InputData,
    output wire       DataClk,    
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    output reg        WriteCLK,
    output reg        ReadCLK,
    input  wire [7:0] OutputData,
    input  wire       SPI_MISO,
    input  wire       MasterCLK,
    input  wire       SPI_Enable
    );
    reg [7:0] spiCount;
    reg [2:0] count;
    reg [7:0] Data;
    reg       SPI_InputCLK;
    reg [11:0] DataCLKCount;

    
    reg DataCLK;

    initial begin 
        count=7;
        spiCount=0;
        SPI_InputCLK=0; 
 
        DataCLKCount=1750;
        DataCLK=0;
        WriteCLK=0;
        ReadCLK=0;
        
    end

    always@(posedge MasterCLK)begin
        //Relojes de sincronizacion con el procesador
        if(DataCLKCount<2)begin
            DataCLKCount<=DataCLKCount+1;
            WriteCLK<=1;
            ReadCLK<=0;
        end else if(DataCLKCount<1996)begin
            DataCLKCount<=DataCLKCount+1;
            WriteCLK<=0;
            ReadCLK<=0;
        end else if(DataCLKCount<1999)begin
            DataCLKCount<=DataCLKCount+1;
            WriteCLK<=0;
            ReadCLK<=1;
        end else begin
            DataCLKCount=0;
            WriteCLK<=1;
            ReadCLK<=0;
        end
        //Relojes SPI

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
            InputData<=Data;                        
        end else if (count==3) begin     
            DataCLK<=0;
        end       

        count<=count+1;
        
    end

    always@(posedge SPI_InputCLK)begin

        Data[7-count]<=SPI_MISO;   
    end

    assign SPI_MOSI=(SPI_Enable)? OutputData[7-count]: 1;
    assign SPI_CLK=(SPI_Enable)? SPI_InputCLK : 1;
    assign DataClk=~DataCLK;

endmodule