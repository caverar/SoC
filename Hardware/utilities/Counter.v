
module Counter #(parameter Begin=0, parameter bitsNumber=5, parameter End=31, parameter mode=1)(
	input  wire clk,
	input  wire reset,
	output reg  [bitsNumber-1:0] count
	);
	reg init;
	//Valores iniciales
	initial begin count=Begin; init=0; end

	//Procedimiento Secuencial 
	always@(posedge (clk || reset)) begin
		if (reset==1) begin
			count=Begin;
			init=0;
		end else if(init==0) begin
			count = Begin;
			init = 1;
		end else if(count==End) begin
			count=(mode) ? Begin : End;
		end else begin
			count=count+1;
		end 	
	end

endmodule
  