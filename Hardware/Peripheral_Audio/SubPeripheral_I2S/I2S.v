module I2S(
    input  wire         MasterCLK,
    input  wire         I2SCLK,
    input  wire [31:0]  InputData,
    output wire         SyncCLK,
    output wire         I2S_DATA,
    output              I2S_CLK,
    output reg          I2S_WS 
    );


    reg  [4:0]  count;
    reg  [31:0] Data;

    wire [31:0] SquareData;
    
    
    //Inicializacion
    initial begin
        count=0;
        Data =0;
    end
    //Instancias


    //  Generador de Pruebas
    SquareGenerator squaregenerator(
        .CLK(MasterCLK), ////////////////
        .data(SquareData)
    );
 


    //Logica Secuencial
    always@(negedge I2S_CLK) begin
        if(count==31)begin
            I2S_WS<=0;
        end else if(count==15) begin
            I2S_WS<=1;
        end
        count=count+1;  
    end
    always@(negedge I2S_WS)begin
        Data<=InputData;
        //Data=SquareData;  
    end
    
    //Logica Combinacional

    assign I2S_DATA=Data[31-count];
    assign SyncCLK=~I2S_WS;   
    assign I2S_CLK=I2SCLK;

endmodule
