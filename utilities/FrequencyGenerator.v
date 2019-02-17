module FrequencyGenerator #(

	parameter MasterFrequency=100000000,
	parameter frequency=100, 
	parameter bitsNumber=20)(
	input   wire InputCLK,
	output  wire OutputCLK
	);
	//Declaracion de registros
	parameter limit=(MasterFrequency/frequency);    //Valor maximo del contador
	reg [bitsNumber-1:0] counter;			   		//Registro del contador
	reg outputCLK;
	wire Buffered_OutputCLK;
	//Valores iniciales
	initial begin counter=0; outputCLK=0; end

	//Procedimiento Secuencial 
	always@(posedge InputCLK) begin
		if(counter<limit/2)begin
			counter<=counter+1;
			outputCLK<=0;
		end else if(counter<limit) begin
			counter<=counter+1;
			outputCLK<=1;
		end	else begin
			counter<=0;
			outputCLK<=1;
		end	
	end

	BUFG clkf_buf(
        .O (Buffered_OutputCLK),
        .I (outputCLK)
    );
	assign OutputCLK=Buffered_OutputCLK;
	//Asignacion Combinacional


endmodule
  
