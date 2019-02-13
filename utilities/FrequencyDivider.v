
module FrequencyDivider #(parameter divider=100, parameter bitsNumber=20)(
	input   wire InputCLK,
	output  reg  OutputCLK
	);
    reg [bitsNumber-1:0] count;
    
    //Inicializacion
    initial begin count=0; OutputCLK=0; end

    //Logica Secuencial
    always@(posedge InputCLK) begin
        if(count == divider-1) begin
            count = 0;
            OutputCLK = 1;
        end else if (count == divider/2) begin
            count = count+1;
            OutputCLK = 0;
        end else begin
            count = count+1;  
        end  
    end
    
endmodule