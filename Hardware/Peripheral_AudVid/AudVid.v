
module AudVid(
    input  wire        Reset,
    input  wire        MasterCLK,
    input  wire        I2SCLK,    
    input  wire [4:0]  TilesPositionData,
    input  wire [8:0]  TilesPositionAddress,
    input  wire        TFT_WorkCLK,
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
    output wire        DAC_I2S_DATA,
    output wire        DAC_I2S_CLK,
    output wire        DAC_I2S_WS

    );

    wire [7:0]   SD_InputData;
    wire         SD_EnableDataRead;
    wire         SD_InputDataClock;
    reg  [23:0]  SD_InputAddress;
    wire [15:0]  TFT_Data;
    wire         TFT_DataClock;

    reg  [8191:0] TilesRegister [3:0];
    reg  [3:0]    TilesRead_XAddress1;
    reg  [3:0]    TilesRead_YAddress1;
    reg  [4:0]    TilesRead_TileAddress1;
    reg  [3:0]    TilesRead_XAddress2;
    reg  [3:0]    TilesRead_YAddress2;
    reg  [4:0]    TilesRead_TileAddress2;
    reg  [14:0]   SDReadCount;
    reg  [4:0]    AddressOperationLUT [4:0];


    reg  [3:0]    TilesWrite_XAddress;
    reg  [3:0]    TilesWrite_YAddress;
    wire [4:0]    TilesWrite_TileAddress;
    reg  [3:0]    TilesWrite_XPosition;
    reg  [3:0]    TilesWrite_YPosition;
    reg  [8:0]    TilesWrite_TilePosition;
    reg  [3:0]    TFT_DataEncoded;

    reg  [319:0]  TilesPositionsRegister [4:0];
    
    
    localparam Tile1Address=24'h000014;
    localparam Tile2Address=24'h000016;
    localparam Track1BeginAddress=24'h000018;
    localparam Track2BeginAddress=24'h000100;
    initial begin
        TilesPositionsRegister[0] = 0;
        TilesPositionsRegister[1] = 1;
        SD_InputAddress           = 24'h000140;
        TilesWrite_XAddress       = 0;
        TilesWrite_YAddress       = 0;
        //TilesWrite_TileAddress    = 0;
        TilesWrite_XPosition      = 0;
        TilesWrite_YPosition      = 0;
        TilesWrite_TilePosition   = 0;
        TilesRead_XAddress1       = 0;
        TilesRead_YAddress1       = 0;
        TilesRead_TileAddress1    = 0;
        TilesRead_XAddress2       = 1;
        TilesRead_YAddress2       = 0;
        TilesRead_TileAddress2    = 0;
        SDReadCount               = 0;
        //TFT_Data                  = 16'hFFFF;
        AddressOperationLUT[0]    = 1;
        AddressOperationLUT[1]    = 2; 
        AddressOperationLUT[2]    = 3; 
        AddressOperationLUT[3]    = 4; 
        AddressOperationLUT[4]    = 5; 
        AddressOperationLUT[5]    = 6; 
        AddressOperationLUT[6]    = 7; 
        AddressOperationLUT[7]    = 8; 
        AddressOperationLUT[8]    = 9; 
        AddressOperationLUT[9]    = 10; 
        AddressOperationLUT[10]   = 0; 
        AddressOperationLUT[11]   = 0; 
        AddressOperationLUT[12]   = 0;  
    end
    //Instancias
    ColorDecoder colorDecoder(
        .Input(TFT_DataEncoded),
        .Output(TFT_Data)
    );
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
		.data(16'hFEA0), //TFT_Data
        .DataClock(TFT_DataClock), 
		.MasterCLK(MasterCLK),
        .WorkCLK(TFT_WorkCLK),
		.SPI_MOSI(TFT_SPI_MOSI),
		.SPI_CLK(TFT_SPI_CLK),
		.RS(TFT_RS),
		.SPI_CS(TFT_SPI_CS),
		.RST(TFT_RST) 			
	);

    I2S i2s(
        .MasterCLK(MasterCLK),
        .I2SCLK(I2SCLK),   
        .I2S_DATA(DAC_I2S_DATA),
        .I2S_CLK(DAC_I2S_CLK),
        .I2S_WS(DAC_I2S_WS) 

        //input  wire [31:0]  InputData,
        //output wire         SyncCLK,
    );

    //Lectura de SD
    
    always@(posedge SD_InputDataClock) begin
        if(SD_EnableDataRead) begin
        //Lectura de Tiles
            //Lectuta inicial
            if(SDReadCount<512) begin                
                SD_InputAddress<=Tile1Address;               
                SDReadCount<=SDReadCount+1;
            //Tile1
            end else if(SDReadCount<1024 ) begin
                SD_InputAddress<=Tile2Address; 

                TilesRegister[{TilesRead_TileAddress1,TilesRead_YAddress1,TilesRead_XAddress1}]<=SD_InputData[7:4];
                TilesRegister[{TilesRead_TileAddress2,TilesRead_YAddress2,TilesRead_XAddress2}+1]<=SD_InputData[3:0];
                
                //X1
                TilesRead_XAddress1<=AddressOperationLUT[TilesRead_XAddress1+1];
                //X2
                TilesRead_XAddress2<=AddressOperationLUT[TilesRead_XAddress2+1];
                //Y1
                if(TilesRead_XAddress1==9 || TilesRead_XAddress1==10)begin
                    TilesRead_YAddress1<=AddressOperationLUT[TilesRead_YAddress1]; 
                end
                //Y2
                if(TilesRead_XAddress2==9 || TilesRead_XAddress2==10)begin
                    TilesRead_YAddress2<=AddressOperationLUT[TilesRead_YAddress2]; 
                end 

                //Tile1
                if(TilesRead_YAddress1==10  && (TilesRead_XAddress1==9 || TilesRead_XAddress1==10)) begin
                    TilesRead_TileAddress1<=TilesRead_TileAddress1+1;; 
                end
                //Tile1
                if(TilesRead_YAddress2==10  && (TilesRead_XAddress2==9 || TilesRead_XAddress2==10)) begin
                    TilesRead_TileAddress2<=TilesRead_TileAddress2+1;; 
                end 
               
                SDReadCount<=SDReadCount+1;   
            //Tile2
            end else if(SDReadCount<1536 && !(TilesRead_TileAddress2==31 && TilesRead_YAddress2==10 && TilesRead_XAddress2==10)) begin
                SD_InputAddress<=Track1BeginAddress; 

                TilesRegister[{TilesRead_TileAddress1,TilesRead_YAddress1,TilesRead_XAddress1}]<=SD_InputData[7:4];
                TilesRegister[{TilesRead_TileAddress2,TilesRead_YAddress2,TilesRead_XAddress2}+1]<=SD_InputData[3:0];
                
                //X1
                TilesRead_XAddress1<=AddressOperationLUT[TilesRead_XAddress1+1];
                //X2
                TilesRead_XAddress2<=AddressOperationLUT[TilesRead_XAddress2+1];
                //Y1
                if(TilesRead_XAddress1==9 || TilesRead_XAddress1==10)begin
                    TilesRead_YAddress1<=AddressOperationLUT[TilesRead_YAddress1]; 
                end
                //Y2
                if(TilesRead_XAddress2==9 || TilesRead_XAddress2==10)begin
                    TilesRead_YAddress2<=AddressOperationLUT[TilesRead_YAddress2]; 
                end 

                //Tile1
                if(TilesRead_YAddress1==10  && (TilesRead_XAddress1==9 || TilesRead_XAddress1==10)) begin
                    TilesRead_TileAddress1<=TilesRead_TileAddress1+1;; 
                end
                //Tile1
                if(TilesRead_YAddress2==10  && (TilesRead_XAddress2==9 || TilesRead_XAddress2==10)) begin
                    TilesRead_TileAddress2<=TilesRead_TileAddress2+1;; 
                end 
               
                SDReadCount<=SDReadCount+1;    
  
        //Lectura de Audio    
            end else begin
                
            end
        end 
    end

    //Escritura en pantalla

    always@(posedge TFT_DataClock) begin
        //TFT_DataEncoded
        //TilesWrite_XAddress       
        //TilesWrite_YAddress       
        //TilesWrite_TileAddress

        TFT_DataEncoded<=TilesRegister[{TilesWrite_TileAddress,TilesWrite_YAddress,TilesWrite_XAddress}];
        TilesWrite_XAddress<=AddressOperationLUT[TilesWrite_XAddress];

        if(TilesWrite_XPosition<219)begin
            TilesWrite_XPosition<=TilesWrite_XPosition+1;
        end else begin
            TilesWrite_XPosition<=0;
            TilesWrite_YAddress<=AddressOperationLUT[TilesWrite_YAddress];

            if(TilesWrite_YPosition<175)begin
                TilesWrite_YPosition<=TilesWrite_YPosition+1;
            end else begin
                TilesWrite_YPosition<=0;
            end
        end

        if(TilesWrite_XAddress==10 || TilesWrite_YAddress==10)begin
            if(TilesWrite_XAddress==10 || !TilesWrite_YAddress==10)begin
                if(TilesWrite_XPosition==119)begin
                    TilesWrite_TilePosition<=TilesWrite_TilePosition-19;   
                end else begin
                    TilesWrite_TilePosition<=TilesWrite_TilePosition+1;    
                end
            end else begin
                if(TilesWrite_TilePosition==319)begin
                    TilesWrite_TilePosition<=0;
                end else begin
                    TilesWrite_TilePosition<=TilesWrite_TilePosition+1;  
                end    
            end
        end

    end
    assign TilesWrite_TileAddress=TilesPositionsRegister[TilesWrite_TilePosition];

endmodule


   