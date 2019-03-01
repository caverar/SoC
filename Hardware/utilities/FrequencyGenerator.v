module FrequencyGenerator #(

	parameter MasterFrequency=100000000,
	parameter frequency=100, 
	parameter bitsNumber=20)(
	input   wire InputCLK,
	output  reg OutputCLK
	//output  wire OutputCLK_negedge
	);
	//Declaracion de registros
	localparam limit=(MasterFrequency/frequency);    //Valor maximo del contador
	reg [bitsNumber-1:0] counter;			   		//Registro del contador
	reg PosOutputCLK;
	//reg NegOutputCLK;
	
	//Valores iniciales
	initial begin counter=0; OutputCLK=0; end //NegOutputCLK=1; end

	//Procedimiento Secuencial 
	always@(posedge InputCLK) begin
		if(counter<limit/2)begin
			counter<=counter+1;
			OutputCLK<=0;
			//NegOutputCLK<=1;
		end else if(counter<limit) begin
			counter<=counter+1;
			OutputCLK<=1;
			//NegOutputCLK<=0;
		end	else begin
			counter<=0;
			OutputCLK<=1;
			//NegOutputCLK<=0;
		end	
	end
	
	//assign OutputCLK_posedge=(InputCLK)? PosOutputCLK : 0;
	//assign OutputCLK_negedge=(InputCLK)? NegOutputCLK : 0;
	
//	BUFGCE posedgeBuffer(
//        .O(OutputCLK_posedge),
//		.I(PosOutputCLK),
//        .CE(InputCLK)
//    );
//	BUFGCE negedgeBuffer(
//        .O(OutputCLK_negedge),
//		.I(NegOutputCLK),
//        .CE(InputCLK)
//    );
	
	//Asignacion Combinacional

endmodule
  
