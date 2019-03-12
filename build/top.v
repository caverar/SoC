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
	input cpu_reset,
	input clk100
);

wire CLK;
wire Reset;
wire DAC_I2S_CLK;
wire DAC_I2S_DATA;
wire DAC_I2S_WS;
wire [3:0] AudioControlRegister_storage;
wire [15:0] SoundTrackInitializationRegister_storage;
wire InitializationEnableRegister_storage;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign I2S_DATA = DAC_I2S_DATA;
assign I2S_CLK = DAC_I2S_CLK;
assign I2S_WS = DAC_I2S_WS;
assign CLK = sys_clk;
assign Reset = cpu_reset;
assign AudioControlRegister_storage = 4'd8;
assign SoundTrackInitializationRegister_storage = 1'd0;
assign InitializationEnableRegister_storage = 1'd0;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

Audio Audio(
	.AudioControlRegister(AudioControlRegister_storage),
	.CLK(CLK),
	.InitializationEnableRegister(InitializationEnableRegister_storage),
	.Reset(Reset),
	.SoundTrackInitializationRegister(SoundTrackInitializationRegister_storage),
	.DAC_I2S_CLK(DAC_I2S_CLK),
	.DAC_I2S_DATA(DAC_I2S_DATA),
	.DAC_I2S_WS(DAC_I2S_WS)
);

endmodule
