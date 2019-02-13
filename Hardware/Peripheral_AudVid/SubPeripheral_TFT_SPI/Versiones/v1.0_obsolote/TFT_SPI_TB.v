
// ============================================================================
// TESTBENCH FOR TFT_SPI
// ============================================================================
`timescale 1ns / 1ps
module TFT_SPI_TB ();
  
  reg sys_clk_i, sys_rst_i;
  wire  uart_tx, ledout; 
  wire SPI_MOSI, SPI_CLK; 
  wire [15:0] OutputData;
  reg  [15:0] InputData;

  TFT_SPI uut (
    .data(InputData),
    .MasterCLK(sys_clk_i),
    .OutputData(OutputData),
    .SPI_MOSI(SPI_MOOSI),
    .SPI_CLK(SPI_CLK)
  );

  initial begin
    sys_clk_i   = 1;
    sys_rst_i = 1;
    InputData= 16'hffff;
    #10 sys_rst_i = 0;

  end

  always sys_clk_i = #1 ~sys_clk_i;


  initial begin: TEST_CASE
    $dumpfile("SoC.vcd");
    $dumpvars(-1, uut);
    #8000000 $finish;
  end

endmodule
