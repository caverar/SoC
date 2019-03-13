module SD(
    input  wire       MasterCLK,    
    input  wire       Reset,
    input  wire       SPI_MISO,
    output wire       SPI_MOSI,
    output wire       SPI_CLK,
    output wire       SPI_CS,
    output wire       DataClockRegister, 
    output reg  [7:0] InputDataRegister,
    input  wire [7:0] OuputDataRegister,
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
        .DataClk(DataClockRegister),
        .SPI_Enable(SPI_EnableRegister)
    );

    
    assign SPI_CS=(SPI_EnableRegister)? 0:1;

    always@(posedge MasterCLK) begin
        if(SPI_EnableRegister)begin 
            //lectura
            InputDataRegister<=InputData;
            //Escritura       
            OutputData<=OuputDataRegister;
        end  
       

    end
    
    
    
    

   
    
      


endmodule