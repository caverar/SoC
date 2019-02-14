module SD_SPI(
    input              MasterCLK,
    input              Reset,
    input              SPI_MISO,
    output             SPI_MOSI,
    output             SPI_CLK,
    output reg         SPI_CS,
    output             SPI_COUNT_DEBUG,
    output             SPI_UTILCOUNT_DEBUG,
    output wire [7:0]  InputData,           //Datos que llegan de la SD
    output reg         EnableDataRead,      
    output wire        InputDataClock,      
    input       [15:0] InputAddress
    );



    wire        SPI_InitClock;
    wire        SPI_WorkClock;
    wire        DataClock;
    reg  [5:0]  count;
    reg  [9:0]  UtilCount;
    reg         SPI_Enable;
    reg  [7:0]  OutputData;
    wire        SPI_InputCLK;
    reg  [9:0]  VideoCount;
    reg  [15:0] Address;
    
    
    
    //Inicializacion
    initial begin
        count=0;
        UtilCount=0;
        OutputData=8'hFF;
        SPI_CS=1;
        SPI_Enable=0;
        VideoCount=0;
        EnableDataRead=0;
    end
    //Instancias
    wire Buffered_MasterCLK;
    BUF inputBuffer(
        .O (Buffered_MasterCLK),
        .I (MasterCLK)
    );

    //	Reloj SPI de Inicializacion -400Khz 
	FrequencyGenerator #(.frequency(400000), .bitsNumber(8)) spiInitClock(
		.InputCLK(Buffered_MasterCLK),
		.OutputCLK(SPI_InitClock)
	);

	//	Reloj SPI de Trabajo-12.5Mhz 
	FrequencyGenerator #(.frequency(12500000), .bitsNumber(5)) spiWorkClock(
		.InputCLK(Buffered_MasterCLK),
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
        .OutputData({2'b00,count[5:0]}),
        .SPI_MOSI(SPI_COUNT_DEBUG),
        .SPI_InputCLK(SPI_InputCLK),
        .SPI_Enable(SPI_Enable)
    );

    FullSPI spiUtilCount(
        .OutputData(UtilCount[7:0]),
        .SPI_MOSI(SPI_UTILCOUNT_DEBUG),
        .SPI_InputCLK(SPI_InputCLK),
        .SPI_Enable(SPI_Enable)
    );
    //Logica Secuencial
    //  Proceso de Inicializacion


    always@(posedge DataClock) begin 

        if(Reset) begin
            count<=0;
        end else if(count==0) begin
            OutputData<=8'h00;
            SPI_CS<=1;
            SPI_Enable<=0;
            VideoCount<=0; 
            count<=1;
            UtilCount<=0;
            EnableDataRead<=0;
        //1ms wait
        end else if(count==1) begin
            if(UtilCount>=75) begin
                count<=2;
                UtilCount<=0;
                SPI_Enable<=1;
                OutputData<=8'hFF;
            end else begin
                UtilCount<=UtilCount+1;                
            end
        //74 Pulsos
        end else if(count==2) begin
            if(UtilCount>=8) begin
                count<=3;
                UtilCount<=0;
            end else begin
                UtilCount<=UtilCount+1;                
            end
        //CMD0 RESET       
        //  CMD0-1
        end else if(count==3) begin 
            SPI_CS<=0;
            count<=4;
            OutputData<={2'b01,6'b000000};
        //  CMD0-2
        end else if(count==4) begin 
            count<=5;
            OutputData<=8'h00;
        //  CMD0-3
        end else if(count==5) begin 
            count<=6;
            OutputData<=8'h00;
        //  CMD0-4
        end else if(count==6) begin 
            count<=7;
            OutputData<=8'h00;
        //  CMD0-5
        end else if(count==7) begin 
            count<=8;
            OutputData<=8'h00;
        //  CMD0-6-CRC
        end else if(count==8) begin 
            count<=9;
            OutputData<={7'b1001010,1'b1};
        //  CMD0-response
        end else if(count==9) begin            
            if(InputData==8'h01) begin
                count<=10;
                OutputData<=8'hFF;
            end else begin
                OutputData<=8'hFF;
            end            
        //CMD58-ACMD Mode
        //  CMD58-1
        end else if(count==10) begin 
            count<=11;
            OutputData<={2'b01,6'b110111};
        //  CMD58-2
        end else if(count==11) begin 
            count<=12;
            OutputData<=8'h00;
        //  CMD58-3
        end else if(count==12) begin 
            count<=13;
            OutputData<=8'h00;
        //  CMD58-4
        end else if(count==13) begin 
            count<=14;
            OutputData<=8'h00;
        //  CMD58-5
        end else if(count==14) begin 
            count<=15;
            OutputData<=8'h00;
        //  CMD58-6-CRC
        end else if(count==15) begin 
            count<=16;
            OutputData<={7'b1111111,1'b1};
        //  CMD58-response
        end else if(count==16) begin  
            if(InputData==8'h01) begin
                count<=17;
                OutputData<=8'hFF;
            end else begin
                OutputData<=8'hFF;
            end
        //ACMD41-Inicializacion  
        //  ACMD41-1
        end else if(count==17) begin            
            count<=18;
            OutputData<={2'b01,6'b101001};
        //  ACMD41-2
        end else if(count==18) begin                
            count<=19;
            OutputData<=8'h40;
        //  ACMD41-3
        end else if(count==19) begin 
            count<=20;
            OutputData<=8'h00;
        //  ACMD41-4
        end else if(count==20) begin 
            count<=21;
            OutputData<=8'h00;
        //  ACMD41-5
        end else if(count==21) begin 
            count<=22;
            OutputData<=8'h00;
        //  ACMD41-6
        end else if(count==22) begin 
            count<=23;
            OutputData<={7'b1111111,1'b1};
        //  ACMD41-response-100ms initilitation
        end else if(count==23) begin             
            if(InputData!=8'hFF) begin
                if(InputData==8'h00) begin    
                    count<=24;
                    OutputData<=8'hFF;
                end else begin
                    count<=10;
                    OutputData<=8'hFF;
                end                 
            end else begin
                OutputData<=8'hFF;
            end    
        //CMD17-Lectura
        //  CMD17-1
        end else if(count==24) begin            
            count<=25;
            OutputData<={2'b01,6'b010001};
        //  CMD17-2
        end else if(count==25) begin
            count<=26;
            OutputData<=8'h00;
        //  CMD17-3
        end else if(count==26) begin 
            count<=27;
            OutputData<=Address[15:8];
        //  CMD17-4
        end else if(count==27) begin 
            count<=28;
            OutputData<=Address[7:0];
        //  CMD17-5
        end else if(count==28) begin 
            count<=29;
            OutputData<=8'h00;
        //  CMD17-6
        end else if(count==29) begin 
            count<=30;
            OutputData<={7'b0000000,1'b1};
        //  CMD17-response
        end else if(count==30) begin             
            if(InputData==8'h00) begin    
                count<=31;
                OutputData<=8'hFF;      
            end else begin
                OutputData<=8'hFF;
            end
        //  CMD17-DataSaving        
        end else if(count==31) begin 
            if(InputData!=8'hFF) begin
                count<=32;
                EnableDataRead<=1;
            end
        end else if(count==32) begin 
            if(UtilCount<512) begin
                UtilCount<=UtilCount+1;
            end else begin
                UtilCount<=0;
                EnableDataRead<=0;      
                count<=33;
            end                
        end else if(count==33) begin
            count<=24;
        
        //  STOP
        end else if(count==34) begin 
            OutputData<=8'hFF;
            SPI_Enable<=0;
        end else begin
            count<=count+1;
        end
    end
    always@ (posedge EnableDataRead) begin
        Address<=InputAddress;
    end
    //Logica Combinacional

    assign SPI_InputCLK=(count<24)? SPI_InitClock : SPI_WorkClock;
    assign InputDataClock=~DataClock;  


endmodule
