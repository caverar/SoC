
module Audio(


    input  wire        Reset,
    input  wire        CLK,      
    input  wire [4:0]  Track1ControlRegister,
    input  wire [4:0]  Track2ControlRegister,    
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
    wire        DAC_DataClock;
    wire [31:0] DAC_Data;
    wire        MasterCLK;      //100MHz
    wire        I2SCLK;         //41000Hz x32    

    
    
    reg  [31:0] Track1Register [255:0];
    reg  [31:0] Track2Register [255:0]; 

    reg  [9:0]  SDReadCount;


 
    reg  [23:0] WriteAudio_Track1BeginAddress;
    reg  [23:0] WriteAudio_Track1EndAddress;
    reg         WriteAudio_Track1EnablePlay;
    reg         WriteAudio_Track1EnableLoop;
    reg  [23:0] WriteAudio_Track2BeginAddress;
    reg  [23:0] WriteAudio_Track2EndAddress;
    reg         WriteAudio_Track2EnablePlay;
    reg         WriteAudio_Track2EnableLoop;
    reg  [31:0] WriteAudio_Track1Data;
    reg  [31:0] WriteAudio_Track2Data;
    reg  [23:0] WriteAudio_Track1AddressCount;
    reg  [23:0] WriteAudio_Track2AddressCount;
    reg  [9:0]  WriteAudio_PlayCount;
    reg         WriteAudio_EnableSDAudioRead;
    reg         WriteAudio_BankSelector;   
    reg         WriteAudio_Track1ControlEnable;
    reg         WriteAudio_Track2ControlEnable;
    reg         ReadAudio_EnableStorage;  

    reg  [23:0] TracksAdressRegister [13:0];
    

    initial begin
        ReadAudio_EnableStorage        = 0;
        WriteAudio_Track1ControlEnable = 0;
        WriteAudio_Track2ControlEnable = 0;
        WriteAudio_Track1AddressCount  = 0;
        WriteAudio_Track1AddressCount  = 0;
        WriteAudio_BankSelector        = 0;    
        WriteAudio_EnableSDAudioRead   = 0;  //indica cuando pedir datos de audio, y cuando cambiar el banco de lectura
        WriteAudio_Track1Data          = 0;
        WriteAudio_Track2Data          = 0;
        WriteAudio_PlayCount           = 0;
        WriteAudio_Track1BeginAddress  = 0;
        WriteAudio_Track1EndAddress    = 0;
        WriteAudio_Track1EnablePlay    = 0;
        WriteAudio_Track1EnableLoop    = 0;
        WriteAudio_Track2BeginAddress  = 0;
        WriteAudio_Track2EndAddress    = 0;
        WriteAudio_Track1EnablePlay    = 0;
        WriteAudio_Track1EnableLoop    = 0;
        TracksAdressRegister[0]        = 24'h000028;  //Track1BeginAddress
        TracksAdressRegister[1]        = 24'h000B56;  //Track1EndAddress
        TracksAdressRegister[2]        = 24'h000B58;  //Track2BeginAddress
        TracksAdressRegister[3]        = 24'h001B80;  //Track2EndAddress
        TracksAdressRegister[4]        = 24'h001B82;  //Track3BeginAddress 
        TracksAdressRegister[5]        = 24'h0024C0;  //Track3EndAddress
        TracksAdressRegister[6]        = 24'h0024C2;  //Track4BeginAddress
        TracksAdressRegister[7]        = 24'h00283C;  //Track4EndAddress
        TracksAdressRegister[8]        = 24'h00283E;  //Track5BeginAddress
        TracksAdressRegister[9]        = 24'h010C1C;  //Track5EndAddress
        TracksAdressRegister[10]       = 24'h000C1E;  //Track6BeginAddress
        TracksAdressRegister[11]       = 24'h02CADE;  //Track6EndAddress
        TracksAdressRegister[12]       = 24'h02CAE0;  //Track7BeginAddress
        TracksAdressRegister[13]       = 24'h040C9C;  //Track7EndAddress

        
               
        SD_InputAddress           = 24'h000014; 
        SDReadCount               = 0;        
        

    end
    //Instancias
    Audio_ClockManager audvid_clockmanager(
        .InputCLK(CLK),
        .MasterCLK(MasterCLK),
        .I2SCLK(I2SCLK)        
    );

    SD_SPI sd_spi(
        .MasterCLK(MasterCLK),
        .WorkCLK(SD_WorkCLK),
        .Reset(Reset),
        .SPI_MISO(SD_SPI_MISO),
        .SPI_MOSI(SD_SPI_MOSI),
        .SPI_CLK(SD_SPI_CLK),
        .SPI_CS(SD_SPI_CS),        
        .InputData(SD_InputData),                       
        .EnableDataRead(SD_EnableDataRead),             
        .InputDataClock(SD_InputDataClock),             
        .InputAddress(SD_InputAddress)                  
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

    //  Cambio de direcciones
    always@(posedge MasterCLK)begin
        //Lectura 1 Track 1
        if (SDReadCount<512) begin
            SD_InputAddress<=WriteAudio_Track1AddressCount;
        //Lectura 1 Track 2 
        end else if(SDReadCount<1024) begin
            SD_InputAddress<=WriteAudio_Track2AddressCount;

        end
        //Habilitacion de reprduccion para cada pista
        if(WriteAudio_Track1EnablePlay && WriteAudio_Track1ControlEnable)begin
            WriteAudio_Track1Data<=Track1Register[WriteAudio_PlayCount];
        end else begin
            WriteAudio_Track1Data<=0;
        end
        if(WriteAudio_Track2EnablePlay && WriteAudio_Track2ControlEnable)begin
            WriteAudio_Track2Data<=Track2Register[WriteAudio_PlayCount];
        end else begin
            WriteAudio_Track2Data<=0;    
        end
    end

    
    //Almacenamiento de Audio
    always@(negedge SD_InputDataClock) begin
        if(WriteAudio_EnableSDAudioRead)begin
            ReadAudio_EnableStorage<=1;
        end

        if(SD_EnableDataRead) begin
            if(ReadAudio_EnableStorage)begin
                //Lectura Track 1
                if (SDReadCount<512) begin
                    Track1Register[{WriteAudio_BankSelector,SDReadCount[8:2]}]<=({24'h000000,SD_InputData}<<(8*(3-SDReadCount[1:0])));

                //Lectura Track 2 
                end else if(SDReadCount<1024) begin
                    Track2Register[{WriteAudio_BankSelector,SDReadCount[8:2]}]<=({24'h000000,SD_InputData}<<(8*(3-SDReadCount[1:0])));

                end
            end
            SDReadCount<=SDReadCount+1;

        end
    end

    //  Control de Audio
    //Deteccion de cambio de registro desde el procesador
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

    //Reproduccion de Audio, control de direcciones y su orden
     
    always@(posedge DAC_DataClock) begin
        //
        if(WriteAudio_PlayCount==255 || WriteAudio_PlayCount==127) begin
            if(WriteAudio_PlayCount==127)begin
                WriteAudio_BankSelector<=0;
            end else if (WriteAudio_PlayCount==255)begin
                WriteAudio_BankSelector<=1;
            end
            WriteAudio_EnableSDAudioRead<=0;
            
            WriteAudio_PlayCount<=WriteAudio_PlayCount+1;  
            
            //Track1 Control
            if(WriteAudio_Track1EnablePlay) begin         
                if(WriteAudio_Track1AddressCount<=WriteAudio_Track1EndAddress && WriteAudio_Track1AddressCount>=WriteAudio_Track1BeginAddress) begin
                    if(WriteAudio_Track1AddressCount==WriteAudio_Track1EndAddress) begin
                        if(WriteAudio_Track1EnableLoop) begin
                            WriteAudio_Track1AddressCount<=WriteAudio_Track1BeginAddress;
                        end else begin
                            WriteAudio_Track1ControlEnable<=0;
                        end
                    end else begin
                        WriteAudio_Track1AddressCount<=WriteAudio_Track1AddressCount+2; 
                    end
                end else begin
                    WriteAudio_Track1AddressCount<=WriteAudio_Track1BeginAddress;
                end
            end else begin
                WriteAudio_Track1ControlEnable<=1;
                WriteAudio_Track1AddressCount<=WriteAudio_Track1BeginAddress;
            end
            //Track2 Control
            if(WriteAudio_Track2EnablePlay) begin         
                if(WriteAudio_Track2AddressCount<=WriteAudio_Track2EndAddress && WriteAudio_Track2AddressCount>=WriteAudio_Track2BeginAddress) begin
                    if(WriteAudio_Track2AddressCount==WriteAudio_Track2EndAddress) begin
                        if(WriteAudio_Track2EnableLoop) begin
                            WriteAudio_Track2AddressCount<=WriteAudio_Track2BeginAddress;
                        end else begin
                            WriteAudio_Track2ControlEnable<=0;
                        end
                    end else begin
                        WriteAudio_Track2AddressCount<=WriteAudio_Track2AddressCount+2; 
                    end
                end else begin
                    WriteAudio_Track2AddressCount<=WriteAudio_Track2BeginAddress;
                end
            end else begin
                WriteAudio_Track2ControlEnable<=1;
                WriteAudio_Track2AddressCount<=WriteAudio_Track2BeginAddress;
            end   
        end else if(WriteAudio_PlayCount==0 || WriteAudio_PlayCount==128) begin
            WriteAudio_EnableSDAudioRead<=1;
            WriteAudio_PlayCount<=WriteAudio_PlayCount+1;
        end else begin
            WriteAudio_EnableSDAudioRead<=0;       
            WriteAudio_PlayCount<=WriteAudio_PlayCount+1;
        end 
    end

    StereoSignedAdder adder(
        .A(WriteAudio_Track1Data),
        .B(WriteAudio_Track2Data),
        .O(DAC_Data)
    );
    


endmodule  