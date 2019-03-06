module Synthesizer(
    input  wire MasterCLK,
    input  wire Reset,
    input  wire InputDataClock,
    input  wire [7:0] InputData,  // 3 Notes al tiempo por cada canal
    output reg  [31:0] OutputData,
    input  wire OutputDataClock

);

    
    wire signed [15:0] Notes [15:0]; //Empieza en A 440Hz
    assign Notes[0]=0;
    //Osciladores

    Oscillator#(.limit(227273)) A3(
        .CLK(MasterCLK),
        .data(Notes[1]) 
    );
    Oscillator#(.limit(214517)) ASharp3(
        .CLK(MasterCLK),
        .data(Notes[2]) 
    );
    Oscillator#(.limit(202477)) B3(
        .CLK(MasterCLK),
        .data(Notes[3]) 
    );
    Oscillator#(.limit(191113)) C4(
        .CLK(MasterCLK),
        .data(Notes[4]) 
    );
    Oscillator#(.limit(180387)) CSharp4(
        .CLK(MasterCLK),
        .data(Notes[5]) 
    );
    Oscillator#(.limit(170262)) D4(
        .CLK(MasterCLK),
        .data(Notes[6]) 
    );
    Oscillator#(.limit(160706)) DSharp4(
        .CLK(MasterCLK),
        .data(Notes[7]) 
    );
    Oscillator#(.limit(151686)) E4(
        .CLK(MasterCLK),
        .data(Notes[8]) 
    );
    Oscillator#(.limit(143173)) F4(
        .CLK(MasterCLK),
        .data(Notes[9]) 
    );
    Oscillator#(.limit(135137)) FSharp4(
        .CLK(MasterCLK),
        .data(Notes[10]) 
    );
    Oscillator#(.limit(127552)) G4(
        .CLK(MasterCLK),
        .data(Notes[11]) 
    );
    Oscillator#(.limit(120394)) GSharp4(
        .CLK(MasterCLK),
        .data(Notes[12]) 
    );
    Oscillator#(.limit(113636)) A4(
        .CLK(MasterCLK),
        .data(Notes[13]) 
    );
    Oscillator#(.limit(107258)) ASharp4(
        .CLK(MasterCLK),
        .data(Notes[14]) 
    );
    Oscillator#(.limit(101238)) B4(
        .CLK(MasterCLK),
        .data(Notes[15]) 
    );
    // Oscillator#(.limit(95556))  C5(
    //     .CLK(MasterCLK),
    //     .data(Notes[15]) 
    // );
    //Control
    always@(posedge OutputDataClock)begin
        OutputData[31:16] <= Notes[InputData[7:4]];
        OutputData[15:0]  <= Notes[InputData[3:0]];
    end

endmodule