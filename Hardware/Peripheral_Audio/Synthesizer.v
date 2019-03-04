module Synthesizer(
    input  MasterCLK,
    input  Reset,
    input  DataClock,
    input  [23:0] InputData,  // 3 Notes al tiempo por cada canal
    output [31:0] OutputData

);


    wire signed [15:0] Notes [15:0]; //Empieza en A 440Hz
    //Osciladores
    Oscillator#(.limit(227)) A3(
        CLK(MasterCLK),
        data(Notes[0]) 
    );
    Oscillator#(.limit(215)) ASharp3(
        CLK(MasterCLK),
        data(Notes[1]) 
    );
    Oscillator#(.limit(202)) B3(
        CLK(MasterCLK),
        data(Notes[2]) 
    );
    Oscillator#(.limit(191)) C4(
        CLK(MasterCLK),
        data(Notes[3]) 
    );
    Oscillator#(.limit(180)) CSharp4(
        CLK(MasterCLK),
        data(Notes[4]) 
    );
    Oscillator#(.limit(170)) D4(
        CLK(MasterCLK),
        data(Notes[5]) 
    );
    Oscillator#(.limit(161)) DSharp4(
        CLK(MasterCLK),
        data(Notes[6]) 
    );
    Oscillator#(.limit(152)) E4(
        CLK(MasterCLK),
        data(Notes[7]) 
    );
    Oscillator#(.limit(143)) F4(
        CLK(MasterCLK),
        data(Notes[8]) 
    );
    Oscillator#(.limit(135)) FSharp4(
        CLK(MasterCLK),
        data(Notes[9]) 
    );
    Oscillator#(.limit(128)) G4(
        CLK(MasterCLK),
        data(Notes[10]) 
    );
    Oscillator#(.limit(120)) GSharp4(
        CLK(MasterCLK),
        data(Notes[11]) 
    );
    Oscillator#(.limit(114)) A4(
        CLK(MasterCLK),
        data(Notes[12]) 
    );
    Oscillator#(.limit(107)) ASharp4(
        CLK(MasterCLK),
        data(Notes[13]) 
    );
    Oscillator#(.limit(101)) B4(
        CLK(MasterCLK),
        data(Notes[14]) 
    );
    Oscillator#(.limit(96))  C5(
        CLK(MasterCLK),
        data(Notes[15]) 
    );
    //Control
    always@(posedge DataClock)begin
        OutputData[31:16] <=Notes[InputData[23:20]]+ Notes[InputData[19:16]] + Notes[InputData[15:12]];
        OutputData[15:0]  <=Notes[InputData[11:8]] + Notes[InputData[7:4]]   + Notes[InputData[3:0]];
    end

endmodule