
module ButtonDebouncer (
	input  wire clk,
	input  wire Input,
	output wire Output
	);
	
	wire VerificationClk;
	reg prevState;
	reg state;

	//Instancias

	FrequencyGenerator #(.frequency(50), .bitsNumber(21)) verificationCLk(
		.InputCLK(clk),
		.OutputCLK(VerificationClk)
	);
	
	//Valores iniciales
	initial begin prevState=0; state=0; end
	
	
	//Procedimiento Secuencial 
	always@(posedge VerificationClk)begin
		prevState=state;
		state=Input;
	end

	assign Output= state && !prevState;	


endmodule
  