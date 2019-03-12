module SD_SPI(
    input  wire       MasterCLK,    
    input  wire       Reset,
    input  wire       SPI_MISO,
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    output wire       SPI_CS,
    output wire       EnableDataReadRegister,
    output wire [7:0] InputDataRegister,
    input  wire       EnableDataWriteRegister,
    input  wire [7:0] OuputDataRegister,
    output reg        BussyDataWriteRegister
);

    reg DataCLK;
    reg ReadCLK;
    wire SPI_InputCLK;

    reg [11:0] DataCLKCount;

    initial begin
        DataCLKCount=0;
        DataCLK=0;
        BussyDataWriteRegister=0;
    end
    always@(posedge MasterCLK)begin
        if(DataCLKCount<2)begin
            DataCLKCount<=DataCLKCount+1;
            DataCLK<=1;
            BussyDataWriteRegister<=0;
        end else if(DataCLKCount<1996)begin
            DataCLKCount<=DataCLKCount+1;
            DataCLK<=0;
            BussyDataWriteRegister<=0;
        end else if(DataCLKCount<1999)begin
            DataCLKCount<=DataCLKCount+1;
            DataCLK<=0;
            BussyDataWriteRegister<=1;
        end else begin
            DataCLKCount=0;
            DataCLK<=1;
            BussyDataWriteRegister<=0;
        end

    end

    FullSPI Spi(
        .InputData(Init_InputData),
        .OutputData(Init_OutputData),
        .SPI_MOSI(Init_SPI_MOSI),
        .SPI_MISO(SPI_MISO),
        .SPI_CLK(Init_SPI_CLK),
        .SPI_InputCLK(SPI_InputCLK),
        .DataClk(DataClock),
        .SPI_Enable(Init_SPI_Enable)
    );

    FrequencyGenerator #(.MasterFrequency(100000000),.frequency(400000),  .bitsNumber(8)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_InputCLK)        
	);

endmodule
