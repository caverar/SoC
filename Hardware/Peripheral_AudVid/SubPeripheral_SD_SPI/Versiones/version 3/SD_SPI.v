module SD_SPI(
    input       MasterCLK,
    input       Reset,
    input       SPI_MISO,
    output      SPI_MOSI,
    output      SPI_CLK,
    output reg  SPI_CS,
    output      SPI_count,
    output reg  [7:0] checkData,
    output reg  EnableVideoRead,
    output wire InputDataClock
    );


    wire        SPI_InitClock;
    wire        SPI_WorkClock;
    wire        DataClock;
    reg  [10:0] count;
    reg         SPI_Enable;
    wire [7:0]  InputData;
    reg  [7:0]  OutputData;
    wire        SPI_InputCLK;
    reg  [9:0]  VideoCount;
    
    
    //Inicializacion
    initial begin
        count=0;
        OutputData=8'hFF;
        SPI_CS=1;
        SPI_Enable=0;
        VideoCount=0;
    end
    //Instancias

    //	Reloj SPI de Inicializacion -400Khz 
	FrequencyGenerator #(.frequency(400000), .bitsNumber(8)) spiInitClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_InitClock)
	);

	//	Reloj SPI de Trabajo-25Mhz 
	FrequencyGenerator #(.frequency(25000000), .bitsNumber(5)) spiWorkClock(
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
        .OutputData(count[7:0]),
        .SPI_MOSI(SPI_count),
        .SPI_InputCLK(SPI_InputCLK),
        .SPI_Enable(SPI_Enable)
    );
    //Logica Secuencial
    //  Proceso de Inicializacion
    always@(posedge (DataClock || Reset))begin

        if(Reset)begin
            count<=0;
            SPI_CS=1;
            SPI_Enable=0;
            VideoCount=0;
        end
        //74 pulsos
        if(count==60) begin 
            count<=count+1;
            SPI_Enable=1;
        
        //Dato vacio
        end else if(count==79) begin
            SPI_CS=0;
            count<=count+1;
            OutputData=8'hFF;

        //CMD0
        //  CMD0-1
        end else if(count==80) begin 
            SPI_CS=0;
            count<=count+1;
            OutputData={2'b01,6'b000000};
        //  CMD0-2
        end else if(count==81) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD0-3
        end else if(count==82) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD0-4
        end else if(count==83) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD0-5
        end else if(count==84) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD0-6-CRC
        end else if(count==85) begin 
            count<=count+1;
            OutputData={7'b1001010,1'b1};
        //  CMD0-response
        end else if(count==86) begin  
            OutputData=8'hFF;
            if(InputData==8'h01)begin
                count<=count+1;

            end                 

        //CMD8
        //  CMD8-1
        end else if(count==87) begin 
            SPI_CS=0;
            count<=count+1;
            OutputData={2'b01,6'b001000};
        //  CMD8-2
        end else if(count==88) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD8-3
        end else if(count==89) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD8-4
        end else if(count==90) begin 
            count<=count+1;
            OutputData=8'h01;
        //  CMD8-5
        end else if(count==91) begin 
            count<=count+1;
            OutputData=8'hAA;
        //  CMD8-6-CRC
        end else if(count==92) begin 
            count<=count+1;
            OutputData={7'b1000011,1'b1};
        //  CMD8-response-1
        end else if(count==93) begin  
            OutputData=8'hFF;
            if(InputData==8'h01)begin
                count<=count+1;
            end
        //  CMD8-response-2
        end else if(count==94) begin
            OutputData=8'hFF;
            if(InputData==8'h00) begin
                count<=count+1;
            end
        //  CMD8-response-3
        end else if(count==95) begin
            OutputData=8'hFF;
            if(InputData==8'h00) begin
                count<=count+1;
            end
        //  CMD8-response-4
        end else if(count==96) begin
            OutputData=8'hFF;
            if(InputData==8'h01) begin
                count<=count+1;
            end 
        //  CMD8-response-5
        end else if(count==97) begin
            OutputData=8'hFF;
            if(InputData==8'hAA) begin
                count<=count+1;
            end
        //  CMD8-response-6
        end else if(count==98) begin
            OutputData=8'hFF;
            if(InputData==8'hFF) begin
                count<=count+1;
            end
            
        //CMD58
        //  CMD58-1
        end else if(count==99) begin 
            SPI_CS=0;
            count<=count+1;
            OutputData={2'b01,6'b110111};
        //  CMD58-2
        end else if(count==100) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD58-3
        end else if(count==101) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD58-4
        end else if(count==102) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD58-5
        end else if(count==103) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD58-6-CRC
        end else if(count==104) begin 
            count<=count+1;
            OutputData={7'b1111111,1'b1};
        //  CMD58-response
        end else if(count==105) begin  
            OutputData=8'hFF;
            if(InputData==8'h01)begin
                count<=count+1;

            end

        //  ACMD41-1
        end else if(count==106) begin
            
            count<=count+1;
            OutputData={2'b01,6'b101001};
        //  ACMD41-2
        end else if(count==107) begin
            
            count<=count+1;
            OutputData=8'h40;
        //  ACMD41-3
        end else if(count==108) begin 
            count<=count+1;
            OutputData=8'h00;
        //  ACMD41-4
        end else if(count==109) begin 
            count<=count+1;
            OutputData=8'h00;
        //  ACMD41-5
        end else if(count==110) begin 
            count<=count+1;
            OutputData=8'h00;
        //  ACMD41-6
        end else if(count==111) begin 
            count<=count+1;
            OutputData={7'b1111111,1'b1};

        //  ACMD41-response-100ms initilitation

        end else if(count==112) begin  
            OutputData=8'hFF;
            if(InputData!=8'hFF)begin
                if(InputData==8'h00) begin
                    count<=count+1;
                end else begin
                    count<=99;
                end                 
            end
        //FirstVideoRead
        //  CMD17-1
        end else if(count==113) begin            
            count<=count+1;
            OutputData={2'b01,6'b010001};
            //OutputData=8'h51;
            //checkData=8'hFF; 
        //  CMD17-2
        end else if(count==114) begin
            count<=count+1;
            OutputData=8'h00;
        //  CMD17-3
        end else if(count==115) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD17-4
        end else if(count==116) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD17-5
        end else if(count==117) begin 
            count<=count+1;
            OutputData=8'h00;
        //  CMD17-6
        end else if(count==118) begin 
            count<=count+1;
            OutputData={7'b0000000,1'b1};
        //  CMD17-response
        end else if(count==119) begin 
            OutputData=8'hFF;
            if(InputData==8'h01)begin
                count<=count+1;
            end
        //  CMD17-DataReceive
        end else if(count==120) begin 
            OutputData=8'hFF;
            if(InputData==8'hFE)begin
                count<=count+1;
            end

        end else if(count==121)begin
            EnableVideoRead=1;            
            if(VideoCount<512)begin
                VideoCount=VideoCount+1;    
            end else if(VideoCount==512) begin
                EnableVideoRead=0;
            end else begin
                count<=count+1;                
            end 
        end else if(count==122)begin
                       
        
        //END
        end else if(count==2047) begin //Cuenta Final

        end else begin
            count<=count+1;
        end
    end

    //Logica Combinacional

    assign SPI_InputCLK=(count<1000)? SPI_InitClock : SPI_WorkClock;
    assign InputDataClock=~DataClock;
    


endmodule
