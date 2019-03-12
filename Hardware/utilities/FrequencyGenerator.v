module FrequencyGenerator #(

	parameter MasterFrequency=100000000,
	parameter frequency=100, 
	parameter bitsNumber=20)(
	input  wire InputCLK,
	output reg OutputCLK	
	);
	//Declaracion de registros
	localparam limit=(MasterFrequency/frequency);   //Valor maximo del contador
	reg [bitsNumber-1:0] counter;			   		//Registro del contador
	
	
	
	//Valores iniciales
	initial begin counter=0; OutputCLK=0; end 

	//Procedimiento Secuencial 
	always@(posedge InputCLK) begin
		if(counter<limit/2)begin
			counter<=counter+1;
			OutputCLK<=0;			
		end else if(counter<limit) begin
			counter<=counter+1;
			OutputCLK<=1;			
		end	else begin
			counter<=0;
			OutputCLK<=1;			
		end	
	end	


endmodule
  
