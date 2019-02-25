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
	output SD_SPI_CLK,
	output SD_SPI_MOSI,
	input SD_SPI_MISO,
	output SD_SPI_CS,
	input Reset,
	output SPI_COUNT_DEBUG,
	output SPI_UTILCOUNT_DEBUG,
	input clk100
);

reg [15:0] Leds = 16'd0;
wire SystemClock;
wire MasterCLK;
wire SD_SPI_MOSI_1;
wire SD_SPI_MISO_1;
wire SD_SPI_CLK_1;
wire SD_SPI_CS_1;
wire Reset_1;
reg SPI_COUNT_DEBUG_1 = 1'd0;
wire [15:0] SD_InputAddress;
reg SPI_UTILCOUNT_DEBUG_1 = 1'd0;
wire SD_WorkCLK;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign {user_led_15, user_led_14, user_led_13, user_led_12, user_led_11, user_led_10, user_led_9, user_led_8, user_led_7, user_led_6, user_led_5, user_led_4, user_led_3, user_led_2, user_led_1, user_led} = Leds;
assign SystemClock = sys_clk;
assign SD_SPI_MOSI = SD_SPI_MOSI_1;
assign SD_SPI_CLK = SD_SPI_CLK_1;
assign SD_SPI_CS = SD_SPI_CS_1;
assign SD_SPI_MISO_1 = SD_SPI_MISO;
assign Reset_1 = Reset;
assign SPI_COUNT_DEBUG = SPI_COUNT_DEBUG_1;
assign SD_InputAddress = {user_sw_15, user_sw_14, user_sw_13, user_sw_12, user_sw_11, user_sw_10, user_sw_9, user_sw_8, user_sw_7, user_sw_6, user_sw_5, user_sw_4, user_sw_3, user_sw_2, user_sw_1, user_sw};
assign SPI_UTILCOUNT_DEBUG = SPI_UTILCOUNT_DEBUG_1;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

AudVid_ClockManager AudVid_ClockManager(
	.InputCLK(SystemClock),
	.MasterCLK(MasterCLK),
	.SDCLK(SD_WorkCLK)
);

SD_SPI SD_SPI(
	.InputAddress(SD_InputAddress),
	.MasterCLK(MasterCLK),
	.SPI_MISO(SD_SPI_MISO_1),
	.WorkCLK(SD_WorkCLK),
	.SPI_CLK(SD_SPI_CLK_1),
	.SPI_CS(SD_SPI_CS_1),
	.SPI_MOSI(SD_SPI_MOSI_1)
);

endmodule
