/* Machine-generated using Migen */
module top(
	input user_led,
	input user_led_1,
	input user_led_2,
	input user_led_3,
	input user_led_4,
	input user_led_5,
	input user_led_6,
	input user_led_7,
	input user_led_8,
	input user_led_9,
	input user_led_10,
	input user_led_11,
	input user_led_12,
	input user_led_13,
	input user_led_14,
	input user_led_15,
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
	input Reset,
	output DAC_I2S_DATA,
	output DAC_I2S_CLK,
	output DAC_I2S_WS,
	output SD_SPI_CLK,
	output SD_SPI_MOSI,
	input SD_SPI_MISO,
	output SD_SPI_CS,
	output SD_SPI_COUNT_DEBUG,
	output SD_SPI_UTILCOUNT_DEBUG,
	output TFT_SPI_CLK,
	output TFT_SPI_MOSI,
	output TFT_RS,
	output TFT_RST,
	output TFT_SPI_CS,
	input clk100
);

wire SystemClock;
wire MasterCLK;
wire Reset_1;
wire I2SCLK;
wire DAC_I2S_CLK_1;
wire DAC_I2S_DATA_1;
wire DAC_I2S_WS_1;
wire TFT_SPI_MOSI_1;
wire TFT_SPI_CLK_1;
wire TFT_RS_1;
wire TFT_RST_1;
wire TFT_SPI_CS_1;
wire SD_SPI_MOSI_1;
wire SD_SPI_MISO_1;
wire SD_SPI_CLK_1;
wire SD_SPI_CS_1;
wire SD_SPI_COUNT_DEBUG_1;
wire SD_SPI_UTILCOUNT_DEBUG_1;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign Reset_1 = Reset;
assign SystemClock = sys_clk;
assign TFT_SPI_MOSI = TFT_SPI_MOSI_1;
assign TFT_SPI_CLK = TFT_SPI_CLK_1;
assign TFT_SPI_CS = TFT_SPI_CS_1;
assign TFT_RS = TFT_RS_1;
assign TFT_RST = TFT_RST_1;
assign SD_SPI_MOSI = SD_SPI_MOSI_1;
assign SD_SPI_CLK = SD_SPI_CLK_1;
assign SD_SPI_CS = SD_SPI_CS_1;
assign SD_SPI_MISO_1 = SD_SPI_MISO;
assign SD_SPI_COUNT_DEBUG = SD_SPI_COUNT_DEBUG_1;
assign SD_SPI_UTILCOUNT_DEBUG = SD_SPI_UTILCOUNT_DEBUG_1;
assign DAC_I2S_DATA = DAC_I2S_DATA_1;
assign DAC_I2S_WS = DAC_I2S_WS_1;
assign DAC_I2S_CLK = DAC_I2S_CLK_1;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

ClockManager ClockManager(
	.InputCLK(SystemClock),
	.I2SCLK(I2SCLK),
	.MasterCLK(MasterCLK)
);

AudVid AudVid(
	.I2SCLK(I2SCLK),
	.MasterCLK(MasterCLK),
	.Reset(Reset_1),
	.SD_SPI_MISO(SD_SPI_MISO_1),
	.DAC_I2S_CLK(DAC_I2S_CLK_1),
	.DAC_I2S_DATA(DAC_I2S_DATA_1),
	.DAC_I2S_WS(DAC_I2S_WS_1),
	.SD_SPI_CLK(SD_SPI_CLK_1),
	.SD_SPI_COUNT_DEBUG(SD_SPI_COUNT_DEBUG_1),
	.SD_SPI_CS(SD_SPI_CS_1),
	.SD_SPI_MOSI(SD_SPI_MOSI_1),
	.SD_SPI_UTILCOUNT_DEBUG(SD_SPI_UTILCOUNT_DEBUG_1),
	.TFT_RS(TFT_RS_1),
	.TFT_RST(TFT_RST_1),
	.TFT_SPI_CLK(TFT_SPI_CLK_1),
	.TFT_SPI_CS(TFT_SPI_CS_1),
	.TFT_SPI_MOSI(TFT_SPI_MOSI_1)
);

endmodule
