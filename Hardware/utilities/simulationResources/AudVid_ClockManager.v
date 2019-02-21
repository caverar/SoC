module AudVid_ClockManager(
    input  wire  InputCLK,
    output wire  MasterCLK,
    output wire  I2SCLK,
    output wire  TFTCLK,
    output wire  SDCLK   
    );

    assign MasterCLK=InputCLK;
    assign I2SCLK=InputCLK;
    assign TFTCLK=InputCLK;
    assign SDCLK=InputCLK;

endmodule


