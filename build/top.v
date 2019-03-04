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
	output I2S_DATA,
	output I2S_CLK,
	output I2S_WS,
	input clk100
);

reg CLK = 1'd0;
reg Reset = 1'd0;
wire DAC_I2S_CLK;
wire DAC_I2S_DATA;
wire DAC_I2S_WS;
reg [4:0] Track1ControlRegisterCSR_storage = 5'd0;
wire [4:0] Track1ControlRegister;
reg [4:0] Track2ControlRegisterCSR_storage = 5'd0;
wire [4:0] Track2ControlRegister;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign Track1ControlRegister = Track1ControlRegisterCSR_storage;
assign Track2ControlRegister = Track2ControlRegisterCSR_storage;
assign I2S_DATA = DAC_I2S_DATA;
assign I2S_CLK = DAC_I2S_CLK;
assign I2S_WS = DAC_I2S_WS;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

Audio Audio(
	.CLK(CLK),
	.Reset(Reset),
	.Track1ControlRegister(Track1ControlRegister),
	.Track2ControlRegister(Track2ControlRegister),
	.DAC_I2S_CLK(DAC_I2S_CLK),
	.DAC_I2S_DATA(DAC_I2S_DATA),
	.DAC_I2S_WS(DAC_I2S_WS)
);

endmodule
