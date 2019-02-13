/* Machine-generated using Migen */
module top(
	output user_led,
	output user_led_1,
	output user_led_2,
	output user_led_3,
	output user_led_4,
	output user_led_5,
	output user_led_6,
	output user_led_7,
	output user_led_8,
	output user_led_9,
	output user_led_10,
	output user_led_11,
	output user_led_12,
	output user_led_13,
	output user_led_14,
	output user_led_15,
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
	input user_btn,
	input user_btn_1,
	input user_btn_2,
	input user_btn_3,
	input user_btn_4,
	output TFT_CLK,
	output TFT_MOSI,
	output TFT_RS,
	output TFT_RST,
	output TFT_CS,
	input clk100
);

reg [15:0] Leds = 16'd0;
wire [15:0] switches;
wire SystemClock;
wire TFT_MOSI_1;
wire TFT_CLK_1;
wire TFT_RS_1;
wire TFT_RST_1;
wire TFT_CS_1;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign {user_led_15, user_led_14, user_led_13, user_led_12, user_led_11, user_led_10, user_led_9, user_led_8, user_led_7, user_led_6, user_led_5, user_led_4, user_led_3, user_led_2, user_led_1, user_led} = Leds;
assign switches = {user_sw_15, user_sw_14, user_sw_13, user_sw_12, user_sw_11, user_sw_10, user_sw_9, user_sw_8, user_sw_7, user_sw_6, user_sw_5, user_sw_4, user_sw_3, user_sw_2, user_sw_1, user_sw};
assign SystemClock = sys_clk;
assign TFT_MOSI = TFT_MOSI_1;
assign TFT_CLK = TFT_CLK_1;
assign TFT_CS = TFT_CS_1;
assign TFT_RS = TFT_RS_1;
assign TFT_RST = TFT_RST_1;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

TFT_SPI TFT_SPI(
	.MasterCLK(SystemClock),
	.data(switches),
	.RS(TFT_RS_1),
	.RST(TFT_RST_1),
	.SPI_CLK(TFT_CLK_1),
	.SPI_CS(TFT_CS_1),
	.SPI_MOSI(TFT_MOSI_1)
);

endmodule
