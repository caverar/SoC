module TFT_SPI(
	input  wire [15:0] data,
	input  wire        MasterCLK, 
	input  wire        WorkCLK,   //6.25MHz
	output wire [15:0] OutputData,
	output wire        SPI_MOSI,
	output wire        SPI_CLK,
	output wire		   RS,
	output wire		   SPI_CS,
	output wire		   RST, 
	output wire        DataClock

	);
	//Parametros
	parameter InitDataSize=104;

	parameter WorkFrequency=6250000;
	parameter WorkFrequencyBits=24;	
	//parameter delayUnit=1; //
	parameter delayUnit=WorkFrequency/1000;	
	parameter delayTime=160*delayUnit;
		
	//Registros y Cables
	//reg  [15:0] data1; //
	wire [24:0] InitRegPointer;
	wire		dataClk;
	wire		selectedClock;
	wire [15:0] InitData;
	wire		SPI_InitRegClock;
	wire		SPI_WorkClock;
	wire		InitReg_RS;

	// reg  [4:0]  countp;
	// initial begin countp=0; end
	//Inicializacion
	//Instancias
	wire Buffered_MasterCLK;
	BUF inputBuffer(
        .O (Buffered_MasterCLK),
        .I (MasterCLK)
    );



	//	Reloj SPI 
	// FrequencyGenerator #(.frequency(WorkFrequency), .bitsNumber(WorkFrequencyBits)) spiWorkClock(
	// 	.InputCLK(Buffered_MasterCLK),
	// 	.OutputCLK(SPI_WorkClock)
	// );

	//	Registro de Inicializacion
	InitializationRegister #(.InitFrequency(WorkFrequency), .delayUnit(delayUnit)) initializationRegister(
		.pointer(InitRegPointer),
		.OutData(InitData),
		.RS(InitReg_RS),
		.CS(SPI_CS),
		.CLK(Buffered_MasterCLK)			
	);
		//	Contador de Instrucciones de Iniciliazacion
	Counter #(.Begin(0), .bitsNumber(25), .End(InitDataSize+delayTime), .mode(0)) counter(
		.clk(dataClk),
		.count(InitRegPointer)
	);
	//	SPI
	SPI spi (
		.data(OutputData),
		.SPI_CLK(SPI_CLK),
		.SPI_MOSI(SPI_MOSI),		
		.dataClk(dataClk)
		//.reset(RST)
	);

	//Asignacion Secuencial	
		
	// always@(posedge dataClk) begin			
	// 	if(countp<11) begin
	// 		data1=data;
	// 		countp=countp+1;
	// 	end else if(countp<22) begin
	// 		countp=countp+1;
	// 		data1=16'h0000;
	// 	end else begin
	// 		countp=1;
	// 		data1=data;
	// 	end
	// end 
	//Asignacion Combinacional


	//	Seleccion de datos
	assign OutputData = (InitRegPointer<InitDataSize+delayTime) ? InitData : data;
	//	Seleccion de reloj SPI
	assign SPI_CLK=WorkCLK;
	//	Gestion de pin RS
	assign RS = (InitRegPointer<InitDataSize+delayTime) ? InitReg_RS : 1;
	assign RST=1'b1;
	assign DataClock=(InitRegPointer<InitDataSize+delayTime) ? 0 :dataClk;


endmodule
  


