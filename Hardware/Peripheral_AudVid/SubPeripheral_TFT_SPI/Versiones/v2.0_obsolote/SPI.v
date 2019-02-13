module SPI (
    input  wire [16:0] data,
	input  wire        SPI_CLK,
    input  wire        mode,        //0 init, 1 data 
    output wire        SPI_MOSI,
    output reg         SPI_CS,
    output reg         dataClk,
    output reg         reset
	);
	//Declaracion de registros
  
    reg [4:0] count;
    reg prevClk;
    reg [7:0] StarByte;
    reg preData;

	//Valores iniciales
    
    initial begin 
        reset=0; 
        count=23;  
        dataClk=0; 
        prevClk=0; 
        StarByte=8'b01110000; 
        preData=0; 
    end

    //Instancias

	//Procedimiento Secuencial

    always@(posedge SPI_CLK) begin

        if(mode) begin
            
            StarByte[1]=1;
            if(preData) begin

                if(count == 15) begin

                    count=0;
                    dataClk=1;

                end else if(count == 7) begin

                    dataClk=0;
                    count=count+1;    
                
                end else begin

                    count=count+1;
                    
                end

            end else begin

                if(count == 23) begin
                    
                    preData = 1;
                    count = 0;
                    dataClk=1;

                end else if(count == 12) begin

                    dataClk=0;
                    count=count+1;    
                
                end else begin

                    count=count+1;
                    
                end
              
            end

        end else begin

            if(count == 23) begin
                
                reset = 0;
                count = 0;
                dataClk = 1;
                

            end else if(count == 12) begin

                count = count+1;
                dataClk = 0;
                reset = (prevClk) ? 0:1;
                SPI_CS = (prevClk) ? 0:1;
            
            end else if(count == 22) begin
                
                count = count+1;
                prevClk = 1;
            
            end else if(count == 0) begin
                
                count = count+1;
                StarByte[1] = data[16];
                
            end else begin
                
                count=count+1;
            
            end
        end
    end
  
	//Asignacion Combinacional

    assign SPI_MOSI = (mode) ? ((preData)? data[count]:((count <  8) ? StarByte[count] : 
    data[count-8])) : ((count <  8) ? StarByte[count] : data[count-8]);


endmodule
  