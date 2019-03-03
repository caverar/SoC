module SPI (
    input  wire [15:0] data,
	input  wire        SPI_CLK,
    output wire        SPI_MOSI,
    output reg         dataClk,
    output reg         reset
	);
	//Declaracion de registros
  
    reg [3:0] count;
    reg reseted;


	//Valores iniciales
    initial begin reset=1; count=15;  dataClk=0; reseted=0; end
    //Instancias

	//Procedimiento Secuencial

    always@(negedge SPI_CLK)begin
        if(count == 15) begin
            dataClk<=1;
            reset<=1;
        end else if(count == 7) begin
            dataClk<=0;       
            reset<=(reseted) ? 1:0;
        end else if(count == 14) begin
            reseted<=1;        
        end 
        count<=count+1;
                   
        
    end

   
  
	//Asignacion Combinacional
    assign SPI_MOSI=data[15-count];

     
    

endmodule
  