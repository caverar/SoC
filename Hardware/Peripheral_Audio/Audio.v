
module Audio(


    input  wire        Reset,
    input  wire        CLK,      
    input  wire [4:0]  Track1ControlRegister,
    input  wire [4:0]  Track2ControlRegister,    
    output wire        DAC_I2S_DATA,
    output wire        DAC_I2S_CLK,
    output wire        DAC_I2S_WS

    );

   
    wire        DAC_DataClock;
    wire [31:0] DAC_Data;
    wire        MasterCLK;      //100MHz
    wire        I2SCLK;         //41000Hz x32 
    wire        Tempo_CLK;   

    
    
  


 
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
 

    reg  [23:0] TracksAdressRegister [13:0];
    

    initial begin
      
        WriteAudio_PlayCount           = 0;

        WriteAudio_Track1BeginAddress  = 0;
        WriteAudio_Track1EndAddress    = 0;
        WriteAudio_Track1EnablePlay    = 0;
        WriteAudio_Track1EnableLoop    = 0;
        WriteAudio_Track2BeginAddress  = 0;
        WriteAudio_Track2EndAddress    = 0;
        WriteAudio_Track1EnablePlay    = 0;
        WriteAudio_Track1EnableLoop    = 0; 
        

    end
    //Instancias
    Audio_ClockManager audvid_clockmanager(
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
    // StereoSignedAdder adder(
    //     .A(WriteAudio_Track1Data),
    //     .B(WriteAudio_Track2Data),
    //     .O(DAC_Data)
    // );

    Synthesizer synthesizer1(
        .MasterCLK(MasterCLK),
        .Reset(Reset),
        .OutputDataClock(DAC_DataClock),
        .InputDataClock(Tempo_CLK),
        .InputData(24'h000008),  
        .OutputData(DAC_Data)
    );
    //	Reloj de tempo de cancion -400Khz 
	FrequencyGenerator #(.MasterFrequency(100000000),.frequency(4),  .bitsNumber(26)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(Tempo_CLK)        
	);


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




    
    



endmodule  