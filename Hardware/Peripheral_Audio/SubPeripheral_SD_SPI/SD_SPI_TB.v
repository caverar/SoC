
// ============================================================================
// TESTBENCH FOR TFT_SPI
// ============================================================================
`timescale 1ns / 1ps
module SD_SPI_TB ();
  
  reg sys_clk_i;
  wire SPI_MOSI, SPI_CLK, SPI_CS; 
  wire [7:0] checkData;
  reg  SPI_MISO;
  reg reset;
  reg [15:0] InputAddress;

  SD_SPI uut (

    .MasterCLK(sys_clk_i),
    .Reset(reset),
    .SPI_MOSI(SPI_MOSI),
    .SPI_CLK(SPI_CLK),
    .SPI_MISO(SPI_MISO),
    .SPI_CS(SPI_CS),
    .InputAddress(InputAddress)
    //.checkData(checkData)
  );

  initial begin
    sys_clk_i   = 1;    
    SPI_MISO= 0;
    reset=0;
    InputAddress=16'h00;

    #1446750  SPI_MISO= 1;
    #2500     SPI_MISO= 0;
    #2500     SPI_MISO= 1;
    #2500     SPI_MISO= 0;
    #2500     SPI_MISO= 1;
    #2500     SPI_MISO= 0;
    #2500     SPI_MISO= 1;
    #2500     SPI_MISO= 0;
    #2500     SPI_MISO= 1;
    
    //CMD0  Response
    #401750   SPI_MISO= 0;
    #17500    SPI_MISO= 1;
    //CMD58 Response
    #142500   SPI_MISO= 0;
    #17500    SPI_MISO= 1;
    //ACMD1 Response
    #142500   SPI_MISO= 0;
    #20000    SPI_MISO= 1;

 
 
    //CMD58 Response
    // #142500   SPI_MISO= 0;
    // #17500    SPI_MISO= 1;
    // //ACMD1 Response
    // #142500   SPI_MISO= 0;
    // #20000    SPI_MISO= 1;
    // //END
    //#142500   SPI_MISO= 1;
  


    

  end

  always sys_clk_i = #5 ~sys_clk_i;


  initial begin: TEST_CASE
    $dumpfile("SoC.vcd");
    $dumpvars(-1, uut);
    #4000000 $finish;
  end

endmodule
