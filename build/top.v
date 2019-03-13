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

wire irq;
wire DataClock_status;
reg DataClock_pending = 1'd0;
wire DataClock_trigger;
reg DataClock_clear;
reg DataClock_old_trigger = 1'd0;
wire CLK;
wire Reset;
wire SD_SPI_MISO_1;
wire SD_SPI_MOSI_1;
wire SD_SPI_CLK_1;
wire SD_SPI_CS_1;
reg [7:0] OuputDataRegister_storage = 8'd0;
wire SPI_EnableRegister_storage;
wire [7:0] InputDataRegisterCSR_status;
wire DataClockRegisterCSR_status;
wire [7:0] InputDataRegister;
wire DataClockRegister;
wire xilinxvivadotoolchain_status_w;
reg xilinxvivadotoolchain_pending_re = 1'd0;
reg xilinxvivadotoolchain_pending_r = 1'd0;
wire xilinxvivadotoolchain_pending_w;
reg xilinxvivadotoolchain_storage = 1'd0;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg xilinxvivadotoolchain_int_rst = 1'd1;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign InputDataRegisterCSR_status = InputDataRegister;
assign DataClockRegisterCSR_status = DataClockRegister;
assign DataClock_trigger = DataClockRegister;
assign SD_SPI_CS = SD_SPI_CS_1;
assign SD_SPI_CLK = SD_SPI_CLK_1;
assign SD_SPI_MOSI = SD_SPI_MOSI_1;
assign SD_SPI_MISO_1 = SD_SPI_MISO;
assign CLK = sys_clk;
assign Reset = cpu_reset;
assign SPI_EnableRegister_storage = 1'd1;
assign xilinxvivadotoolchain_status_w = DataClock_status;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	DataClock_clear <= 1'd0;
	if ((xilinxvivadotoolchain_pending_re & xilinxvivadotoolchain_pending_r)) begin
		DataClock_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign xilinxvivadotoolchain_pending_w = DataClock_pending;
assign irq = (xilinxvivadotoolchain_pending_w & xilinxvivadotoolchain_storage);
assign DataClock_status = DataClock_trigger;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = xilinxvivadotoolchain_int_rst;

always @(posedge por_clk) begin
	xilinxvivadotoolchain_int_rst <= 1'd0;
end

always @(posedge sys_clk) begin
	if (DataClock_clear) begin
		DataClock_pending <= 1'd0;
	end
	DataClock_old_trigger <= DataClock_trigger;
	if (((~DataClock_trigger) & DataClock_old_trigger)) begin
		DataClock_pending <= 1'd1;
	end
	if (sys_rst) begin
		DataClock_pending <= 1'd0;
		DataClock_old_trigger <= 1'd0;
	end
end

SD SD(
	.MasterCLK(CLK),
	.OuputDataRegister(OuputDataRegister_storage),
	.Reset(Reset),
	.SPI_EnableRegister(SPI_EnableRegister_storage),
	.SPI_MISO(SD_SPI_MISO_1),
	.DataClockRegister(DataClockRegister),
	.InputDataRegister(InputDataRegister),
	.SPI_CLK(SD_SPI_CLK_1),
	.SPI_CS(SD_SPI_CS_1),
	.SPI_MOSI(SD_SPI_MOSI_1)
);

endmodule
