module TFT_SPI(
	input  wire [15:0] data,
	input  wire        MasterCLK,
	output wire [16:0] OutputData,
	output wire        SPI_MOSI,
	output wire        SPI_CLK,
	output wire		   RS,
	output wire		   SPI_CS,
	output wire		   RST 
  	//output wire        bussy,
	);
	//Parametros
	parameter InitDataSize=90;
	parameter InitFrequency=200;
	parameter InitFrequencyBits=26;
	parameter WorkFrequency=2000;
	parameter WorkFrequencyBits=24;
	
	//Registros y Cables
	wire [6:0]  InitRegAddress;
	wire		dataClk;
	wire		selectedClock;
	wire [16:0] InitData;
	wire		SPI_InitRegClock;
	wire		SPI_WorkClock;
	wire		InitReg_RS;
	wire		mode;


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
	InitializationRegister initializationRegister(
    	.address(InitRegAddress),
    	.OutData(InitData),
		.RS(InitReg_RS)
    );
	//	Contador de Instrucciones de Iniciliazacion
	Counter #(.Begin(0), .bitsNumber(7), .End(InitDataSize), .mode(0)) counter(
		.clk(dataClk),
		.count(InitRegAddress)
	);
	//	SPI
	SPI spi (
    	.data(OutputData),
		.SPI_CLK(SPI_CLK),
    	.SPI_MOSI(SPI_MOSI),
		.SPI_CS(SPI_CS),
		.dataClk(dataClk),
		.reset(RST),
		.mode(mode)
	);

	//Asignacion Secuencial	 
	//Asignacion Combinacional

	//	Seleccion de reloj datos
	//assign selectedClock = (InitRegAddress<InitDataSize) ? InitRegClock : WorkClock;
	//	Seleccion de datos
	assign OutputData = (InitRegAddress<InitDataSize) ? InitData : data;
	//	Seleccion de reloj SPI
	assign SPI_CLK = (InitRegAddress<InitDataSize) ? SPI_InitRegClock : SPI_WorkClock;
	//	Gestion de pin RS
	assign RS = (InitRegAddress<InitDataSize) ? InitReg_RS : 1;
	//Inicializacion/DATA
	assign mode = (InitRegAddress<InitDataSize) ? 0 : 1;

endmodule
  


