/* Machine-generated using Migen */
module top(
	input user_sw,
	input user_sw_1,
	input user_sw_2,
	input user_sw_3,
	input user_sw_4,
	input user_sw_5,
	input user_sw_6,
	input user_sw_7,
	input user_sw_8,
	input user_sw_9,
	input user_sw_10,
	input user_sw_11,
	input user_sw_12,
	input user_sw_13,
	input user_sw_14,
	input user_sw_15,
	output SD_SPI_CS,
	output SD_SPI_CLK,
	output SD_SPI_MOSI,
	input SD_SPI_MISO,
	input cpu_reset,
	input clk100
);

wire CLK;
wire Reset;
wire SD_SPI_MISO_1;
wire SD_SPI_MOSI_1;
wire SD_SPI_CLK_1;
wire SD_SPI_CS_1;
reg EnableDataWriteRegister_storage = 1'd0;
reg [7:0] OuputDataRegister_storage = 8'd0;
wire SPI_EnableRegister_storage;
reg [7:0] InputDataRegisterCSR_status = 8'd0;
reg EnableDataReadRegisterCSR_status = 1'd0;
reg BussyDataWriteRegisterCSR_status = 1'd0;
wire [7:0] InputDataRegister;
wire EnableDataReadRegister;
wire BussyDataWriteRegister;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign InputDataRegister = InputDataRegisterCSR_status;
assign EnableDataReadRegister = EnableDataReadRegisterCSR_status;
assign BussyDataWriteRegister = BussyDataWriteRegisterCSR_status;
assign SD_SPI_CS = SD_SPI_CS_1;
assign SD_SPI_CLK = SD_SPI_CLK_1;
assign SD_SPI_MOSI = SD_SPI_MOSI_1;
assign SD_SPI_MISO_1 = SD_SPI_MISO;
assign CLK = sys_clk;
assign Reset = cpu_reset;
assign SPI_EnableRegister_storage = 1'd1;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

SD SD(
	.EnableDataWriteRegister(EnableDataWriteRegister_storage),
	.MasterCLK(CLK),
	.OuputDataRegister(OuputDataRegister_storage),
	.Reset(Reset),
	.SPI_EnableRegister(SPI_EnableRegister_storage),
	.SPI_MISO(SD_SPI_MISO_1),
	.BussyDataWriteRegister(BussyDataWriteRegister),
	.EnableDataReadRegister(EnableDataReadRegister),
	.InputDataRegister(InputDataRegister),
	.SPI_CLK(SD_SPI_CLK_1),
	.SPI_CS(SD_SPI_CS_1),
	.SPI_MOSI(SD_SPI_MOSI_1)
);

endmodule
