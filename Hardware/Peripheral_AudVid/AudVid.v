
module AudVid(
    input  wire        Reset,
    input  wire        MasterCLK,
    input  wire        I2SCLK,
    input  wire [3:0]  Address,
    input  wire [31:0] Data,
    input  wire        Enable,
    output wire        TFT_SPI_CLK,
    output wire        TFT_SPI_CS,    
    output wire        TFT_SPI_MOSI,
    output wire        TFT_RST,
    output wire        TFT_RS,
    output wire        SD_SPI_CLK,
    output wire        SD_SPI_CS,    
    output wire        SD_SPI_MOSI,
    input  wire        SD_SPI_MISO,
    output wire        SD_SPI_COUNT_DEBUG,
    output wire        SD_SPI_UTILCOUNT_DEBUG,
    output wire        I2S_DATA,
    output wire        I2S_CLK,
    output wire        I2S_WS

    );

    wire [7:0]   SD_InputData;
    wire         SD_EnableDataRead;
    wire         SD_InputDataClock;
    wire [15:0]  SD_InputAddress;
    wire [15:0]  TFT_Data;
    wire         TFT_DataClock;

    reg [8191:0] TilesRegister [3:0];
    reg [3:0]    TilesRead_XAddress;
    reg [3:0]    TilesRead_YAddress;
    reg [4:0]    TilesRead_TileAddress;

    reg [10:0] SDReadCount;
    //Instancias
    SD_SPI sd_spi(
        .MasterCLK(MasterCLK),
        .Reset(Reset),
        .SPI_MISO(SD_SPI_MISO),
        .SPI_MOSI(SD_SPI_MOSI),
        .SPI_CLK(SD_SPI_CLK),
        .SPI_CS(SD_SPI_CS),
        .SPI_COUNT_DEBUG(SD_SPI_COUNT_DEBUG),
        .SPI_UTILCOUNT_DEBUG(SD_SPI_UTILCOUNT_DEBUG),
        .InputData(SD_InputData),                       // Output  [7:0]
        .EnableDataRead(SD_EnableDataRead),             // Output
        .InputDataClock(SD_InputDataClock),             // Output
        .InputAddress(SD_InputAddress)                  // Input   [15:0]
    );

    TFT_SPI tft_spi(
		.data(TFT_Data),
        .DataClock(TFT_DataClock), 
		.MasterCLK(MasterCLK),
		.Reset(Reset),
		.SPI_MOSI(TFT_SPI_MOSI),
		.SPI_CLK(TFT_SPI_CLK),
		.RS(TFT_RS),
		.SPI_CS(TFT_SPI_CS),
		.RST(TFT_RS) 
			
	);

    //Lectura de SD
    
    always@(posedge SD_InputDataClock) begin
        if(SD_EnableDataRead) begin
        //Lectura de Tiles
            if(SDReadCount<1024 && {TilesRead_TileAddress,TilesRead_YAddress,TilesRead_XAddress}<8192) begin
                
                SD_InputAddress=
                TilesTilesRegister[{TilesRead_TileAddress,TilesRead_YAddress,TilesRead_XAddress}]<=SD_InputData;
                TilesRead_XAddress<=TilesRead_XAddress+1;
                TilesRead_YAddress<=TilesRead_YAddress+1;
                TilesRead_TileAddress<=TilesRead_TileAddress+1;
                SDReadCount<=SDReadCount+1; 
        //Lectura de Audio    
            end else begin
                
            end
        end 
    end

endmodule

    TilesRead_XAddress;
    TilesRead_YAddress;
    TilesRead_TileAddress;
   