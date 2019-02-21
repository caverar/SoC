module ButtonDebouncerTester(
	input  button,
	input  clk,
	output [1:0] led 
	);
	wire cable;
	reg state;
	ButtonDebouncer bouncer(
		.clk(clk),
		.Output(cable),
		.Input(button)
	);

	always@(posedge cable)begin
		state=!state;	  
	end
	assign led[0]=state;
	assign led[1]=!state;

endmodule