
module Audio(
    input  wire        Reset,
    input  wire        CLK,      
    input  wire [3:0]  AudioControlRegister,
    input  wire [15:0] SoundTrackInitializationRegister,
    input  wire        InitializationEnableRegister,   
    output wire        DAC_I2S_DATA,
    output wire        DAC_I2S_CLK,
    output wire        DAC_I2S_WS
    );

   
    wire        DAC_DataClock;
    wire [31:0] DAC_Data;
    wire        MasterCLK;      //100MHz
    wire        I2SCLK;         //41000Hz x32 
    wire        Tempo_CLK;   

    //Registros con Pistas

    reg  [7:0] SoundTrack[187:0];
    reg  [7:0] Track1[2:0];
    reg  [7:0] Track2[1:0];
    reg  [7:0] Track3;
    
    wire [31:0] SoundTrackSample;
    wire [31:0] SoundEffectSample;
    reg  [7:0]  SoundTrackData;
    reg  [7:0]  SoundEffectData;
    //Registros de control
    reg SoundTrackEnable;
    reg SoundEffectEnable;
    reg [1:0] SoundEffectSelected;
    reg [7:0] SoundTrackCount;
    reg [3:0] SoundEffectCount;

    initial begin      
        //$readmemh("SoundTrack.mem",SoundTrack);
        $readmemh("Track1.mem",Track1);
        $readmemh("Track2.mem",Track2);
        Track3=8'h11;
        

 
        SoundTrackData      = 0;
        SoundEffectData     = 0;        
        SoundTrackEnable    = 0;
        SoundEffectEnable   = 0;
        SoundEffectSelected = 0;
        SoundTrackCount     = 0;
        SoundEffectCount    = 0;


    end
    //Instancias
    Audio_ClockManager audio_clockmanager(
        .InputCLK(CLK),
        .MasterCLK(MasterCLK),
        .I2SCLK(I2SCLK)        
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
    StereoSignedAdder adder(
        .A(SoundTrackSample),
        .B(SoundEffectSample),
        .O(DAC_Data)
    );

    Synthesizer SoundTrackSynthesizer(
        .MasterCLK(MasterCLK),
        .Reset(Reset),
        .OutputDataClock(DAC_DataClock),
        .InputDataClock(Tempo_CLK),
        .InputData(SoundTrackData),  
        .OutputData(SoundTrackSample)
    );

    Synthesizer SoundEffectSynthesizer(
        .MasterCLK(MasterCLK),
        .Reset(Reset),
        .OutputDataClock(DAC_DataClock),
        .InputDataClock(Tempo_CLK),
        .InputData(SoundEffectData),  
        .OutputData(SoundEffectSample)
    );


    //	Reloj de tempo de cancion -5Hz =300bpm 
	FrequencyGenerator #(.MasterFrequency(100000000),.frequency(5),  .bitsNumber(25)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(Tempo_CLK)        
	);


    //  Control de Audio
    //Deteccion de cambio de registro desde el procesador
    always@(posedge MasterCLK) begin
        SoundTrackEnable    <= AudioControlRegister[3];
        SoundEffectEnable   <= AudioControlRegister[2];
        SoundEffectSelected <= AudioControlRegister[1:0];
        
    end
    

    always@(posedge Tempo_CLK, negedge SoundEffectEnable)begin
        if(SoundEffectEnable==0)begin
            SoundEffectCount<=0;
        end else if(Tempo_CLK)begin            
            //Reproduccion
            //if(SoundEffectEnable)begin
                if(SoundEffectSelected==1)begin
                    if(SoundEffectCount<3)begin
                        SoundEffectCount<=SoundEffectCount+1;
                    end
                end else if(SoundEffectSelected==2)begin
                    if(SoundEffectCount<2)begin
                        SoundEffectCount<=SoundEffectCount+1;
                    end
                end else if(SoundEffectSelected==3)begin
                    if(SoundEffectCount<1)begin
                        SoundEffectCount<=SoundEffectCount+1;
                    end
                end else begin
                    SoundEffectCount<=0;
                end

            // end else begin
            //     SoundEffectCount<=0;
            // end
        end
    end

    always@(posedge Tempo_CLK)begin
        //Reproduccion SoundTrack
        if(SoundTrackEnable)begin                      
            if(SoundTrackCount<187)begin
                SoundTrackCount<=SoundTrackCount+1;                
            end else begin
                SoundTrackCount<=0;
            end
        end else begin
            SoundTrackCount<=0;            
        end
    end

    always@(posedge DAC_DataClock)begin
        if(SoundTrackEnable)begin
            SoundTrackData=SoundTrack[SoundTrackCount];
        end else begin            
            SoundTrackData <=0;
        end

        if(SoundEffectEnable)begin
            if(SoundEffectSelected==1)begin
                if(SoundEffectCount<3)begin
                    SoundEffectData<=Track1[SoundEffectCount];
                end else begin
                    SoundEffectData<=0;
                end
            end else if(SoundEffectSelected==2)begin
                if(SoundEffectCount<2)begin
                    SoundEffectData<=Track2[SoundEffectCount];
                end else begin
                    SoundEffectData<=0;
                end
            end else if(SoundEffectSelected==3)begin
                if(SoundEffectCount<1)begin
                    SoundEffectData<=Track3;
                end else begin
                    SoundEffectData<=0;
                end
            end else begin
                SoundEffectData<=0;
            end          
        end else begin
            SoundEffectData<=0;
        end

    end

    always@(posedge MasterCLK)begin
        if(InitializationEnableRegister && SoundTrackInitializationRegister[15:8]<=187)begin
            SoundTrack[SoundTrackInitializationRegister[15:8]]<=SoundTrackInitializationRegister[7:0];
        end
    end
     

endmodule  