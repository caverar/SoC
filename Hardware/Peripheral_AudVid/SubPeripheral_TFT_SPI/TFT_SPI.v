module TFT_SPI(
	input  wire [15:0] data,
	input  wire        MasterCLK,
	output wire [15:0] OutputData,
	output wire        SPI_MOSI,
	output wire        SPI_CLK,
	output wire		   RS,
	output wire		   SPI_CS,
	output wire		   RST 
	//output wire      bussy,
	);
	//Parametros
	parameter InitDataSize=104;
	parameter InitFrequency=10000;
	parameter InitFrequencyBits=26;
	parameter WorkFrequency=5000000;
	parameter WorkFrequencyBits=24;	
	parameter delayUnit=InitFrequency/1000;
	//parameter delayUnit=1;
	parameter delayTime=160*delayUnit;
		
	//Registros y Cables
	reg  [15:0] data1; //
	wire [24:0] InitRegPointer;
	wire		dataClk;
	wire		selectedClock;
	wire [15:0] InitData;
	wire		SPI_InitRegClock;
	wire		SPI_WorkClock;
	wire		InitReg_RS;

	reg  [4:0]  countp;
	initial begin countp=0; end
	//Inicializacion
	//Instancias

	//	Reloj SPI de Inicializacion
	FrequencyGenerator #(.frequency(InitFrequency), .bitsNumber(InitFrequencyBits)) spiInitRegClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_InitRegClock)
	);

	//	Reloj SPI de Trabajo
	FrequencyGenerator #(.frequency(WorkFrequency), .bitsNumber(WorkFrequencyBits)) spiWorkClock(
		.InputCLK(MasterCLK),
		.OutputCLK(SPI_WorkClock)
	);

	//	Registro de Inicializacion
	InitializationRegister #(.InitFrequency(InitFrequency), .delayUnit(delayUnit)) initializationRegister(
		.pointer(InitRegPointer),
		.OutData(InitData),
		.RS(InitReg_RS),
		.CS(SPI_CS),
		.CLK(MasterCLK)			
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
		
	always@(posedge dataClk) begin			
		if(countp<11) begin
			data1=data;
			countp=countp+1;
		end else if(countp<22) begin
			countp=countp+1;
			data1=16'h0000;
		end else begin
			countp=1;
			data1=data;
		end
	end 
	//Asignacion Combinacional

	//	Seleccion de reloj datos
	//assign selectedClock = (InitRegPointer<InitDataSize) ? InitRegClock : WorkClock;
	//	Seleccion de datos
	assign OutputData = (InitRegPointer<InitDataSize+delayTime) ? InitData : data1;
	//	Seleccion de reloj SPI
	assign SPI_CLK = (InitRegPointer<InitDataSize+delayTime) ? SPI_InitRegClock : SPI_WorkClock;
	//	Gestion de pin RS
	assign RS = (InitRegPointer<InitDataSize+delayTime) ? InitReg_RS : 1;

endmodule
  


