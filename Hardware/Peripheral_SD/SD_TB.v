// ============================================================================
// TESTBENCH FOR SD_SPI
// ============================================================================
`timescale 1ns / 1ps
module SD_SPI_TB ();
  
    reg clk;
    SD uut(
        .MasterCLK(clk),    
        .Reset(0),
        .SPI_MISO(0),
        .OuputDataRegister(0)        
    );
    initial begin
        clk=0;

    end

    always clk = #1 ~clk;

    initial begin: TEST_CASE
        $dumpfile("SoC.vcd");
        $dumpvars(-1, uut);
        #800000 $finish;
    end

endmodule
