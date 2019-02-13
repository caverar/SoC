module SD_SPI(
    input              MasterCLK,
    input              Reset,
    input              SPI_MISO,
    output             SPI_MOSI,
    output             SPI_CLK,
    output reg         SPI_CS,
    output             SPI_count,
    output             SPI_UtilCount,
    output wire [7:0]  InputData,
    output reg         EnableVideoRead,
    output wire        InputDataClock,
    input       [15:0] InputAddress
    );


    wire        SPI_InitClock;
    wire        SPI_WorkClock;
    wire        DataClock;
    reg  [9:0]  UtilCount;
    reg         SPI_Enable;
    reg  [7:0]  OutputData;
    wire        SPI_InputCLK;
    reg  [15:0] Address;
    reg         EnableUtilCount;

    reg [5:0] state; 
    //reg [5:0] state;
    
    
    
    //Inicializacion
    initial begin
        UtilCount=0;
        OutputData=8'hFF;
        SPI_CS=1;
        SPI_Enable=0;
        EnableVideoRead=0;
        EnableUtilCount=0;
        state=0;
        //state=0;
    end
    //Instancias

    //	Reloj SPI de Inicializacion -400Khz 
	FrequencyGenerator #(.frequency(400000), .bitsNumber(8)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_InitClock)
	);

	//	Reloj SPI de Trabajo-25Mhz 
	FrequencyGenerator #(.frequency(10000000), .bitsNumber(5)) spiWorkClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_WorkClock)
	);

    // modulo SPI
    FullSPI spi(
        .InputData(InputData),
        .OutputData(OutputData),
        .SPI_MOSI(SPI_MOSI),
        .SPI_MISO(SPI_MISO),
        .SPI_CLK(SPI_CLK),
        .SPI_InputCLK(SPI_InputCLK),
        .DataClk(DataClock),
        .SPI_Enable(SPI_Enable)
    );
    FullSPI spiCount(
        .OutputData({2'b00,state[5:0]}),
        .SPI_MOSI(SPI_count),
        .SPI_InputCLK(SPI_InputCLK),
        .SPI_Enable(SPI_Enable)
    );

    FullSPI spiUtilCount(
        .OutputData(UtilCount[7:0]),
        .SPI_MOSI(SPI_UtilCount),
        .SPI_InputCLK(SPI_InputCLK),
        .SPI_Enable(SPI_Enable)
    );
    //Logica Secuencial

    //  Maquina de estados
    

    //      Estados

    localparam s00={2'b00,4'h0};  //00
    localparam s01={2'b00,4'h1};  //01
    localparam s02={2'b00,4'h2};  //02
    localparam s03={2'b00,4'h3};  //03
    localparam s04={2'b00,4'h4};  //04
    localparam s05={2'b00,4'h5};  //05
    localparam s06={2'b00,4'h6};  //06
    localparam s07={2'b00,4'h7};  //07
    localparam s08={2'b00,4'h8};  //08
    localparam s09={2'b00,4'h9};  //09
    localparam s10={2'b00,4'hA};  //10
    localparam s11={2'b00,4'hB};  //11
    localparam s12={2'b00,4'hC};  //12
    localparam s13={2'b00,4'hD};  //13
    localparam s14={2'b00,4'hE};  //14
    localparam s15={2'b00,4'hF};  //15
    localparam s16={2'b01,4'h0};  //16
    localparam s17={2'b01,4'h1};  //17
    localparam s18={2'b01,4'h2};  //18
    localparam s19={2'b01,4'h3};  //19
    localparam s20={2'b01,4'h4};  //20
    localparam s21={2'b01,4'h5};  //21
    localparam s22={2'b01,4'h6};  //22
    localparam s23={2'b01,4'h7};  //23
    localparam s24={2'b01,4'h8};  //24
    localparam s25={2'b01,4'h9};  //25
    localparam s26={2'b01,4'hA};  //26
    localparam s27={2'b01,4'hB};  //27
    localparam s28={2'b01,4'hC};  //28
    localparam s29={2'b01,4'hD};  //29
    localparam s30={2'b01,4'hE};  //30
    localparam s31={2'b01,4'hF};  //31
    localparam s32={2'b10,4'h0};  //32
    localparam s33={2'b10,4'h1};  //33
    localparam s34={2'b10,4'h2};  //34
    
    always@(posedge DataClock) begin
        if(Reset) begin
            state<=s00;  
        end else begin            
            if (EnableUtilCount==1) begin
                UtilCount<=UtilCount+1;
            end else begin
                UtilCount<=0;
            end
            case(state)
                // Reset Inicio
                s00: begin 
                    state<=s01; 
                    OutputData<=8'hFF; 
                    SPI_CS<=1; 
                    SPI_Enable<=0; 
                    EnableUtilCount<=0; 
                    EnableVideoRead<=0; 
                end
                //1ms wait
                s01: begin 
                    SPI_CS<=1;
                    OutputData<=8'hFF;                               
                    if (UtilCount>=75) begin
                        EnableUtilCount<=0;
                        SPI_Enable<=1;                    
                        state<=s02;
                    end else begin
                        EnableUtilCount<=1;
                        state<=s01;                
                    end
                end
                //74 Pulsos
                s02: begin
                    OutputData<=8'hFF;                
                    SPI_Enable<=1;
                    SPI_CS<=1;
                    if(UtilCount>=8) begin
                        state<=s03;
                        EnableUtilCount<=0;
                    end else begin
                        state<=s02;
                        EnableUtilCount<=1;                
                    end
                end
                //CMD0 RESET       
                //  CMD0-1
                s03: begin
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s04;
                    OutputData<={2'b01,6'b000000};
                end
                //  CMD0-2
                s04: begin
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0; 
                    state<=s05;
                    OutputData<=8'h00;
                end
                //  CMD0-3
                s05: begin
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0; 
                    state<=s06;
                    OutputData<=8'h00;
                end
                //  CMD0-4
                s06: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s07;
                    OutputData<=8'h00;
                end
                //  CMD0-5
                s07: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s08;
                    OutputData<=8'h00;
                end
                //  CMD0-6-CRC
                s08: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s09;
                    OutputData<={7'b1001010,1'b1};
                end
                //  CMD0-response
                s09: begin            
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    if(InputData==8'h01) begin
                        state<=s10;
                        OutputData<=8'hFF;
                    end else begin
                        OutputData<=8'hFF;
                        state<=s09;
                    end 
                end           
                //CMD58-ACMD Mode
                //  CMD58-1
                s10: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s11;
                    OutputData<={2'b01,6'b110111};
                end
                //  CMD58-2
                s11: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s12;
                    OutputData<=8'h00;
                end
                //  CMD58-3
                s12: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s13;
                    OutputData<=8'h00;
                end
                //  CMD58-4
                s13: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s14;
                    OutputData<=8'h00;
                end
                //  CMD58-5
                s14: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s15;
                    OutputData<=8'h00;
                end
                //  CMD58-6-CRC
                s15: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s16;
                    OutputData<={7'b1111111,1'b1};
                end
                //  CMD58-response
                s16: begin  
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    if(InputData==8'h01) begin
                        state<=s17;
                        OutputData<=8'hFF;
                    end else begin
                        state<=s16;
                        OutputData<=8'hFF;
                    end
                end
                //ACMD41-Inicializacion  
                //  ACMD41-1
                s17: begin            
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s18;
                    OutputData<={2'b01,6'b101001};
                end
                //  ACMD41-2
                s18: begin                
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s19;
                    OutputData<=8'h40;
                end
                //  ACMD41-3
                s19: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s20;
                    OutputData<=8'h00;
                end
                //  ACMD41-4
                s20: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s21;
                    OutputData<=8'h00;
                end
                //  ACMD41-5
                s21: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s22;
                    OutputData<=8'h00;
                end
                //  ACMD41-6
                s22: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s23;
                    OutputData<={7'b1111111,1'b1};
                end
                //  ACMD41-response-100ms initilitation
                s23: begin             
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    if(InputData!=8'hFF) begin
                        if(InputData==8'h00) begin    
                            state<=s24;
                            OutputData<=8'hFF;
                        end else begin
                            state<=s10;
                            OutputData<=8'hFF;
                        end                 
                    end else begin
                        state<=s23;
                        OutputData<=8'hFF;
                    end
                end    
                //CMD17-Lectura
                //  CMD17-1
                s24: begin            
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s25;
                    OutputData<={2'b01,6'b010001};
                end
                //  CMD17-2
                s25: begin
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s26;
                    OutputData<=8'h00;
                end
                //  CMD17-3
                s26: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s27;
                    OutputData<=Address[15:8];
                end
                //  CMD17-4
                s27: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s28;
                    OutputData<=Address[7:0];
                end
                //  CMD17-5
                s28: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s29;
                    OutputData<=8'h00;
                end
                //  CMD17-6
                s29: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    state<=s30;
                    OutputData<={7'b0000000,1'b1};
                end
                //  CMD17-response
                s30: begin             
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    if(InputData==8'h00) begin    
                        state<=s31;
                        OutputData<=8'hFF;      
                    end else begin
                        state<=s30;
                        OutputData<=8'hFF;
                    end
                end
                //  CMD17-DataSaving        
                s31: begin 
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    if(InputData!=8'hFF) begin
                        state<=s32;
                        EnableVideoRead<=1;
                    end
                end
                s32: begin 
                    OutputData<=8'hFF;
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    if(UtilCount<512) begin
                        EnableUtilCount<=1;
                        state<=s32;
                    end else begin
                        EnableUtilCount<=0;
                        EnableVideoRead<=0;      
                        state<=s33;
                    end
                end                
                s33: begin
                    SPI_Enable<=1; 
                    SPI_CS<=0;
                    EnableUtilCount<=0;
                    OutputData<=8'hFF;
                    state<=s24;
                end
                //  STOP
                s34: begin 
                    OutputData<=8'hFF;
                    SPI_Enable<=0;
                    EnableUtilCount<=0;
                end 

                default state<=s00;
            endcase
        end
    end

    always@ (posedge EnableVideoRead) begin
        Address<=InputAddress;
    end
    //Logica Combinacional

    assign SPI_InputCLK=(state<24)? SPI_InitClock : SPI_WorkClock;
    assign InputDataClock=~DataClock;  


endmodule
