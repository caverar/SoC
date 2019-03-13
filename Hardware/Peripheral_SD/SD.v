module SD(
    input  wire       MasterCLK,    
    input  wire       Reset,
    input  wire       SPI_MISO,
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    output wire       SPI_CS,
    output wire       EnableDataReadRegister,
    output reg  [7:0] InputDataRegister,
    input  wire       EnableDataWriteRegister,
    input  wire [7:0] OuputDataRegister,
    output wire       BussyDataWriteRegister,
    input  wire       SPI_EnableRegister 
    );

    reg [7:0] OutputData;
    wire WriteCLK;
    wire ReadCLK;
    wire [7:0] InputData;
	

    // modulo SPI
    FullSPI spi(
        .InputData(InputData),
        .OutputData(OutputData),
        .SPI_MOSI(SPI_MOSI),
        .SPI_MISO(SPI_MISO),
        .SPI_CLK(SPI_CLK),
        .MasterCLK(MasterCLK),        
        .DataClk(DataClock),
        .SPI_Enable(SPI_EnableRegister),
        .WriteCLK(WriteCLK),
        .ReadCLK(ReadCLK)
    );

    assign EnableDataReadRegister = ReadCLK;
    assign BussyDataWriteRegister = WriteCLK;
    
    assign SPI_CS=(SPI_EnableRegister)? 0:1;
    always@(posedge MasterCLK) begin
        //lectura
        InputDataRegister<=InputData;

        //Escritura
        if(EnableDataWriteRegister)begin
            OutputData<=OuputDataRegister;  
        end

    end
    
    
    
    

   
    
      


endmodule