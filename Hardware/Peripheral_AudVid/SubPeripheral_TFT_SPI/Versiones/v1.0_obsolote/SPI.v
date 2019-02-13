module SPI (
    input  wire [15:0] data,
	input  wire        SPI_CLK,
    output wire        SPI_MOSI,
    output wire        SPI_CS,
    output reg         dataClk,
    output reg         reset
	);
	//Declaracion de registros
  
    reg [4:0] count;
    reg prevClk;


	//Valores iniciales
    initial begin reset=0; count=16;  dataClk=0; prevClk=0; end
    //Instancias

	//Procedimiento Secuencial

    always@(posedge SPI_CLK)begin
        if(count == 16) begin

            count=0;
            dataClk=1;
            reset=0;

        end else if(count == 8) begin

            dataClk=0;
            count=count+1;         
            reset=(prevClk) ? 0:1;

        end else if(count == 15) begin 

            count=count+1;
            prevClk=1;
        
        end else begin

            count=count+1;
            
        end
    end
  
	//Asignacion Combinacional

    assign SPI_MOSI=data[count-1];
    assign SPI_CS=(count==0)? 1:0;

endmodule
  