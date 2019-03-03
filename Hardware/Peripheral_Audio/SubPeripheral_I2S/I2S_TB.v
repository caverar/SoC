
// ============================================================================
// TESTBENCH FOR TFT_SPI
// ============================================================================
`timescale 1ns / 1ps
module I2S_TB ();
  reg         sys_clk_i;
  reg  [31:0] data;
  wire SyncCLK, I2S_DATA, I2S_CLK, I2S_WS;
  

  I2S uut (
    .MasterCLK(sys_clk_i),
    .InputData(data),
    .SyncCLK(SyncCLK),
    .I2S_DATA(I2S_DATA),
    .I2S_CLK(I2S_CLK),
    .I2S_WS(I2S_WS)
  );

  initial begin
    sys_clk_i   = 1;   
    #2500 data= 26;
    #2500 data= 19891;
    #2500 data= 40;   

  end

  always sys_clk_i = #5 ~sys_clk_i;


  initial begin: TEST_CASE
    $dumpfile("SoC.vcd");
    $dumpvars(-1, uut);
    #4000000 $finish;
  end

endmodule
