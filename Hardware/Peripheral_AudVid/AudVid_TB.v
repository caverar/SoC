// ============================================================================
// TESTBENCH FOR AudVid
// ============================================================================
`timescale 1ns / 1ps
module AudVid_TB();
  
  reg MasterCLK;


AudVid uut (
    .CLK(CLK)
);

  initial begin
    MasterCLK = 0;
 
  end

always begin 
    MasterCLK = #1 ~MasterCLK;      //5
    //I2SCLK = #100 ~I2SCLK;          //500
    //TFT_WorkCLK = #2 ~TFT_WorkCLK; //80
end


  initial begin: TEST_CASE
    $dumpfile("SoC.vcd");
    $dumpvars(-1, uut);
    #2400000000 $finish;
  end

endmodule
