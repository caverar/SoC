
module Video(
    input  wire        Reset,
    input  wire        CLK,   
    input  wire [13:0] TilesControlRegister,   
    output wire        TFT_SPI_CLK,
    output wire        TFT_SPI_CS,    
    output wire        TFT_SPI_MOSI,
    output wire        TFT_RST,
    output wire        TFT_RS
    );

    
    wire [15:0] TFT_Data;
    wire        TFT_DataClock;    
    wire        MasterCLK;      //100MHz    
    wire        TFT_WorkCLK;    //6.25Mhz


    
    reg  [3:0]  TilesRegister  [3871:0];
    
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

    
    

    initial begin       


        $readmemh("VideoData.mem",TilesRegister);
        $readmemb("InitialPosition.mem",TilesPositionsRegister); 
        
        TFT_DataEncoded           = 4'hF;       
       
        TilesWrite_XAddress       = 0;
        TilesWrite_YAddress       = 0;
        TilesWrite_XPosition      = 0;
        TilesWrite_YPosition      = 0;
        TilesWrite_TilePosition   = 0;
        TilesWrite_Started        = 0;        
        
        
       
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
    Video_ClockManager video_clockmanager(
        .InputCLK(CLK),
        .MasterCLK(MasterCLK),
        .TFTCLK(TFT_WorkCLK),
        .SDCLK(SD_WorkCLK)
    );
    ColorDecoder colorDecoder(
        .Input(TFT_DataEncoded),
        .Output(TFT_Data)
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