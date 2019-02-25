
module AudVid(
    input  wire        Reset,
    input  wire        CLK,   
    input  wire [13:0] TilesControlRegister,
    input  wire [4:0]  Track1ControlRegister,
    input  wire [4:0]  Track2ControlRegister,    
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

    wire [7:0]  SD_InputData;
    wire        SD_EnableDataRead;
    wire        SD_InputDataClock;
    reg  [23:0] SD_InputAddress;
    wire [15:0] TFT_Data;
    wire        TFT_DataClock;
    wire        DAC_DataClock;
    wire [31:0] DAC_Data;
    wire        MasterCLK;      //100MHz
    wire        I2SCLK;         //41000Hz x32
    wire        TFT_WorkCLK;    //6.25Mhz
    wire        SD_WorkCLK;     //12.5MHz

    
    reg  [3:0]  TilesRegister  [3871:0];
    reg  [31:0] Track1Register [255:0];
    reg  [31:0] Track2Register [255:0]; 
    // reg  [3:0]  TilesRead_XAddress1;
    // reg  [3:0]  TilesRead_YAddress1;
    // reg  [4:0]  TilesRead_TileAddress1;
    // reg  [3:0]  TilesRead_XAddress2;
    // reg  [3:0]  TilesRead_YAddress2;
    // reg  [4:0]  TilesRead_TileAddress2;
    reg  [14:0] SDReadCount;
    reg  [4:0]  AddressOperationLUT [12:0];


    reg  [3:0]  TilesWrite_XAddress;
    reg  [3:0]  TilesWrite_YAddress;
    wire [4:0]  TilesWrite_TileAddress;
    reg  [7:0]  TilesWrite_XPosition;
    reg  [7:0]  TilesWrite_YPosition;
    reg  [8:0]  TilesWrite_TilePosition;
    wire [11:0] TilesWrite_Address;
    reg  [3:0]  TFT_DataEncoded;
    reg         TilesWrite_Started;

    reg  [4:0]  TilesPositionsRegister [319:0];
    reg  [23:0] WriteAudio_Track1BeginAddress;
    reg  [23:0] WriteAudio_Track1EndAddress;
    reg         WriteAudio_Track1EnablePlay;
    reg         WriteAudio_Track1EnableLoop;
    reg  [23:0] WriteAudio_Track2BeginAddress;
    reg  [23:0] WriteAudio_Track2EndAddress;
    reg         WriteAudio_Track2EnablePlay;
    reg         WriteAudio_Track2EnableLoop;
    reg [31:0]  WriteAudio_Track1Data;
    reg [31:0]  WriteAudio_Track2Data;
    reg [9:0]   WriteAudio_PlayCount;
    reg         WriteAudio_EnableSDAudioRead;
    reg         WriteAudio_BankSelector;    

    reg  [23:0] TracksAdressRegister [13:0];
    

    initial begin
        WriteAudio_BankSelector       = 0;    
        WriteAudio_EnableSDAudioRead  = 0;  //indica cuando pedir datos de audio, y cuando cambiar el banco de lectura
        WriteAudio_Track1Data         = 0;
        WriteAudio_Track2Data         = 0;
        WriteAudio_PlayCount          = 0;
        WriteAudio_Track1BeginAddress = 0;
        WriteAudio_Track1EndAddress   = 0;
        WriteAudio_Track1EnablePlay   = 0;
        WriteAudio_Track1EnableLoop   = 0;
        WriteAudio_Track2BeginAddress = 0;
        WriteAudio_Track2EndAddress   = 0;
        WriteAudio_Track1EnablePlay   = 0;
        WriteAudio_Track1EnableLoop   = 0;
        TracksAdressRegister[0]       = 24'h000028;  //Track1BeginAddress
        TracksAdressRegister[1]       = 24'h000B56;  //Track1EndAddress
        TracksAdressRegister[2]       = 24'h000B58;  //Track2BeginAddress
        TracksAdressRegister[3]       = 24'h001B80;  //Track2EndAddress
        TracksAdressRegister[4]       = 24'h001B82;  //Track3BeginAddress 
        TracksAdressRegister[5]       = 24'h0024C0;  //Track3EndAddress
        TracksAdressRegister[6]       = 24'h0024C2;  //Track4BeginAddress
        TracksAdressRegister[7]       = 24'h00283C;  //Track4EndAddress
        TracksAdressRegister[8]       = 24'h00283E;  //Track5BeginAddress
        TracksAdressRegister[9]       = 24'h010C1C;  //Track5EndAddress
        TracksAdressRegister[10]      = 24'h000C1E;  //Track6BeginAddress
        TracksAdressRegister[11]      = 24'h02CADE;  //Track6EndAddress
        TracksAdressRegister[12]      = 24'h02CAE0;  //Track7BeginAddress
        TracksAdressRegister[13]      = 24'h040C9C;  //Track7EndAddress


        $readmemh("VideoData.mem",TilesRegister);
        $readmemb("InitialPosition.mem",TilesPositionsRegister); 
        
        TFT_DataEncoded           = 4'hF;       
        SD_InputAddress           = 24'h000014;
        TilesWrite_XAddress       = 0;
        TilesWrite_YAddress       = 0;
        TilesWrite_XPosition      = 0;
        TilesWrite_YPosition      = 0;
        TilesWrite_TilePosition   = 0;
        TilesWrite_Started        = 0;
        
        // TilesRead_XAddress1       = 0;
        // TilesRead_YAddress1       = 0;
        // TilesRead_TileAddress1    = 0;
        // TilesRead_XAddress2       = 1;
        // TilesRead_YAddress2       = 0;
        // TilesRead_TileAddress2    = 0;
        
        SDReadCount               = 0;
        
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
    AudVid_ClockManager audvid_clockmanager(
        .InputCLK(CLK),
        .MasterCLK(MasterCLK),
        .I2SCLK(I2SCLK),
        .TFTCLK(TFT_WorkCLK),
        .SDCLK(SD_WorkCLK)
    );
    ColorDecoder colorDecoder(
        .Input(TFT_DataEncoded),
        .Output(TFT_Data)
    );
    SD_SPI sd_spi(
        .MasterCLK(MasterCLK),
        .WorkCLK(SD_WorkCLK),
        .Reset(Reset),
        .SPI_MISO(SD_SPI_MISO),
        .SPI_MOSI(SD_SPI_MOSI),
        .SPI_CLK(SD_SPI_CLK),
        .SPI_CS(SD_SPI_CS),
        .SPI_COUNT_DEBUG(SD_SPI_COUNT_DEBUG),
        .SPI_UTILCOUNT_DEBUG(SD_SPI_UTILCOUNT_DEBUG),
        .InputData(SD_InputData),                       
        .EnableDataRead(SD_EnableDataRead),             
        .InputDataClock(SD_InputDataClock),             
        .InputAddress(SD_InputAddress)                  
    );

    TFT_SPI tft_spi(
		.data(TFT_Data), 
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
        .I2S_WS(DAC_I2S_WS),
        .SyncCLK(DAC_DataClock),
        .InputData(DAC_Data)        
    );

    //Lectura de SD
    
    // always@(posedge SD_InputDataClock) begin
    //     if(SD_EnableDataRead) begin
    //         //Lectura 1 Track 1
    //         if (SDReadCount<512) begin

    //         //Lectura 1 Track 2 
    //         end else if(SDReadCount<1024) begin

    //         //Lectura 2 Track 1
    //         end else if(SDReadCount<1536) begin

    //         //Lectura 2 Track 2
    //         end else begin

    //         end

    //         SDReadCount<=SDReadCount+1;
    //     end
    // end

    //  Control de Audio
    //Deteccion de cambio de registro
    always@(posedge MasterCLK) begin
        WriteAudio_Track1BeginAddress <= TracksAdressRegister[2*Track1ControlRegister[2:0]];
        WriteAudio_Track1EndAddress   <= TracksAdressRegister[(2*Track1ControlRegister[2:0])-1];
        WriteAudio_Track1EnablePlay   <= Track1ControlRegister[4];
        WriteAudio_Track1EnableLoop   <= Track1ControlRegister[3];
        
        
        WriteAudio_Track2BeginAddress <= TracksAdressRegister[2*Track2ControlRegister[2:0]];
        WriteAudio_Track2EndAddress   <= TracksAdressRegister[(2*Track2ControlRegister[2:0])-1];
        WriteAudio_Track2EnablePlay   <= Track2ControlRegister[4];
        WriteAudio_Track2EnableLoop   <= Track2ControlRegister[3];
    end

    //Reproduccion de Audio
     
    always@(posedge DAC_DataClock) begin
        if(WriteAudio_PlayCount==255) begin
            WriteAudio_BankSelector<=~WriteAudio_BankSelector;
            WriteAudio_EnableSDAudioRead<=1;
        
        end else if(WriteAudio_PlayCount==127)begin
        
            WriteAudio_EnableSDAudioRead<=1;
            WriteAudio_BankSelector<=~WriteAudio_BankSelector;

        
        end else begin
            WriteAudio_EnableSDAudioRead<=0;       
            WriteAudio_PlayCount<=WriteAudio_PlayCount+2;
        end 

        if(WriteAudio_Track1EnablePlay)begin
            WriteAudio_Track1Data<=Track1Register[WriteAudio_PlayCount];
        end
        if(WriteAudio_Track2EnablePlay)begin
            WriteAudio_Track2Data<=Track2Register[WriteAudio_PlayCount];
        end        


    end

    StereoSignedAdder adder(
        .A(WriteAudio_Track1Data),
        .B(WriteAudio_Track2Data),
        .O(DAC_Data)
    );

    //Escritura en pantalla

    always@(posedge TFT_DataClock) begin
        TFT_DataEncoded<=TilesRegister[TilesWrite_Address];
        if(TilesWrite_Started) begin            

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

            if(TilesWrite_XAddress==10)begin
                if(TilesWrite_YAddress==10)begin          

                    if(TilesWrite_TilePosition<319) begin
                        TilesWrite_TilePosition<=TilesWrite_TilePosition+1;   
                    end else begin                        
                        TilesWrite_TilePosition<=0;  
                    end
                end else begin
                    if(TilesWrite_XPosition<219) begin
                        TilesWrite_TilePosition<=TilesWrite_TilePosition+1;                         
                    end else begin
                        TilesWrite_TilePosition<=TilesWrite_TilePosition-19;                              
                    end                    
                end
            end

        end else begin
            TilesWrite_Started<=1;
        end
    end

    assign TilesWrite_TileAddress=TilesPositionsRegister[TilesWrite_TilePosition];
    assign TilesWrite_Address=(121*TilesWrite_TileAddress)+(11*TilesWrite_YAddress)+TilesWrite_XAddress;

    //Escritura del procesador de las posiciones de los Tiles
    
    always@(posedge MasterCLK) begin
        //if(enable_DEBUG)begin
        TilesPositionsRegister[TilesControlRegister[13:5]]<=TilesControlRegister[4:0];      
        //end
    end

endmodule  