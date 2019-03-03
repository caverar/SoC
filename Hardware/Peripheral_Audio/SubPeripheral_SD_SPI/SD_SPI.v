module SD_SPI(
    input              MasterCLK,
    input              WorkCLK,    
    input              Reset,
    input              SPI_MISO,
    output             SPI_MOSI,
    output             SPI_CLK,
    output             SPI_CS,
    output             DEBUG_SPI_Init_Count,
    output wire [7:0]  InputData,           //Datos que llegan de la SD
    output reg         EnableDataRead,      
    output wire        InputDataClock,      
    input       [23:0] InputAddress
    );



     

    
    reg  [4:0]  Init_Count;
    reg  [9:0]  Init_UtilCount;
    reg  [3:0]  Work_Count;
    reg  [9:0]  Work_UtilCount;
    
    reg  [23:0] Address;
    
    wire [7:0] Init_InputData;
    reg  [7:0] Init_OutputData;
    wire       Init_SPI_MOSI;    
    wire       Init_SPI_CLK;
    wire       Init_SPI_InputCLK;
    reg        Init_SPI_CS;
    wire       Init_DataClock;
    reg        Init_SPI_Enable;
    
    wire [7:0] Work_InputData;
    reg  [7:0] Work_OutputData;
    wire       Work_SPI_MOSI;    
    wire       Work_SPI_CLK;
    wire       Work_SPI_InputCLK;
    reg        Work_SPI_CS;
    wire       Work_DataClock;
    reg        Work_SPI_Enable;
    
    //Inicializacion
    initial begin
        Init_Count=0;
        Init_UtilCount=0;
        Init_OutputData=8'hFF;
        Init_SPI_CS=1;
        Init_SPI_Enable=0;
        Work_Count=0;
        Work_UtilCount=0;
        Work_OutputData=8'hFF;
        Work_SPI_CS=1;
        Work_SPI_Enable=0;        
        EnableDataRead=0;
    end
    //Instancias

    //	Reloj SPI de Inicializacion -400Khz 
	FrequencyGenerator #(.MasterFrequency(100000000),.frequency(400000),  .bitsNumber(8)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(Init_SPI_InputCLK)        
	);

	// 	Reloj SPI de Trabajo-12.5Mhz 
	 FrequencyGenerator #(.MasterFrequency(100000000),.frequency(12500000), .bitsNumber(5)) spiWorkClock(
	 	.InputCLK(MasterCLK),
	 	.OutputCLK(Work_SPI_InputCLK)
	 );
	 
	//assign Work_SPI_InputCLK=WorkCLK;

    // modulo SPI
    FullSPI InitSpi(
        .InputData(Init_InputData),
        .OutputData(Init_OutputData),
        .SPI_MOSI(Init_SPI_MOSI),
        .SPI_MISO(SPI_MISO),
        .SPI_CLK(Init_SPI_CLK),
        .SPI_InputCLK(Init_SPI_InputCLK),
        .DataClk(Init_DataClock),
        .SPI_Enable(Init_SPI_Enable)
    );
    
    FullSPI WorkSpi(
        .InputData(Work_InputData),
        .OutputData(Work_OutputData),
        .SPI_MOSI(Work_SPI_MOSI),
        .SPI_MISO(SPI_MISO),
        .SPI_CLK(Work_SPI_CLK),
        .SPI_InputCLK(Work_SPI_InputCLK),
        .DataClk(Work_DataClock),
        .SPI_Enable(Work_SPI_Enable)
    );
    
    FullSPI DEBUG_Init_Count(
        .OutputData({4'b0000,Work_Count}),
        .SPI_MOSI(DEBUG_SPI_Init_Count),
        .SPI_InputCLK(Init_SPI_InputCLK), 
        .SPI_Enable(1'b1)
    );
    //Logica Secuencial
    //  Proceso de Inicializacion


    //Maquina de estados de inicializacion
    always@(posedge Init_DataClock) begin 

        if(Reset) begin
            Init_Count<=0;
        end else begin
            case(Init_Count)
                0:  begin
                    Init_OutputData<=8'h00;
                    Init_SPI_CS<=1;
                    Init_SPI_Enable<=0;                    
                    Init_Count<=1;
                    Init_UtilCount<=0;
                   
                end            
                //1ms wait
                1:  begin            
                    if(Init_UtilCount>=75) begin
                        Init_Count<=2;
                        Init_UtilCount<=0;
                        Init_SPI_Enable<=1;
                        Init_OutputData<=8'hFF;
                    end else begin
                        Init_UtilCount<=Init_UtilCount+1;                
                    end
                end
                //74 Pulsos
                2:  begin
                    if(Init_UtilCount>=8) begin
                        Init_Count<=3;
                        Init_UtilCount<=0;
                    end else begin
                        Init_UtilCount<=Init_UtilCount+1;                
                    end
                end
                //CMD0 RESET       
                //  CMD0-1
                3:  begin 
                    Init_SPI_CS<=0;
                    Init_Count<=4;
                    Init_OutputData<={2'b01,6'b000000};
                end
                //  CMD0-2
                4:  begin 
                    Init_Count<=5;
                    Init_OutputData<=8'h00;
                end
                //  CMD0-3
                5:  begin 
                    Init_Count<=6;
                    Init_OutputData<=8'h00;
                end
                //  CMD0-4
                6:  begin 
                    Init_Count<=7;
                    Init_OutputData<=8'h00;
                end
                //  CMD0-5
                7:  begin 
                    Init_Count<=8;
                    Init_OutputData<=8'h00;
                end
                //  CMD0-6-CRC
                8:  begin 
                    Init_Count<=9;
                    Init_OutputData<={7'b1001010,1'b1};
                end
                //  CMD0-response
                9:  begin            
                    if(Init_InputData==8'h01) begin
                        Init_Count<=10;
                        Init_OutputData<=8'hFF;
                    end else begin
                        Init_OutputData<=8'hFF;
                    end
                end            
                //CMD58-ACMD Mode
                //  CMD58-1
                10: begin 
                    Init_Count<=11;
                    Init_OutputData<={2'b01,6'b110111};
                end
                //  CMD58-2
                11: begin 
                    Init_Count<=12;
                    Init_OutputData<=8'h00;
                end
                //  CMD58-3
                12: begin 
                    Init_Count<=13;
                    Init_OutputData<=8'h00;
                end
                //  CMD58-4
                13: begin 
                    Init_Count<=14;
                    Init_OutputData<=8'h00;
                end
                //  CMD58-5
                14: begin 
                    Init_Count<=15;
                    Init_OutputData<=8'h00;
                end
                //  CMD58-6-CRC
                15: begin 
                    Init_Count<=16;
                    Init_OutputData<={7'b1111111,1'b1};
                end
                //  CMD58-response
                16: begin  
                    if(Init_InputData==8'h01) begin
                        Init_Count<=17;
                        Init_OutputData<=8'hFF;
                    end else begin
                        Init_OutputData<=8'hFF;
                    end
                end
                //ACMD41-Inicializacion  
                //  ACMD41-1
                17: begin            
                    Init_Count<=18;
                    Init_OutputData<={2'b01,6'b101001};
                end
                //  ACMD41-2
                18: begin                
                    Init_Count<=19;
                    Init_OutputData<=8'h40;
                end
                //  ACMD41-3
                19: begin 
                    Init_Count<=20;
                    Init_OutputData<=8'h00;
                end
                //  ACMD41-4
                20: begin 
                    Init_Count<=21;
                    Init_OutputData<=8'h00;
                end
                //  ACMD41-5
                21: begin 
                    Init_Count<=22;
                    Init_OutputData<=8'h00;
                end
                //  ACMD41-6
                22: begin 
                    Init_Count<=23;
                    Init_OutputData<={7'b1111111,1'b1};
                end
                //  ACMD41-response-100ms initilitation
                23: begin             
                    if(Init_InputData!=8'hFF) begin
                        if(Init_InputData==8'h00) begin    
                            Init_Count<=24;
                            Init_OutputData<=8'hFF;
                        end else begin
                            Init_Count<=10;
                            Init_OutputData<=8'hFF;
                        end                 
                    end else begin
                        Init_OutputData<=8'hFF;
                    end
                end
                24: begin
                    Init_OutputData<=8'hFF;
                    Init_SPI_CS<=1;
                    Init_SPI_Enable<=0;
                    Init_Count<=25;  
                end
                25: begin
                    
                end                  
//                
                default begin
                    Init_Count<=0;
                end

            endcase
        end
    end
    //Maquina de estados de lectura
    
    always@(posedge Work_DataClock) begin 

        if(Reset) begin
            Work_Count<=0;
        end else begin
            case(Work_Count)
                0:  begin
                    if(Init_Count==25)begin
                        Work_Count<=1;
                    end
                    Work_OutputData<=8'hFF;
                    Work_SPI_CS<=1;
                    Work_SPI_Enable<=0;                    
                    Work_UtilCount<=0;
                  
                end            
                //Trama de transicion de reloj
                1:  begin 
                    Work_Count<=2;
                    Work_SPI_CS<=0;
                    Work_UtilCount<=0;
                    Work_SPI_Enable<=1;
                    Work_OutputData<=8'hFF;
                    
                end
                
                 
                //CMD17-Lectura
                //  CMD17-1
                2:  begin            
                    Work_Count<=3;
                    Work_OutputData<={2'b01,6'b010001};
                end
                //  CMD17-2
                3:  begin
                    Work_Count<=4;
                    Work_OutputData<=Address[23:16];
                end
                //  CMD17-3
                4:  begin 
                    Work_Count<=5;
                    Work_OutputData<=Address[15:8];
                end
                //  CMD17-4
                5:  begin 
                    Work_Count<=6;
                    Work_OutputData<=Address[7:0];
                end
                //  CMD17-5
                6:  begin 
                    Work_Count<=7;
                    Work_OutputData<=8'h00;
                end
                //  CMD17-6
                7:  begin 
                    Work_Count<=8;
                    Work_OutputData<={7'b0000000,1'b1};
                end
                //  CMD17-response
                8:  begin             
                    if(Work_InputData==8'h00) begin    
                        Work_Count<=9;
                        Work_OutputData<=8'hFF;      
                    end else begin
                        Work_OutputData<=8'hFF;
                    end
                end
                //  CMD17-DataSaving        
                9:  begin 
                    if(Work_InputData!=8'hFF) begin
                        Work_Count<=10;
                        EnableDataRead<=1;
                    end
                end 
                10: begin 
                    if(Work_UtilCount<512) begin
                        Work_UtilCount<=Work_UtilCount+1;
                    end else begin
                        Work_UtilCount<=0;
                        EnableDataRead<=0;      
                        Work_Count<=11;
                    end                
                end 
                11: begin
                    Work_Count<=2;
                end
                
                //  STOP
                12: begin 
                    Work_OutputData<=8'hFF;
                    Work_SPI_Enable<=0;
                end
                default begin
                    Work_Count<=0;
                end

            endcase
        end
    end

    always@ (posedge EnableDataRead) begin
        Address<=InputAddress;
    end
    //Logica Combinacional

    
    assign InputDataClock=Work_DataClock;
    
    assign InputData = (Init_Count<25)? Init_InputData : Work_InputData;
    assign SPI_MOSI  = (Init_Count<25)? Init_SPI_MOSI  : Work_SPI_MOSI;
    assign SPI_CLK   = (Init_Count<25)? Init_SPI_CLK   : Work_SPI_CLK;
    assign SPI_CS    = (Init_Count<25)? Init_SPI_CS    : Work_SPI_CS;
    
    
      


endmodule
