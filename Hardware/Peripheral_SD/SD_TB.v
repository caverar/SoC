// ============================================================================
// TESTBENCH FOR SD_SPI
// ============================================================================
`timescale 1ns / 1ps
module SD_SPI_TB ();
    reg clk;
    reg [7:0] OuputDataRegister;
    reg SPI_EnableRegister;
    SD uut(
        .MasterCLK(clk),    
        .Reset(1'b0),
        .SPI_MISO(1'b0),        
        .DataClockRegister(DataClockRegister), 
        .OuputDataRegister(OuputDataRegister),
        .SPI_EnableRegister(SPI_EnableRegister),
        .SPI_EnableCSRegister(1'b1)       
    );
    always@(negedge DataClockRegister)begin
        OuputDataRegister<=OuputDataRegister+1;
        SPI_EnableRegister<=1;   
    end
    initial begin
        clk=0;
        OuputDataRegister=0;
        SPI_EnableRegister=0;

    end

    always clk = #1 ~clk;

    initial begin: TEST_CASE
        $dumpfile("SoC.vcd");
        $dumpvars(-1, uut);
        #800000 $finish;
    end

endmodule
