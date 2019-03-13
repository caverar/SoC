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
	input external_buttons,
	input external_buttons_1,
	input external_buttons_2,
	input external_buttons_3,
	output DAC_I2S_DATA,
	output DAC_I2S_CLK,
	output DAC_I2S_WS,
	output TFT_SPI_CLK,
	output TFT_SPI_MOSI,
	output TFT_RS,
	output TFT_RST,
	output TFT_SPI_CS,
	output SD_SPI_CS,
	output SD_SPI_CLK,
	output SD_SPI_MOSI,
	input SD_SPI_MISO,
	output reg serial_tx,
	input serial_rx,
	input clk100,
	input cpu_reset
);

wire soc_ctrl_reset_reset_re;
wire soc_ctrl_reset_reset_r;
reg soc_ctrl_reset_reset_w = 1'd0;
reg [31:0] soc_ctrl_storage_full = 32'd305419896;
wire [31:0] soc_ctrl_storage;
reg soc_ctrl_re = 1'd0;
wire [31:0] soc_ctrl_bus_errors_status;
wire soc_ctrl_reset;
wire soc_ctrl_bus_error;
reg [31:0] soc_ctrl_bus_errors = 32'd0;
wire soc_lm32_reset;
wire [29:0] soc_lm32_ibus_adr;
wire [31:0] soc_lm32_ibus_dat_w;
wire [31:0] soc_lm32_ibus_dat_r;
wire [3:0] soc_lm32_ibus_sel;
wire soc_lm32_ibus_cyc;
wire soc_lm32_ibus_stb;
wire soc_lm32_ibus_ack;
wire soc_lm32_ibus_we;
wire [2:0] soc_lm32_ibus_cti;
wire [1:0] soc_lm32_ibus_bte;
wire soc_lm32_ibus_err;
wire [29:0] soc_lm32_dbus_adr;
wire [31:0] soc_lm32_dbus_dat_w;
wire [31:0] soc_lm32_dbus_dat_r;
wire [3:0] soc_lm32_dbus_sel;
wire soc_lm32_dbus_cyc;
wire soc_lm32_dbus_stb;
wire soc_lm32_dbus_ack;
wire soc_lm32_dbus_we;
wire [2:0] soc_lm32_dbus_cti;
wire [1:0] soc_lm32_dbus_bte;
wire soc_lm32_dbus_err;
reg [31:0] soc_lm32_interrupt;
wire [31:0] soc_lm32_i_adr_o;
wire [31:0] soc_lm32_d_adr_o;
wire [29:0] soc_rom_bus_adr;
wire [31:0] soc_rom_bus_dat_w;
wire [31:0] soc_rom_bus_dat_r;
wire [3:0] soc_rom_bus_sel;
wire soc_rom_bus_cyc;
wire soc_rom_bus_stb;
reg soc_rom_bus_ack = 1'd0;
wire soc_rom_bus_we;
wire [2:0] soc_rom_bus_cti;
wire [1:0] soc_rom_bus_bte;
reg soc_rom_bus_err = 1'd0;
wire [12:0] soc_rom_adr;
wire [31:0] soc_rom_dat_r;
wire [29:0] soc_sram_bus_adr;
wire [31:0] soc_sram_bus_dat_w;
wire [31:0] soc_sram_bus_dat_r;
wire [3:0] soc_sram_bus_sel;
wire soc_sram_bus_cyc;
wire soc_sram_bus_stb;
reg soc_sram_bus_ack = 1'd0;
wire soc_sram_bus_we;
wire [2:0] soc_sram_bus_cti;
wire [1:0] soc_sram_bus_bte;
reg soc_sram_bus_err = 1'd0;
wire [9:0] soc_sram_adr;
wire [31:0] soc_sram_dat_r;
reg [3:0] soc_sram_we;
wire [31:0] soc_sram_dat_w;
wire [29:0] soc_main_ram_bus_adr;
wire [31:0] soc_main_ram_bus_dat_w;
wire [31:0] soc_main_ram_bus_dat_r;
wire [3:0] soc_main_ram_bus_sel;
wire soc_main_ram_bus_cyc;
wire soc_main_ram_bus_stb;
reg soc_main_ram_bus_ack = 1'd0;
wire soc_main_ram_bus_we;
wire [2:0] soc_main_ram_bus_cti;
wire [1:0] soc_main_ram_bus_bte;
reg soc_main_ram_bus_err = 1'd0;
wire [11:0] soc_main_ram_adr;
wire [31:0] soc_main_ram_dat_r;
reg [3:0] soc_main_ram_we;
wire [31:0] soc_main_ram_dat_w;
reg [13:0] soc_interface_adr = 14'd0;
reg soc_interface_we = 1'd0;
reg [31:0] soc_interface_dat_w = 32'd0;
wire [31:0] soc_interface_dat_r;
wire [29:0] soc_bus_wishbone_adr;
wire [31:0] soc_bus_wishbone_dat_w;
reg [31:0] soc_bus_wishbone_dat_r = 32'd0;
wire [3:0] soc_bus_wishbone_sel;
wire soc_bus_wishbone_cyc;
wire soc_bus_wishbone_stb;
reg soc_bus_wishbone_ack = 1'd0;
wire soc_bus_wishbone_we;
wire [2:0] soc_bus_wishbone_cti;
wire [1:0] soc_bus_wishbone_bte;
reg soc_bus_wishbone_err = 1'd0;
reg [1:0] soc_counter = 2'd0;
reg [31:0] soc_uart_phy_storage_full = 32'd4947802;
wire [31:0] soc_uart_phy_storage;
reg soc_uart_phy_re = 1'd0;
wire soc_uart_phy_sink_valid;
reg soc_uart_phy_sink_ready = 1'd0;
wire soc_uart_phy_sink_first;
wire soc_uart_phy_sink_last;
wire [7:0] soc_uart_phy_sink_payload_data;
reg soc_uart_phy_uart_clk_txen = 1'd0;
reg [31:0] soc_uart_phy_phase_accumulator_tx = 32'd0;
reg [7:0] soc_uart_phy_tx_reg = 8'd0;
reg [3:0] soc_uart_phy_tx_bitcount = 4'd0;
reg soc_uart_phy_tx_busy = 1'd0;
reg soc_uart_phy_source_valid = 1'd0;
wire soc_uart_phy_source_ready;
reg soc_uart_phy_source_first = 1'd0;
reg soc_uart_phy_source_last = 1'd0;
reg [7:0] soc_uart_phy_source_payload_data = 8'd0;
reg soc_uart_phy_uart_clk_rxen = 1'd0;
reg [31:0] soc_uart_phy_phase_accumulator_rx = 32'd0;
wire soc_uart_phy_rx;
reg soc_uart_phy_rx_r = 1'd0;
reg [7:0] soc_uart_phy_rx_reg = 8'd0;
reg [3:0] soc_uart_phy_rx_bitcount = 4'd0;
reg soc_uart_phy_rx_busy = 1'd0;
wire soc_uart_rxtx_re;
wire [7:0] soc_uart_rxtx_r;
wire [7:0] soc_uart_rxtx_w;
wire soc_uart_txfull_status;
wire soc_uart_rxempty_status;
wire soc_uart_irq;
wire soc_uart_tx_status;
reg soc_uart_tx_pending = 1'd0;
wire soc_uart_tx_trigger;
reg soc_uart_tx_clear;
reg soc_uart_tx_old_trigger = 1'd0;
wire soc_uart_rx_status;
reg soc_uart_rx_pending = 1'd0;
wire soc_uart_rx_trigger;
reg soc_uart_rx_clear;
reg soc_uart_rx_old_trigger = 1'd0;
wire soc_uart_eventmanager_status_re;
wire [1:0] soc_uart_eventmanager_status_r;
reg [1:0] soc_uart_eventmanager_status_w;
wire soc_uart_eventmanager_pending_re;
wire [1:0] soc_uart_eventmanager_pending_r;
reg [1:0] soc_uart_eventmanager_pending_w;
reg [1:0] soc_uart_eventmanager_storage_full = 2'd0;
wire [1:0] soc_uart_eventmanager_storage;
reg soc_uart_eventmanager_re = 1'd0;
wire soc_uart_tx_fifo_sink_valid;
wire soc_uart_tx_fifo_sink_ready;
reg soc_uart_tx_fifo_sink_first = 1'd0;
reg soc_uart_tx_fifo_sink_last = 1'd0;
wire [7:0] soc_uart_tx_fifo_sink_payload_data;
wire soc_uart_tx_fifo_source_valid;
wire soc_uart_tx_fifo_source_ready;
wire soc_uart_tx_fifo_source_first;
wire soc_uart_tx_fifo_source_last;
wire [7:0] soc_uart_tx_fifo_source_payload_data;
wire soc_uart_tx_fifo_re;
reg soc_uart_tx_fifo_readable = 1'd0;
wire soc_uart_tx_fifo_syncfifo_we;
wire soc_uart_tx_fifo_syncfifo_writable;
wire soc_uart_tx_fifo_syncfifo_re;
wire soc_uart_tx_fifo_syncfifo_readable;
wire [9:0] soc_uart_tx_fifo_syncfifo_din;
wire [9:0] soc_uart_tx_fifo_syncfifo_dout;
reg [4:0] soc_uart_tx_fifo_level0 = 5'd0;
reg soc_uart_tx_fifo_replace = 1'd0;
reg [3:0] soc_uart_tx_fifo_produce = 4'd0;
reg [3:0] soc_uart_tx_fifo_consume = 4'd0;
reg [3:0] soc_uart_tx_fifo_wrport_adr;
wire [9:0] soc_uart_tx_fifo_wrport_dat_r;
wire soc_uart_tx_fifo_wrport_we;
wire [9:0] soc_uart_tx_fifo_wrport_dat_w;
wire soc_uart_tx_fifo_do_read;
wire [3:0] soc_uart_tx_fifo_rdport_adr;
wire [9:0] soc_uart_tx_fifo_rdport_dat_r;
wire soc_uart_tx_fifo_rdport_re;
wire [4:0] soc_uart_tx_fifo_level1;
wire [7:0] soc_uart_tx_fifo_fifo_in_payload_data;
wire soc_uart_tx_fifo_fifo_in_first;
wire soc_uart_tx_fifo_fifo_in_last;
wire [7:0] soc_uart_tx_fifo_fifo_out_payload_data;
wire soc_uart_tx_fifo_fifo_out_first;
wire soc_uart_tx_fifo_fifo_out_last;
wire soc_uart_rx_fifo_sink_valid;
wire soc_uart_rx_fifo_sink_ready;
wire soc_uart_rx_fifo_sink_first;
wire soc_uart_rx_fifo_sink_last;
wire [7:0] soc_uart_rx_fifo_sink_payload_data;
wire soc_uart_rx_fifo_source_valid;
wire soc_uart_rx_fifo_source_ready;
wire soc_uart_rx_fifo_source_first;
wire soc_uart_rx_fifo_source_last;
wire [7:0] soc_uart_rx_fifo_source_payload_data;
wire soc_uart_rx_fifo_re;
reg soc_uart_rx_fifo_readable = 1'd0;
wire soc_uart_rx_fifo_syncfifo_we;
wire soc_uart_rx_fifo_syncfifo_writable;
wire soc_uart_rx_fifo_syncfifo_re;
wire soc_uart_rx_fifo_syncfifo_readable;
wire [9:0] soc_uart_rx_fifo_syncfifo_din;
wire [9:0] soc_uart_rx_fifo_syncfifo_dout;
reg [4:0] soc_uart_rx_fifo_level0 = 5'd0;
reg soc_uart_rx_fifo_replace = 1'd0;
reg [3:0] soc_uart_rx_fifo_produce = 4'd0;
reg [3:0] soc_uart_rx_fifo_consume = 4'd0;
reg [3:0] soc_uart_rx_fifo_wrport_adr;
wire [9:0] soc_uart_rx_fifo_wrport_dat_r;
wire soc_uart_rx_fifo_wrport_we;
wire [9:0] soc_uart_rx_fifo_wrport_dat_w;
wire soc_uart_rx_fifo_do_read;
wire [3:0] soc_uart_rx_fifo_rdport_adr;
wire [9:0] soc_uart_rx_fifo_rdport_dat_r;
wire soc_uart_rx_fifo_rdport_re;
wire [4:0] soc_uart_rx_fifo_level1;
wire [7:0] soc_uart_rx_fifo_fifo_in_payload_data;
wire soc_uart_rx_fifo_fifo_in_first;
wire soc_uart_rx_fifo_fifo_in_last;
wire [7:0] soc_uart_rx_fifo_fifo_out_payload_data;
wire soc_uart_rx_fifo_fifo_out_first;
wire soc_uart_rx_fifo_fifo_out_last;
reg soc_uart_reset = 1'd0;
reg [31:0] soc_timer0_load_storage_full = 32'd0;
wire [31:0] soc_timer0_load_storage;
reg soc_timer0_load_re = 1'd0;
reg [31:0] soc_timer0_reload_storage_full = 32'd0;
wire [31:0] soc_timer0_reload_storage;
reg soc_timer0_reload_re = 1'd0;
reg soc_timer0_en_storage_full = 1'd0;
wire soc_timer0_en_storage;
reg soc_timer0_en_re = 1'd0;
wire soc_timer0_update_value_re;
wire soc_timer0_update_value_r;
reg soc_timer0_update_value_w = 1'd0;
reg [31:0] soc_timer0_value_status = 32'd0;
wire soc_timer0_irq;
wire soc_timer0_zero_status;
reg soc_timer0_zero_pending = 1'd0;
wire soc_timer0_zero_trigger;
reg soc_timer0_zero_clear;
reg soc_timer0_zero_old_trigger = 1'd0;
wire soc_timer0_eventmanager_status_re;
wire soc_timer0_eventmanager_status_r;
wire soc_timer0_eventmanager_status_w;
wire soc_timer0_eventmanager_pending_re;
wire soc_timer0_eventmanager_pending_r;
wire soc_timer0_eventmanager_pending_w;
reg soc_timer0_eventmanager_storage_full = 1'd0;
wire soc_timer0_eventmanager_storage;
reg soc_timer0_eventmanager_re = 1'd0;
reg [31:0] soc_timer0_value = 32'd0;
wire sys_clk;
wire sys_rst;
wire por_clk;
reg soc_int_rst = 1'd1;
wire soc_Video_WB_CLK;
wire soc_Video_WB_Reset;
wire soc_Video_WB_TFT_SPI_MOSI;
wire soc_Video_WB_TFT_SPI_CLK;
wire soc_Video_WB_TFT_RS;
wire soc_Video_WB_TFT_RST;
wire soc_Video_WB_TFT_SPI_CS;
reg [13:0] soc_Video_WB_storage_full = 14'd0;
wire [13:0] soc_Video_WB_storage;
reg soc_Video_WB_re = 1'd0;
wire [13:0] soc_Video_WB_TilesControlRegister;
wire soc_Audio_WB_CLK;
wire soc_Audio_WB_Reset;
wire soc_Audio_WB_DAC_I2S_CLK;
wire soc_Audio_WB_DAC_I2S_DATA;
wire soc_Audio_WB_DAC_I2S_WS;
reg [3:0] soc_Audio_WB_AudioControlRegister_storage_full = 4'd0;
wire [3:0] soc_Audio_WB_AudioControlRegister_storage;
reg soc_Audio_WB_AudioControlRegister_re = 1'd0;
reg [15:0] soc_Audio_WB_SoundTrackInitializationRegister_storage_full = 16'd0;
wire [15:0] soc_Audio_WB_SoundTrackInitializationRegister_storage;
reg soc_Audio_WB_SoundTrackInitializationRegister_re = 1'd0;
reg soc_Audio_WB_InitializationEnableRegister_storage_full = 1'd0;
wire soc_Audio_WB_InitializationEnableRegister_storage;
reg soc_Audio_WB_InitializationEnableRegister_re = 1'd0;
wire soc_Buttons_WB_irq;
wire soc_Buttons_WB_button1_status;
reg soc_Buttons_WB_button1_pending = 1'd0;
wire soc_Buttons_WB_button1_trigger;
reg soc_Buttons_WB_button1_clear;
wire soc_Buttons_WB_button2_status;
reg soc_Buttons_WB_button2_pending = 1'd0;
wire soc_Buttons_WB_button2_trigger;
reg soc_Buttons_WB_button2_clear;
wire soc_Buttons_WB_button3_status;
reg soc_Buttons_WB_button3_pending = 1'd0;
wire soc_Buttons_WB_button3_trigger;
reg soc_Buttons_WB_button3_clear;
wire soc_Buttons_WB_button4_status;
reg soc_Buttons_WB_button4_pending = 1'd0;
wire soc_Buttons_WB_button4_trigger;
reg soc_Buttons_WB_button4_clear;
wire soc_Buttons_WB_CLK;
wire [3:0] soc_Buttons_WB_Buttons;
reg [3:0] soc_Buttons_WB_DataRegister_status = 4'd0;
wire [3:0] soc_Buttons_WB_Data;
wire soc_Buttons_WB_Button1Interrupt;
wire soc_Buttons_WB_Button2Interrupt;
wire soc_Buttons_WB_Button3Interrupt;
wire soc_Buttons_WB_Button4Interrupt;
wire soc_SD_WB_irq;
wire soc_SD_WB_DataClock_status;
reg soc_SD_WB_DataClock_pending = 1'd0;
wire soc_SD_WB_DataClock_trigger;
reg soc_SD_WB_DataClock_clear;
reg soc_SD_WB_DataClock_old_trigger = 1'd0;
wire soc_SD_WB_CLK;
wire soc_SD_WB_Reset;
wire soc_SD_WB_SD_SPI_MISO;
wire soc_SD_WB_SD_SPI_MOSI;
wire soc_SD_WB_SD_SPI_CLK;
wire soc_SD_WB_SD_SPI_CS;
reg soc_SD_WB_EnableDataWriteRegister_storage_full = 1'd0;
wire soc_SD_WB_EnableDataWriteRegister_storage;
reg soc_SD_WB_EnableDataWriteRegister_re = 1'd0;
reg [7:0] soc_SD_WB_OuputDataRegister_storage_full = 8'd0;
wire [7:0] soc_SD_WB_OuputDataRegister_storage;
reg soc_SD_WB_OuputDataRegister_re = 1'd0;
reg soc_SD_WB_SPI_EnableRegister_storage_full = 1'd0;
wire soc_SD_WB_SPI_EnableRegister_storage;
reg soc_SD_WB_SPI_EnableRegister_re = 1'd0;
wire [7:0] soc_SD_WB_InputDataRegisterCSR_status;
wire soc_SD_WB_DataClockRegisterCSR_status;
wire [7:0] soc_SD_WB_InputDataRegister;
wire soc_SD_WB_DataClockRegister;
reg soc_Reset = 1'd0;
wire buttons_status_re;
wire [3:0] buttons_status_r;
reg [3:0] buttons_status_w;
wire buttons_pending_re;
wire [3:0] buttons_pending_r;
reg [3:0] buttons_pending_w;
reg [3:0] buttons_storage_full = 4'd0;
wire [3:0] buttons_storage;
reg buttons_re = 1'd0;
wire sd_status_re;
wire sd_status_r;
wire sd_status_w;
wire sd_pending_re;
wire sd_pending_r;
wire sd_pending_w;
reg sd_storage_full = 1'd0;
wire sd_storage;
reg sd_re = 1'd0;
wire [29:0] shared_adr;
wire [31:0] shared_dat_w;
reg [31:0] shared_dat_r;
wire [3:0] shared_sel;
wire shared_cyc;
wire shared_stb;
reg shared_ack;
wire shared_we;
wire [2:0] shared_cti;
wire [1:0] shared_bte;
wire shared_err;
wire [1:0] request;
reg grant = 1'd0;
reg [3:0] slave_sel;
reg [3:0] slave_sel_r = 4'd0;
reg error;
wire wait_1;
wire done;
reg [19:0] count = 20'd1000000;
wire [13:0] interface0_bank_bus_adr;
wire interface0_bank_bus_we;
wire [31:0] interface0_bank_bus_dat_w;
reg [31:0] interface0_bank_bus_dat_r = 32'd0;
wire csrbank0_AudioControlRegister0_re;
wire [3:0] csrbank0_AudioControlRegister0_r;
wire [3:0] csrbank0_AudioControlRegister0_w;
wire csrbank0_SoundTrackInitializationRegister0_re;
wire [15:0] csrbank0_SoundTrackInitializationRegister0_r;
wire [15:0] csrbank0_SoundTrackInitializationRegister0_w;
wire csrbank0_InitializationEnableRegister0_re;
wire csrbank0_InitializationEnableRegister0_r;
wire csrbank0_InitializationEnableRegister0_w;
wire csrbank0_sel;
wire [13:0] interface1_bank_bus_adr;
wire interface1_bank_bus_we;
wire [31:0] interface1_bank_bus_dat_w;
reg [31:0] interface1_bank_bus_dat_r = 32'd0;
wire csrbank1_DataRegister_re;
wire [3:0] csrbank1_DataRegister_r;
wire [3:0] csrbank1_DataRegister_w;
wire csrbank1_ev_enable0_re;
wire [3:0] csrbank1_ev_enable0_r;
wire [3:0] csrbank1_ev_enable0_w;
wire csrbank1_sel;
wire [13:0] interface2_bank_bus_adr;
wire interface2_bank_bus_we;
wire [31:0] interface2_bank_bus_dat_w;
reg [31:0] interface2_bank_bus_dat_r = 32'd0;
wire csrbank2_EnableDataWriteRegister0_re;
wire csrbank2_EnableDataWriteRegister0_r;
wire csrbank2_EnableDataWriteRegister0_w;
wire csrbank2_OuputDataRegister0_re;
wire [7:0] csrbank2_OuputDataRegister0_r;
wire [7:0] csrbank2_OuputDataRegister0_w;
wire csrbank2_SPI_EnableRegister0_re;
wire csrbank2_SPI_EnableRegister0_r;
wire csrbank2_SPI_EnableRegister0_w;
wire csrbank2_InputDataRegisterCSR_re;
wire [7:0] csrbank2_InputDataRegisterCSR_r;
wire [7:0] csrbank2_InputDataRegisterCSR_w;
wire csrbank2_DataClockRegisterCSR_re;
wire csrbank2_DataClockRegisterCSR_r;
wire csrbank2_DataClockRegisterCSR_w;
wire csrbank2_ev_enable0_re;
wire csrbank2_ev_enable0_r;
wire csrbank2_ev_enable0_w;
wire csrbank2_sel;
wire [13:0] interface3_bank_bus_adr;
wire interface3_bank_bus_we;
wire [31:0] interface3_bank_bus_dat_w;
reg [31:0] interface3_bank_bus_dat_r = 32'd0;
wire csrbank3_TilesControlRegisterCSR0_re;
wire [13:0] csrbank3_TilesControlRegisterCSR0_r;
wire [13:0] csrbank3_TilesControlRegisterCSR0_w;
wire csrbank3_sel;
wire [13:0] interface4_bank_bus_adr;
wire interface4_bank_bus_we;
wire [31:0] interface4_bank_bus_dat_w;
reg [31:0] interface4_bank_bus_dat_r = 32'd0;
wire csrbank4_scratch0_re;
wire [31:0] csrbank4_scratch0_r;
wire [31:0] csrbank4_scratch0_w;
wire csrbank4_bus_errors_re;
wire [31:0] csrbank4_bus_errors_r;
wire [31:0] csrbank4_bus_errors_w;
wire csrbank4_sel;
wire [13:0] sram_bus_adr;
wire sram_bus_we;
wire [31:0] sram_bus_dat_w;
reg [31:0] sram_bus_dat_r;
wire [5:0] adr;
wire [7:0] dat_r;
wire sel;
reg sel_r = 1'd0;
wire [13:0] interface5_bank_bus_adr;
wire interface5_bank_bus_we;
wire [31:0] interface5_bank_bus_dat_w;
reg [31:0] interface5_bank_bus_dat_r = 32'd0;
wire csrbank5_load0_re;
wire [31:0] csrbank5_load0_r;
wire [31:0] csrbank5_load0_w;
wire csrbank5_reload0_re;
wire [31:0] csrbank5_reload0_r;
wire [31:0] csrbank5_reload0_w;
wire csrbank5_en0_re;
wire csrbank5_en0_r;
wire csrbank5_en0_w;
wire csrbank5_value_re;
wire [31:0] csrbank5_value_r;
wire [31:0] csrbank5_value_w;
wire csrbank5_ev_enable0_re;
wire csrbank5_ev_enable0_r;
wire csrbank5_ev_enable0_w;
wire csrbank5_sel;
wire [13:0] interface6_bank_bus_adr;
wire interface6_bank_bus_we;
wire [31:0] interface6_bank_bus_dat_w;
reg [31:0] interface6_bank_bus_dat_r = 32'd0;
wire csrbank6_txfull_re;
wire csrbank6_txfull_r;
wire csrbank6_txfull_w;
wire csrbank6_rxempty_re;
wire csrbank6_rxempty_r;
wire csrbank6_rxempty_w;
wire csrbank6_ev_enable0_re;
wire [1:0] csrbank6_ev_enable0_r;
wire [1:0] csrbank6_ev_enable0_w;
wire csrbank6_sel;
wire [13:0] interface7_bank_bus_adr;
wire interface7_bank_bus_we;
wire [31:0] interface7_bank_bus_dat_w;
reg [31:0] interface7_bank_bus_dat_r = 32'd0;
wire csrbank7_tuning_word0_re;
wire [31:0] csrbank7_tuning_word0_r;
wire [31:0] csrbank7_tuning_word0_w;
wire csrbank7_sel;
reg [29:0] array_muxed0;
reg [31:0] array_muxed1;
reg [3:0] array_muxed2;
reg array_muxed3;
reg array_muxed4;
reg array_muxed5;
reg [2:0] array_muxed6;
reg [1:0] array_muxed7;
(* async_reg = "true", mr_ff = "true", dont_touch = "true" *) reg regs0 = 1'd0;
(* async_reg = "true", dont_touch = "true" *) reg regs1 = 1'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign soc_lm32_reset = soc_ctrl_reset;
assign soc_Buttons_WB_CLK = sys_clk;
assign soc_Buttons_WB_Buttons = {external_buttons_3, external_buttons_2, external_buttons_1, external_buttons};
assign soc_Video_WB_CLK = sys_clk;
assign soc_Video_WB_Reset = soc_Reset;
assign TFT_SPI_MOSI = soc_Video_WB_TFT_SPI_MOSI;
assign TFT_SPI_CLK = soc_Video_WB_TFT_SPI_CLK;
assign TFT_SPI_CS = soc_Video_WB_TFT_SPI_CS;
assign TFT_RS = soc_Video_WB_TFT_RS;
assign TFT_RST = soc_Video_WB_TFT_RST;
assign soc_Audio_WB_CLK = sys_clk;
assign soc_Audio_WB_Reset = soc_Reset;
assign DAC_I2S_DATA = soc_Audio_WB_DAC_I2S_DATA;
assign DAC_I2S_WS = soc_Audio_WB_DAC_I2S_WS;
assign DAC_I2S_CLK = soc_Audio_WB_DAC_I2S_CLK;
assign SD_SPI_CS = soc_SD_WB_SD_SPI_CS;
assign SD_SPI_CLK = soc_SD_WB_SD_SPI_CLK;
assign SD_SPI_MOSI = soc_SD_WB_SD_SPI_MOSI;
assign soc_SD_WB_SD_SPI_MISO = SD_SPI_MISO;
assign soc_SD_WB_CLK = sys_clk;
assign soc_SD_WB_Reset = soc_Reset;
assign soc_ctrl_bus_error = error;

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	soc_lm32_interrupt <= 32'd0;
	soc_lm32_interrupt[1] <= soc_timer0_irq;
	soc_lm32_interrupt[2] <= soc_uart_irq;
	soc_lm32_interrupt[7] <= soc_Buttons_WB_irq;
	soc_lm32_interrupt[8] <= soc_SD_WB_irq;
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end
assign soc_ctrl_reset = soc_ctrl_reset_reset_re;
assign soc_ctrl_bus_errors_status = soc_ctrl_bus_errors;
assign soc_lm32_ibus_adr = soc_lm32_i_adr_o[31:2];
assign soc_lm32_dbus_adr = soc_lm32_d_adr_o[31:2];
assign soc_rom_adr = soc_rom_bus_adr[12:0];
assign soc_rom_bus_dat_r = soc_rom_dat_r;

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	soc_sram_we <= 4'd0;
	soc_sram_we[0] <= (((soc_sram_bus_cyc & soc_sram_bus_stb) & soc_sram_bus_we) & soc_sram_bus_sel[0]);
	soc_sram_we[1] <= (((soc_sram_bus_cyc & soc_sram_bus_stb) & soc_sram_bus_we) & soc_sram_bus_sel[1]);
	soc_sram_we[2] <= (((soc_sram_bus_cyc & soc_sram_bus_stb) & soc_sram_bus_we) & soc_sram_bus_sel[2]);
	soc_sram_we[3] <= (((soc_sram_bus_cyc & soc_sram_bus_stb) & soc_sram_bus_we) & soc_sram_bus_sel[3]);
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign soc_sram_adr = soc_sram_bus_adr[9:0];
assign soc_sram_bus_dat_r = soc_sram_dat_r;
assign soc_sram_dat_w = soc_sram_bus_dat_w;

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	soc_main_ram_we <= 4'd0;
	soc_main_ram_we[0] <= (((soc_main_ram_bus_cyc & soc_main_ram_bus_stb) & soc_main_ram_bus_we) & soc_main_ram_bus_sel[0]);
	soc_main_ram_we[1] <= (((soc_main_ram_bus_cyc & soc_main_ram_bus_stb) & soc_main_ram_bus_we) & soc_main_ram_bus_sel[1]);
	soc_main_ram_we[2] <= (((soc_main_ram_bus_cyc & soc_main_ram_bus_stb) & soc_main_ram_bus_we) & soc_main_ram_bus_sel[2]);
	soc_main_ram_we[3] <= (((soc_main_ram_bus_cyc & soc_main_ram_bus_stb) & soc_main_ram_bus_we) & soc_main_ram_bus_sel[3]);
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end
assign soc_main_ram_adr = soc_main_ram_bus_adr[11:0];
assign soc_main_ram_bus_dat_r = soc_main_ram_dat_r;
assign soc_main_ram_dat_w = soc_main_ram_bus_dat_w;
assign soc_uart_tx_fifo_sink_valid = soc_uart_rxtx_re;
assign soc_uart_tx_fifo_sink_payload_data = soc_uart_rxtx_r;
assign soc_uart_txfull_status = (~soc_uart_tx_fifo_sink_ready);
assign soc_uart_phy_sink_valid = soc_uart_tx_fifo_source_valid;
assign soc_uart_tx_fifo_source_ready = soc_uart_phy_sink_ready;
assign soc_uart_phy_sink_first = soc_uart_tx_fifo_source_first;
assign soc_uart_phy_sink_last = soc_uart_tx_fifo_source_last;
assign soc_uart_phy_sink_payload_data = soc_uart_tx_fifo_source_payload_data;
assign soc_uart_tx_trigger = (~soc_uart_tx_fifo_sink_ready);
assign soc_uart_rx_fifo_sink_valid = soc_uart_phy_source_valid;
assign soc_uart_phy_source_ready = soc_uart_rx_fifo_sink_ready;
assign soc_uart_rx_fifo_sink_first = soc_uart_phy_source_first;
assign soc_uart_rx_fifo_sink_last = soc_uart_phy_source_last;
assign soc_uart_rx_fifo_sink_payload_data = soc_uart_phy_source_payload_data;
assign soc_uart_rxempty_status = (~soc_uart_rx_fifo_source_valid);
assign soc_uart_rxtx_w = soc_uart_rx_fifo_source_payload_data;
assign soc_uart_rx_fifo_source_ready = soc_uart_rx_clear;
assign soc_uart_rx_trigger = (~soc_uart_rx_fifo_source_valid);

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	soc_uart_tx_clear <= 1'd0;
	if ((soc_uart_eventmanager_pending_re & soc_uart_eventmanager_pending_r[0])) begin
		soc_uart_tx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	soc_uart_eventmanager_status_w <= 2'd0;
	soc_uart_eventmanager_status_w[0] <= soc_uart_tx_status;
	soc_uart_eventmanager_status_w[1] <= soc_uart_rx_status;
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	soc_uart_rx_clear <= 1'd0;
	if ((soc_uart_eventmanager_pending_re & soc_uart_eventmanager_pending_r[1])) begin
		soc_uart_rx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	soc_uart_eventmanager_pending_w <= 2'd0;
	soc_uart_eventmanager_pending_w[0] <= soc_uart_tx_pending;
	soc_uart_eventmanager_pending_w[1] <= soc_uart_rx_pending;
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end
assign soc_uart_irq = ((soc_uart_eventmanager_pending_w[0] & soc_uart_eventmanager_storage[0]) | (soc_uart_eventmanager_pending_w[1] & soc_uart_eventmanager_storage[1]));
assign soc_uart_tx_status = soc_uart_tx_trigger;
assign soc_uart_rx_status = soc_uart_rx_trigger;
assign soc_uart_tx_fifo_syncfifo_din = {soc_uart_tx_fifo_fifo_in_last, soc_uart_tx_fifo_fifo_in_first, soc_uart_tx_fifo_fifo_in_payload_data};
assign {soc_uart_tx_fifo_fifo_out_last, soc_uart_tx_fifo_fifo_out_first, soc_uart_tx_fifo_fifo_out_payload_data} = soc_uart_tx_fifo_syncfifo_dout;
assign soc_uart_tx_fifo_sink_ready = soc_uart_tx_fifo_syncfifo_writable;
assign soc_uart_tx_fifo_syncfifo_we = soc_uart_tx_fifo_sink_valid;
assign soc_uart_tx_fifo_fifo_in_first = soc_uart_tx_fifo_sink_first;
assign soc_uart_tx_fifo_fifo_in_last = soc_uart_tx_fifo_sink_last;
assign soc_uart_tx_fifo_fifo_in_payload_data = soc_uart_tx_fifo_sink_payload_data;
assign soc_uart_tx_fifo_source_valid = soc_uart_tx_fifo_readable;
assign soc_uart_tx_fifo_source_first = soc_uart_tx_fifo_fifo_out_first;
assign soc_uart_tx_fifo_source_last = soc_uart_tx_fifo_fifo_out_last;
assign soc_uart_tx_fifo_source_payload_data = soc_uart_tx_fifo_fifo_out_payload_data;
assign soc_uart_tx_fifo_re = soc_uart_tx_fifo_source_ready;
assign soc_uart_tx_fifo_syncfifo_re = (soc_uart_tx_fifo_syncfifo_readable & ((~soc_uart_tx_fifo_readable) | soc_uart_tx_fifo_re));
assign soc_uart_tx_fifo_level1 = (soc_uart_tx_fifo_level0 + soc_uart_tx_fifo_readable);

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	soc_uart_tx_fifo_wrport_adr <= 4'd0;
	if (soc_uart_tx_fifo_replace) begin
		soc_uart_tx_fifo_wrport_adr <= (soc_uart_tx_fifo_produce - 1'd1);
	end else begin
		soc_uart_tx_fifo_wrport_adr <= soc_uart_tx_fifo_produce;
	end
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign soc_uart_tx_fifo_wrport_dat_w = soc_uart_tx_fifo_syncfifo_din;
assign soc_uart_tx_fifo_wrport_we = (soc_uart_tx_fifo_syncfifo_we & (soc_uart_tx_fifo_syncfifo_writable | soc_uart_tx_fifo_replace));
assign soc_uart_tx_fifo_do_read = (soc_uart_tx_fifo_syncfifo_readable & soc_uart_tx_fifo_syncfifo_re);
assign soc_uart_tx_fifo_rdport_adr = soc_uart_tx_fifo_consume;
assign soc_uart_tx_fifo_syncfifo_dout = soc_uart_tx_fifo_rdport_dat_r;
assign soc_uart_tx_fifo_rdport_re = soc_uart_tx_fifo_do_read;
assign soc_uart_tx_fifo_syncfifo_writable = (soc_uart_tx_fifo_level0 != 5'd16);
assign soc_uart_tx_fifo_syncfifo_readable = (soc_uart_tx_fifo_level0 != 1'd0);
assign soc_uart_rx_fifo_syncfifo_din = {soc_uart_rx_fifo_fifo_in_last, soc_uart_rx_fifo_fifo_in_first, soc_uart_rx_fifo_fifo_in_payload_data};
assign {soc_uart_rx_fifo_fifo_out_last, soc_uart_rx_fifo_fifo_out_first, soc_uart_rx_fifo_fifo_out_payload_data} = soc_uart_rx_fifo_syncfifo_dout;
assign soc_uart_rx_fifo_sink_ready = soc_uart_rx_fifo_syncfifo_writable;
assign soc_uart_rx_fifo_syncfifo_we = soc_uart_rx_fifo_sink_valid;
assign soc_uart_rx_fifo_fifo_in_first = soc_uart_rx_fifo_sink_first;
assign soc_uart_rx_fifo_fifo_in_last = soc_uart_rx_fifo_sink_last;
assign soc_uart_rx_fifo_fifo_in_payload_data = soc_uart_rx_fifo_sink_payload_data;
assign soc_uart_rx_fifo_source_valid = soc_uart_rx_fifo_readable;
assign soc_uart_rx_fifo_source_first = soc_uart_rx_fifo_fifo_out_first;
assign soc_uart_rx_fifo_source_last = soc_uart_rx_fifo_fifo_out_last;
assign soc_uart_rx_fifo_source_payload_data = soc_uart_rx_fifo_fifo_out_payload_data;
assign soc_uart_rx_fifo_re = soc_uart_rx_fifo_source_ready;
assign soc_uart_rx_fifo_syncfifo_re = (soc_uart_rx_fifo_syncfifo_readable & ((~soc_uart_rx_fifo_readable) | soc_uart_rx_fifo_re));
assign soc_uart_rx_fifo_level1 = (soc_uart_rx_fifo_level0 + soc_uart_rx_fifo_readable);

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	soc_uart_rx_fifo_wrport_adr <= 4'd0;
	if (soc_uart_rx_fifo_replace) begin
		soc_uart_rx_fifo_wrport_adr <= (soc_uart_rx_fifo_produce - 1'd1);
	end else begin
		soc_uart_rx_fifo_wrport_adr <= soc_uart_rx_fifo_produce;
	end
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign soc_uart_rx_fifo_wrport_dat_w = soc_uart_rx_fifo_syncfifo_din;
assign soc_uart_rx_fifo_wrport_we = (soc_uart_rx_fifo_syncfifo_we & (soc_uart_rx_fifo_syncfifo_writable | soc_uart_rx_fifo_replace));
assign soc_uart_rx_fifo_do_read = (soc_uart_rx_fifo_syncfifo_readable & soc_uart_rx_fifo_syncfifo_re);
assign soc_uart_rx_fifo_rdport_adr = soc_uart_rx_fifo_consume;
assign soc_uart_rx_fifo_syncfifo_dout = soc_uart_rx_fifo_rdport_dat_r;
assign soc_uart_rx_fifo_rdport_re = soc_uart_rx_fifo_do_read;
assign soc_uart_rx_fifo_syncfifo_writable = (soc_uart_rx_fifo_level0 != 5'd16);
assign soc_uart_rx_fifo_syncfifo_readable = (soc_uart_rx_fifo_level0 != 1'd0);
assign soc_timer0_zero_trigger = (soc_timer0_value != 1'd0);
assign soc_timer0_eventmanager_status_w = soc_timer0_zero_status;

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	soc_timer0_zero_clear <= 1'd0;
	if ((soc_timer0_eventmanager_pending_re & soc_timer0_eventmanager_pending_r)) begin
		soc_timer0_zero_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign soc_timer0_eventmanager_pending_w = soc_timer0_zero_pending;
assign soc_timer0_irq = (soc_timer0_eventmanager_pending_w & soc_timer0_eventmanager_storage);
assign soc_timer0_zero_status = soc_timer0_zero_trigger;
assign sys_clk = clk100;
assign por_clk = clk100;
assign sys_rst = soc_int_rst;
assign soc_Video_WB_TilesControlRegister = soc_Video_WB_storage;
assign soc_Buttons_WB_Data = soc_Buttons_WB_DataRegister_status;
assign soc_Buttons_WB_button1_trigger = soc_Buttons_WB_Button1Interrupt;
assign soc_Buttons_WB_button2_trigger = soc_Buttons_WB_Button2Interrupt;
assign soc_Buttons_WB_button3_trigger = soc_Buttons_WB_Button3Interrupt;
assign soc_Buttons_WB_button4_trigger = soc_Buttons_WB_Button4Interrupt;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	soc_Buttons_WB_button1_clear <= 1'd0;
	if ((buttons_pending_re & buttons_pending_r[0])) begin
		soc_Buttons_WB_button1_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	soc_Buttons_WB_button2_clear <= 1'd0;
	if ((buttons_pending_re & buttons_pending_r[1])) begin
		soc_Buttons_WB_button2_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	soc_Buttons_WB_button3_clear <= 1'd0;
	if ((buttons_pending_re & buttons_pending_r[2])) begin
		soc_Buttons_WB_button3_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	buttons_status_w <= 4'd0;
	buttons_status_w[0] <= soc_Buttons_WB_button1_status;
	buttons_status_w[1] <= soc_Buttons_WB_button2_status;
	buttons_status_w[2] <= soc_Buttons_WB_button3_status;
	buttons_status_w[3] <= soc_Buttons_WB_button4_status;
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	soc_Buttons_WB_button4_clear <= 1'd0;
	if ((buttons_pending_re & buttons_pending_r[3])) begin
		soc_Buttons_WB_button4_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	buttons_pending_w <= 4'd0;
	buttons_pending_w[0] <= soc_Buttons_WB_button1_pending;
	buttons_pending_w[1] <= soc_Buttons_WB_button2_pending;
	buttons_pending_w[2] <= soc_Buttons_WB_button3_pending;
	buttons_pending_w[3] <= soc_Buttons_WB_button4_pending;
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign soc_Buttons_WB_irq = ((((buttons_pending_w[0] & buttons_storage[0]) | (buttons_pending_w[1] & buttons_storage[1])) | (buttons_pending_w[2] & buttons_storage[2])) | (buttons_pending_w[3] & buttons_storage[3]));
assign soc_Buttons_WB_button1_status = 1'd0;
assign soc_Buttons_WB_button2_status = 1'd0;
assign soc_Buttons_WB_button3_status = 1'd0;
assign soc_Buttons_WB_button4_status = 1'd0;
assign soc_SD_WB_InputDataRegisterCSR_status = soc_SD_WB_InputDataRegister;
assign soc_SD_WB_DataClockRegisterCSR_status = soc_SD_WB_DataClockRegister;
assign soc_SD_WB_DataClock_trigger = soc_SD_WB_DataClockRegister;
assign sd_status_w = soc_SD_WB_DataClock_status;

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	soc_SD_WB_DataClock_clear <= 1'd0;
	if ((sd_pending_re & sd_pending_r)) begin
		soc_SD_WB_DataClock_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end
assign sd_pending_w = soc_SD_WB_DataClock_pending;
assign soc_SD_WB_irq = (sd_pending_w & sd_storage);
assign soc_SD_WB_DataClock_status = soc_SD_WB_DataClock_trigger;
assign shared_adr = array_muxed0;
assign shared_dat_w = array_muxed1;
assign shared_sel = array_muxed2;
assign shared_cyc = array_muxed3;
assign shared_stb = array_muxed4;
assign shared_we = array_muxed5;
assign shared_cti = array_muxed6;
assign shared_bte = array_muxed7;
assign soc_lm32_ibus_dat_r = shared_dat_r;
assign soc_lm32_dbus_dat_r = shared_dat_r;
assign soc_lm32_ibus_ack = (shared_ack & (grant == 1'd0));
assign soc_lm32_dbus_ack = (shared_ack & (grant == 1'd1));
assign soc_lm32_ibus_err = (shared_err & (grant == 1'd0));
assign soc_lm32_dbus_err = (shared_err & (grant == 1'd1));
assign request = {soc_lm32_dbus_cyc, soc_lm32_ibus_cyc};

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	slave_sel <= 4'd0;
	slave_sel[0] <= (shared_adr[28:26] == 1'd0);
	slave_sel[1] <= (shared_adr[28:26] == 1'd1);
	slave_sel[2] <= (shared_adr[28:26] == 3'd4);
	slave_sel[3] <= (shared_adr[28:26] == 3'd6);
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end
assign soc_rom_bus_adr = shared_adr;
assign soc_rom_bus_dat_w = shared_dat_w;
assign soc_rom_bus_sel = shared_sel;
assign soc_rom_bus_stb = shared_stb;
assign soc_rom_bus_we = shared_we;
assign soc_rom_bus_cti = shared_cti;
assign soc_rom_bus_bte = shared_bte;
assign soc_sram_bus_adr = shared_adr;
assign soc_sram_bus_dat_w = shared_dat_w;
assign soc_sram_bus_sel = shared_sel;
assign soc_sram_bus_stb = shared_stb;
assign soc_sram_bus_we = shared_we;
assign soc_sram_bus_cti = shared_cti;
assign soc_sram_bus_bte = shared_bte;
assign soc_main_ram_bus_adr = shared_adr;
assign soc_main_ram_bus_dat_w = shared_dat_w;
assign soc_main_ram_bus_sel = shared_sel;
assign soc_main_ram_bus_stb = shared_stb;
assign soc_main_ram_bus_we = shared_we;
assign soc_main_ram_bus_cti = shared_cti;
assign soc_main_ram_bus_bte = shared_bte;
assign soc_bus_wishbone_adr = shared_adr;
assign soc_bus_wishbone_dat_w = shared_dat_w;
assign soc_bus_wishbone_sel = shared_sel;
assign soc_bus_wishbone_stb = shared_stb;
assign soc_bus_wishbone_we = shared_we;
assign soc_bus_wishbone_cti = shared_cti;
assign soc_bus_wishbone_bte = shared_bte;
assign soc_rom_bus_cyc = (shared_cyc & slave_sel[0]);
assign soc_sram_bus_cyc = (shared_cyc & slave_sel[1]);
assign soc_main_ram_bus_cyc = (shared_cyc & slave_sel[2]);
assign soc_bus_wishbone_cyc = (shared_cyc & slave_sel[3]);
assign shared_err = (((soc_rom_bus_err | soc_sram_bus_err) | soc_main_ram_bus_err) | soc_bus_wishbone_err);
assign wait_1 = ((shared_stb & shared_cyc) & (~shared_ack));

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	shared_dat_r <= 32'd0;
	shared_ack <= 1'd0;
	error <= 1'd0;
	shared_ack <= (((soc_rom_bus_ack | soc_sram_bus_ack) | soc_main_ram_bus_ack) | soc_bus_wishbone_ack);
	shared_dat_r <= (((({32{slave_sel_r[0]}} & soc_rom_bus_dat_r) | ({32{slave_sel_r[1]}} & soc_sram_bus_dat_r)) | ({32{slave_sel_r[2]}} & soc_main_ram_bus_dat_r)) | ({32{slave_sel_r[3]}} & soc_bus_wishbone_dat_r));
	if (done) begin
		shared_dat_r <= 32'd4294967295;
		shared_ack <= 1'd1;
		error <= 1'd1;
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign done = (count == 1'd0);
assign csrbank0_sel = (interface0_bank_bus_adr[13:9] == 4'd9);
assign csrbank0_AudioControlRegister0_r = interface0_bank_bus_dat_w[3:0];
assign csrbank0_AudioControlRegister0_re = ((csrbank0_sel & interface0_bank_bus_we) & (interface0_bank_bus_adr[1:0] == 1'd0));
assign csrbank0_SoundTrackInitializationRegister0_r = interface0_bank_bus_dat_w[15:0];
assign csrbank0_SoundTrackInitializationRegister0_re = ((csrbank0_sel & interface0_bank_bus_we) & (interface0_bank_bus_adr[1:0] == 1'd1));
assign csrbank0_InitializationEnableRegister0_r = interface0_bank_bus_dat_w[0];
assign csrbank0_InitializationEnableRegister0_re = ((csrbank0_sel & interface0_bank_bus_we) & (interface0_bank_bus_adr[1:0] == 2'd2));
assign soc_Audio_WB_AudioControlRegister_storage = soc_Audio_WB_AudioControlRegister_storage_full[3:0];
assign csrbank0_AudioControlRegister0_w = soc_Audio_WB_AudioControlRegister_storage_full[3:0];
assign soc_Audio_WB_SoundTrackInitializationRegister_storage = soc_Audio_WB_SoundTrackInitializationRegister_storage_full[15:0];
assign csrbank0_SoundTrackInitializationRegister0_w = soc_Audio_WB_SoundTrackInitializationRegister_storage_full[15:0];
assign soc_Audio_WB_InitializationEnableRegister_storage = soc_Audio_WB_InitializationEnableRegister_storage_full;
assign csrbank0_InitializationEnableRegister0_w = soc_Audio_WB_InitializationEnableRegister_storage_full;
assign csrbank1_sel = (interface1_bank_bus_adr[13:9] == 4'd10);
assign csrbank1_DataRegister_r = interface1_bank_bus_dat_w[3:0];
assign csrbank1_DataRegister_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 1'd0));
assign buttons_status_r = interface1_bank_bus_dat_w[3:0];
assign buttons_status_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 1'd1));
assign buttons_pending_r = interface1_bank_bus_dat_w[3:0];
assign buttons_pending_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 2'd2));
assign csrbank1_ev_enable0_r = interface1_bank_bus_dat_w[3:0];
assign csrbank1_ev_enable0_re = ((csrbank1_sel & interface1_bank_bus_we) & (interface1_bank_bus_adr[1:0] == 2'd3));
assign csrbank1_DataRegister_w = soc_Buttons_WB_DataRegister_status[3:0];
assign buttons_storage = buttons_storage_full[3:0];
assign csrbank1_ev_enable0_w = buttons_storage_full[3:0];
assign csrbank2_sel = (interface2_bank_bus_adr[13:9] == 4'd11);
assign csrbank2_EnableDataWriteRegister0_r = interface2_bank_bus_dat_w[0];
assign csrbank2_EnableDataWriteRegister0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 1'd0));
assign csrbank2_OuputDataRegister0_r = interface2_bank_bus_dat_w[7:0];
assign csrbank2_OuputDataRegister0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 1'd1));
assign csrbank2_SPI_EnableRegister0_r = interface2_bank_bus_dat_w[0];
assign csrbank2_SPI_EnableRegister0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 2'd2));
assign csrbank2_InputDataRegisterCSR_r = interface2_bank_bus_dat_w[7:0];
assign csrbank2_InputDataRegisterCSR_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 2'd3));
assign csrbank2_DataClockRegisterCSR_r = interface2_bank_bus_dat_w[0];
assign csrbank2_DataClockRegisterCSR_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 3'd4));
assign sd_status_r = interface2_bank_bus_dat_w[0];
assign sd_status_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 3'd5));
assign sd_pending_r = interface2_bank_bus_dat_w[0];
assign sd_pending_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 3'd6));
assign csrbank2_ev_enable0_r = interface2_bank_bus_dat_w[0];
assign csrbank2_ev_enable0_re = ((csrbank2_sel & interface2_bank_bus_we) & (interface2_bank_bus_adr[2:0] == 3'd7));
assign soc_SD_WB_EnableDataWriteRegister_storage = soc_SD_WB_EnableDataWriteRegister_storage_full;
assign csrbank2_EnableDataWriteRegister0_w = soc_SD_WB_EnableDataWriteRegister_storage_full;
assign soc_SD_WB_OuputDataRegister_storage = soc_SD_WB_OuputDataRegister_storage_full[7:0];
assign csrbank2_OuputDataRegister0_w = soc_SD_WB_OuputDataRegister_storage_full[7:0];
assign soc_SD_WB_SPI_EnableRegister_storage = soc_SD_WB_SPI_EnableRegister_storage_full;
assign csrbank2_SPI_EnableRegister0_w = soc_SD_WB_SPI_EnableRegister_storage_full;
assign csrbank2_InputDataRegisterCSR_w = soc_SD_WB_InputDataRegisterCSR_status[7:0];
assign csrbank2_DataClockRegisterCSR_w = soc_SD_WB_DataClockRegisterCSR_status;
assign sd_storage = sd_storage_full;
assign csrbank2_ev_enable0_w = sd_storage_full;
assign csrbank3_sel = (interface3_bank_bus_adr[13:9] == 4'd8);
assign csrbank3_TilesControlRegisterCSR0_r = interface3_bank_bus_dat_w[13:0];
assign csrbank3_TilesControlRegisterCSR0_re = ((csrbank3_sel & interface3_bank_bus_we) & (interface3_bank_bus_adr[0] == 1'd0));
assign soc_Video_WB_storage = soc_Video_WB_storage_full[13:0];
assign csrbank3_TilesControlRegisterCSR0_w = soc_Video_WB_storage_full[13:0];
assign csrbank4_sel = (interface4_bank_bus_adr[13:9] == 1'd0);
assign soc_ctrl_reset_reset_r = interface4_bank_bus_dat_w[0];
assign soc_ctrl_reset_reset_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 1'd0));
assign csrbank4_scratch0_r = interface4_bank_bus_dat_w[31:0];
assign csrbank4_scratch0_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 1'd1));
assign csrbank4_bus_errors_r = interface4_bank_bus_dat_w[31:0];
assign csrbank4_bus_errors_re = ((csrbank4_sel & interface4_bank_bus_we) & (interface4_bank_bus_adr[1:0] == 2'd2));
assign soc_ctrl_storage = soc_ctrl_storage_full[31:0];
assign csrbank4_scratch0_w = soc_ctrl_storage_full[31:0];
assign csrbank4_bus_errors_w = soc_ctrl_bus_errors_status[31:0];
assign sel = (sram_bus_adr[13:9] == 3'd4);

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	sram_bus_dat_r <= 32'd0;
	if (sel_r) begin
		sram_bus_dat_r <= dat_r;
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign adr = sram_bus_adr[5:0];
assign csrbank5_sel = (interface5_bank_bus_adr[13:9] == 3'd5);
assign csrbank5_load0_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_load0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 1'd0));
assign csrbank5_reload0_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_reload0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 1'd1));
assign csrbank5_en0_r = interface5_bank_bus_dat_w[0];
assign csrbank5_en0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 2'd2));
assign soc_timer0_update_value_r = interface5_bank_bus_dat_w[0];
assign soc_timer0_update_value_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 2'd3));
assign csrbank5_value_r = interface5_bank_bus_dat_w[31:0];
assign csrbank5_value_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd4));
assign soc_timer0_eventmanager_status_r = interface5_bank_bus_dat_w[0];
assign soc_timer0_eventmanager_status_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd5));
assign soc_timer0_eventmanager_pending_r = interface5_bank_bus_dat_w[0];
assign soc_timer0_eventmanager_pending_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd6));
assign csrbank5_ev_enable0_r = interface5_bank_bus_dat_w[0];
assign csrbank5_ev_enable0_re = ((csrbank5_sel & interface5_bank_bus_we) & (interface5_bank_bus_adr[2:0] == 3'd7));
assign soc_timer0_load_storage = soc_timer0_load_storage_full[31:0];
assign csrbank5_load0_w = soc_timer0_load_storage_full[31:0];
assign soc_timer0_reload_storage = soc_timer0_reload_storage_full[31:0];
assign csrbank5_reload0_w = soc_timer0_reload_storage_full[31:0];
assign soc_timer0_en_storage = soc_timer0_en_storage_full;
assign csrbank5_en0_w = soc_timer0_en_storage_full;
assign csrbank5_value_w = soc_timer0_value_status[31:0];
assign soc_timer0_eventmanager_storage = soc_timer0_eventmanager_storage_full;
assign csrbank5_ev_enable0_w = soc_timer0_eventmanager_storage_full;
assign csrbank6_sel = (interface6_bank_bus_adr[13:9] == 2'd3);
assign soc_uart_rxtx_r = interface6_bank_bus_dat_w[7:0];
assign soc_uart_rxtx_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 1'd0));
assign csrbank6_txfull_r = interface6_bank_bus_dat_w[0];
assign csrbank6_txfull_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 1'd1));
assign csrbank6_rxempty_r = interface6_bank_bus_dat_w[0];
assign csrbank6_rxempty_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 2'd2));
assign soc_uart_eventmanager_status_r = interface6_bank_bus_dat_w[1:0];
assign soc_uart_eventmanager_status_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 2'd3));
assign soc_uart_eventmanager_pending_r = interface6_bank_bus_dat_w[1:0];
assign soc_uart_eventmanager_pending_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 3'd4));
assign csrbank6_ev_enable0_r = interface6_bank_bus_dat_w[1:0];
assign csrbank6_ev_enable0_re = ((csrbank6_sel & interface6_bank_bus_we) & (interface6_bank_bus_adr[2:0] == 3'd5));
assign csrbank6_txfull_w = soc_uart_txfull_status;
assign csrbank6_rxempty_w = soc_uart_rxempty_status;
assign soc_uart_eventmanager_storage = soc_uart_eventmanager_storage_full[1:0];
assign csrbank6_ev_enable0_w = soc_uart_eventmanager_storage_full[1:0];
assign csrbank7_sel = (interface7_bank_bus_adr[13:9] == 2'd2);
assign csrbank7_tuning_word0_r = interface7_bank_bus_dat_w[31:0];
assign csrbank7_tuning_word0_re = ((csrbank7_sel & interface7_bank_bus_we) & (interface7_bank_bus_adr[0] == 1'd0));
assign soc_uart_phy_storage = soc_uart_phy_storage_full[31:0];
assign csrbank7_tuning_word0_w = soc_uart_phy_storage_full[31:0];
assign interface0_bank_bus_adr = soc_interface_adr;
assign interface1_bank_bus_adr = soc_interface_adr;
assign interface2_bank_bus_adr = soc_interface_adr;
assign interface3_bank_bus_adr = soc_interface_adr;
assign interface4_bank_bus_adr = soc_interface_adr;
assign interface5_bank_bus_adr = soc_interface_adr;
assign interface6_bank_bus_adr = soc_interface_adr;
assign interface7_bank_bus_adr = soc_interface_adr;
assign sram_bus_adr = soc_interface_adr;
assign interface0_bank_bus_we = soc_interface_we;
assign interface1_bank_bus_we = soc_interface_we;
assign interface2_bank_bus_we = soc_interface_we;
assign interface3_bank_bus_we = soc_interface_we;
assign interface4_bank_bus_we = soc_interface_we;
assign interface5_bank_bus_we = soc_interface_we;
assign interface6_bank_bus_we = soc_interface_we;
assign interface7_bank_bus_we = soc_interface_we;
assign sram_bus_we = soc_interface_we;
assign interface0_bank_bus_dat_w = soc_interface_dat_w;
assign interface1_bank_bus_dat_w = soc_interface_dat_w;
assign interface2_bank_bus_dat_w = soc_interface_dat_w;
assign interface3_bank_bus_dat_w = soc_interface_dat_w;
assign interface4_bank_bus_dat_w = soc_interface_dat_w;
assign interface5_bank_bus_dat_w = soc_interface_dat_w;
assign interface6_bank_bus_dat_w = soc_interface_dat_w;
assign interface7_bank_bus_dat_w = soc_interface_dat_w;
assign sram_bus_dat_w = soc_interface_dat_w;
assign soc_interface_dat_r = ((((((((interface0_bank_bus_dat_r | interface1_bank_bus_dat_r) | interface2_bank_bus_dat_r) | interface3_bank_bus_dat_r) | interface4_bank_bus_dat_r) | interface5_bank_bus_dat_r) | interface6_bank_bus_dat_r) | interface7_bank_bus_dat_r) | sram_bus_dat_r);

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 30'd0;
	case (grant)
		1'd0: begin
			array_muxed0 <= soc_lm32_ibus_adr;
		end
		default: begin
			array_muxed0 <= soc_lm32_dbus_adr;
		end
	endcase
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 32'd0;
	case (grant)
		1'd0: begin
			array_muxed1 <= soc_lm32_ibus_dat_w;
		end
		default: begin
			array_muxed1 <= soc_lm32_dbus_dat_w;
		end
	endcase
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 4'd0;
	case (grant)
		1'd0: begin
			array_muxed2 <= soc_lm32_ibus_sel;
		end
		default: begin
			array_muxed2 <= soc_lm32_dbus_sel;
		end
	endcase
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed3 <= soc_lm32_ibus_cyc;
		end
		default: begin
			array_muxed3 <= soc_lm32_dbus_cyc;
		end
	endcase
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed4 <= soc_lm32_ibus_stb;
		end
		default: begin
			array_muxed4 <= soc_lm32_dbus_stb;
		end
	endcase
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	array_muxed5 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed5 <= soc_lm32_ibus_we;
		end
		default: begin
			array_muxed5 <= soc_lm32_dbus_we;
		end
	endcase
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	array_muxed6 <= 3'd0;
	case (grant)
		1'd0: begin
			array_muxed6 <= soc_lm32_ibus_cti;
		end
		default: begin
			array_muxed6 <= soc_lm32_dbus_cti;
		end
	endcase
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	array_muxed7 <= 2'd0;
	case (grant)
		1'd0: begin
			array_muxed7 <= soc_lm32_ibus_bte;
		end
		default: begin
			array_muxed7 <= soc_lm32_dbus_bte;
		end
	endcase
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end
assign soc_uart_phy_rx = regs1;

always @(posedge por_clk) begin
	soc_int_rst <= cpu_reset;
end

always @(posedge sys_clk) begin
	if ((soc_ctrl_bus_errors != 32'd4294967295)) begin
		if (soc_ctrl_bus_error) begin
			soc_ctrl_bus_errors <= (soc_ctrl_bus_errors + 1'd1);
		end
	end
	soc_rom_bus_ack <= 1'd0;
	if (((soc_rom_bus_cyc & soc_rom_bus_stb) & (~soc_rom_bus_ack))) begin
		soc_rom_bus_ack <= 1'd1;
	end
	soc_sram_bus_ack <= 1'd0;
	if (((soc_sram_bus_cyc & soc_sram_bus_stb) & (~soc_sram_bus_ack))) begin
		soc_sram_bus_ack <= 1'd1;
	end
	soc_main_ram_bus_ack <= 1'd0;
	if (((soc_main_ram_bus_cyc & soc_main_ram_bus_stb) & (~soc_main_ram_bus_ack))) begin
		soc_main_ram_bus_ack <= 1'd1;
	end
	soc_interface_we <= 1'd0;
	soc_interface_dat_w <= soc_bus_wishbone_dat_w;
	soc_interface_adr <= soc_bus_wishbone_adr;
	soc_bus_wishbone_dat_r <= soc_interface_dat_r;
	if ((soc_counter == 1'd1)) begin
		soc_interface_we <= soc_bus_wishbone_we;
	end
	if ((soc_counter == 2'd2)) begin
		soc_bus_wishbone_ack <= 1'd1;
	end
	if ((soc_counter == 2'd3)) begin
		soc_bus_wishbone_ack <= 1'd0;
	end
	if ((soc_counter != 1'd0)) begin
		soc_counter <= (soc_counter + 1'd1);
	end else begin
		if ((soc_bus_wishbone_cyc & soc_bus_wishbone_stb)) begin
			soc_counter <= 1'd1;
		end
	end
	soc_uart_phy_sink_ready <= 1'd0;
	if (((soc_uart_phy_sink_valid & (~soc_uart_phy_tx_busy)) & (~soc_uart_phy_sink_ready))) begin
		soc_uart_phy_tx_reg <= soc_uart_phy_sink_payload_data;
		soc_uart_phy_tx_bitcount <= 1'd0;
		soc_uart_phy_tx_busy <= 1'd1;
		serial_tx <= 1'd0;
	end else begin
		if ((soc_uart_phy_uart_clk_txen & soc_uart_phy_tx_busy)) begin
			soc_uart_phy_tx_bitcount <= (soc_uart_phy_tx_bitcount + 1'd1);
			if ((soc_uart_phy_tx_bitcount == 4'd8)) begin
				serial_tx <= 1'd1;
			end else begin
				if ((soc_uart_phy_tx_bitcount == 4'd9)) begin
					serial_tx <= 1'd1;
					soc_uart_phy_tx_busy <= 1'd0;
					soc_uart_phy_sink_ready <= 1'd1;
				end else begin
					serial_tx <= soc_uart_phy_tx_reg[0];
					soc_uart_phy_tx_reg <= {1'd0, soc_uart_phy_tx_reg[7:1]};
				end
			end
		end
	end
	if (soc_uart_phy_tx_busy) begin
		{soc_uart_phy_uart_clk_txen, soc_uart_phy_phase_accumulator_tx} <= (soc_uart_phy_phase_accumulator_tx + soc_uart_phy_storage);
	end else begin
		{soc_uart_phy_uart_clk_txen, soc_uart_phy_phase_accumulator_tx} <= 1'd0;
	end
	soc_uart_phy_source_valid <= 1'd0;
	soc_uart_phy_rx_r <= soc_uart_phy_rx;
	if ((~soc_uart_phy_rx_busy)) begin
		if (((~soc_uart_phy_rx) & soc_uart_phy_rx_r)) begin
			soc_uart_phy_rx_busy <= 1'd1;
			soc_uart_phy_rx_bitcount <= 1'd0;
		end
	end else begin
		if (soc_uart_phy_uart_clk_rxen) begin
			soc_uart_phy_rx_bitcount <= (soc_uart_phy_rx_bitcount + 1'd1);
			if ((soc_uart_phy_rx_bitcount == 1'd0)) begin
				if (soc_uart_phy_rx) begin
					soc_uart_phy_rx_busy <= 1'd0;
				end
			end else begin
				if ((soc_uart_phy_rx_bitcount == 4'd9)) begin
					soc_uart_phy_rx_busy <= 1'd0;
					if (soc_uart_phy_rx) begin
						soc_uart_phy_source_payload_data <= soc_uart_phy_rx_reg;
						soc_uart_phy_source_valid <= 1'd1;
					end
				end else begin
					soc_uart_phy_rx_reg <= {soc_uart_phy_rx, soc_uart_phy_rx_reg[7:1]};
				end
			end
		end
	end
	if (soc_uart_phy_rx_busy) begin
		{soc_uart_phy_uart_clk_rxen, soc_uart_phy_phase_accumulator_rx} <= (soc_uart_phy_phase_accumulator_rx + soc_uart_phy_storage);
	end else begin
		{soc_uart_phy_uart_clk_rxen, soc_uart_phy_phase_accumulator_rx} <= 32'd2147483648;
	end
	if (soc_uart_tx_clear) begin
		soc_uart_tx_pending <= 1'd0;
	end
	soc_uart_tx_old_trigger <= soc_uart_tx_trigger;
	if (((~soc_uart_tx_trigger) & soc_uart_tx_old_trigger)) begin
		soc_uart_tx_pending <= 1'd1;
	end
	if (soc_uart_rx_clear) begin
		soc_uart_rx_pending <= 1'd0;
	end
	soc_uart_rx_old_trigger <= soc_uart_rx_trigger;
	if (((~soc_uart_rx_trigger) & soc_uart_rx_old_trigger)) begin
		soc_uart_rx_pending <= 1'd1;
	end
	if (soc_uart_tx_fifo_syncfifo_re) begin
		soc_uart_tx_fifo_readable <= 1'd1;
	end else begin
		if (soc_uart_tx_fifo_re) begin
			soc_uart_tx_fifo_readable <= 1'd0;
		end
	end
	if (((soc_uart_tx_fifo_syncfifo_we & soc_uart_tx_fifo_syncfifo_writable) & (~soc_uart_tx_fifo_replace))) begin
		soc_uart_tx_fifo_produce <= (soc_uart_tx_fifo_produce + 1'd1);
	end
	if (soc_uart_tx_fifo_do_read) begin
		soc_uart_tx_fifo_consume <= (soc_uart_tx_fifo_consume + 1'd1);
	end
	if (((soc_uart_tx_fifo_syncfifo_we & soc_uart_tx_fifo_syncfifo_writable) & (~soc_uart_tx_fifo_replace))) begin
		if ((~soc_uart_tx_fifo_do_read)) begin
			soc_uart_tx_fifo_level0 <= (soc_uart_tx_fifo_level0 + 1'd1);
		end
	end else begin
		if (soc_uart_tx_fifo_do_read) begin
			soc_uart_tx_fifo_level0 <= (soc_uart_tx_fifo_level0 - 1'd1);
		end
	end
	if (soc_uart_rx_fifo_syncfifo_re) begin
		soc_uart_rx_fifo_readable <= 1'd1;
	end else begin
		if (soc_uart_rx_fifo_re) begin
			soc_uart_rx_fifo_readable <= 1'd0;
		end
	end
	if (((soc_uart_rx_fifo_syncfifo_we & soc_uart_rx_fifo_syncfifo_writable) & (~soc_uart_rx_fifo_replace))) begin
		soc_uart_rx_fifo_produce <= (soc_uart_rx_fifo_produce + 1'd1);
	end
	if (soc_uart_rx_fifo_do_read) begin
		soc_uart_rx_fifo_consume <= (soc_uart_rx_fifo_consume + 1'd1);
	end
	if (((soc_uart_rx_fifo_syncfifo_we & soc_uart_rx_fifo_syncfifo_writable) & (~soc_uart_rx_fifo_replace))) begin
		if ((~soc_uart_rx_fifo_do_read)) begin
			soc_uart_rx_fifo_level0 <= (soc_uart_rx_fifo_level0 + 1'd1);
		end
	end else begin
		if (soc_uart_rx_fifo_do_read) begin
			soc_uart_rx_fifo_level0 <= (soc_uart_rx_fifo_level0 - 1'd1);
		end
	end
	if (soc_uart_reset) begin
		soc_uart_tx_pending <= 1'd0;
		soc_uart_tx_old_trigger <= 1'd0;
		soc_uart_rx_pending <= 1'd0;
		soc_uart_rx_old_trigger <= 1'd0;
		soc_uart_tx_fifo_readable <= 1'd0;
		soc_uart_tx_fifo_level0 <= 5'd0;
		soc_uart_tx_fifo_produce <= 4'd0;
		soc_uart_tx_fifo_consume <= 4'd0;
		soc_uart_rx_fifo_readable <= 1'd0;
		soc_uart_rx_fifo_level0 <= 5'd0;
		soc_uart_rx_fifo_produce <= 4'd0;
		soc_uart_rx_fifo_consume <= 4'd0;
	end
	if (soc_timer0_en_storage) begin
		if ((soc_timer0_value == 1'd0)) begin
			soc_timer0_value <= soc_timer0_reload_storage;
		end else begin
			soc_timer0_value <= (soc_timer0_value - 1'd1);
		end
	end else begin
		soc_timer0_value <= soc_timer0_load_storage;
	end
	if (soc_timer0_update_value_re) begin
		soc_timer0_value_status <= soc_timer0_value;
	end
	if (soc_timer0_zero_clear) begin
		soc_timer0_zero_pending <= 1'd0;
	end
	soc_timer0_zero_old_trigger <= soc_timer0_zero_trigger;
	if (((~soc_timer0_zero_trigger) & soc_timer0_zero_old_trigger)) begin
		soc_timer0_zero_pending <= 1'd1;
	end
	if (soc_Buttons_WB_button1_clear) begin
		soc_Buttons_WB_button1_pending <= 1'd0;
	end
	if (soc_Buttons_WB_button1_trigger) begin
		soc_Buttons_WB_button1_pending <= 1'd1;
	end
	if (soc_Buttons_WB_button2_clear) begin
		soc_Buttons_WB_button2_pending <= 1'd0;
	end
	if (soc_Buttons_WB_button2_trigger) begin
		soc_Buttons_WB_button2_pending <= 1'd1;
	end
	if (soc_Buttons_WB_button3_clear) begin
		soc_Buttons_WB_button3_pending <= 1'd0;
	end
	if (soc_Buttons_WB_button3_trigger) begin
		soc_Buttons_WB_button3_pending <= 1'd1;
	end
	if (soc_Buttons_WB_button4_clear) begin
		soc_Buttons_WB_button4_pending <= 1'd0;
	end
	if (soc_Buttons_WB_button4_trigger) begin
		soc_Buttons_WB_button4_pending <= 1'd1;
	end
	if (soc_SD_WB_DataClock_clear) begin
		soc_SD_WB_DataClock_pending <= 1'd0;
	end
	soc_SD_WB_DataClock_old_trigger <= soc_SD_WB_DataClock_trigger;
	if (((~soc_SD_WB_DataClock_trigger) & soc_SD_WB_DataClock_old_trigger)) begin
		soc_SD_WB_DataClock_pending <= 1'd1;
	end
	case (grant)
		1'd0: begin
			if ((~request[0])) begin
				if (request[1]) begin
					grant <= 1'd1;
				end
			end
		end
		1'd1: begin
			if ((~request[1])) begin
				if (request[0]) begin
					grant <= 1'd0;
				end
			end
		end
	endcase
	slave_sel_r <= slave_sel;
	if (wait_1) begin
		if ((~done)) begin
			count <= (count - 1'd1);
		end
	end else begin
		count <= 20'd1000000;
	end
	interface0_bank_bus_dat_r <= 1'd0;
	if (csrbank0_sel) begin
		case (interface0_bank_bus_adr[1:0])
			1'd0: begin
				interface0_bank_bus_dat_r <= csrbank0_AudioControlRegister0_w;
			end
			1'd1: begin
				interface0_bank_bus_dat_r <= csrbank0_SoundTrackInitializationRegister0_w;
			end
			2'd2: begin
				interface0_bank_bus_dat_r <= csrbank0_InitializationEnableRegister0_w;
			end
		endcase
	end
	if (csrbank0_AudioControlRegister0_re) begin
		soc_Audio_WB_AudioControlRegister_storage_full[3:0] <= csrbank0_AudioControlRegister0_r;
	end
	soc_Audio_WB_AudioControlRegister_re <= csrbank0_AudioControlRegister0_re;
	if (csrbank0_SoundTrackInitializationRegister0_re) begin
		soc_Audio_WB_SoundTrackInitializationRegister_storage_full[15:0] <= csrbank0_SoundTrackInitializationRegister0_r;
	end
	soc_Audio_WB_SoundTrackInitializationRegister_re <= csrbank0_SoundTrackInitializationRegister0_re;
	if (csrbank0_InitializationEnableRegister0_re) begin
		soc_Audio_WB_InitializationEnableRegister_storage_full <= csrbank0_InitializationEnableRegister0_r;
	end
	soc_Audio_WB_InitializationEnableRegister_re <= csrbank0_InitializationEnableRegister0_re;
	interface1_bank_bus_dat_r <= 1'd0;
	if (csrbank1_sel) begin
		case (interface1_bank_bus_adr[1:0])
			1'd0: begin
				interface1_bank_bus_dat_r <= csrbank1_DataRegister_w;
			end
			1'd1: begin
				interface1_bank_bus_dat_r <= buttons_status_w;
			end
			2'd2: begin
				interface1_bank_bus_dat_r <= buttons_pending_w;
			end
			2'd3: begin
				interface1_bank_bus_dat_r <= csrbank1_ev_enable0_w;
			end
		endcase
	end
	if (csrbank1_ev_enable0_re) begin
		buttons_storage_full[3:0] <= csrbank1_ev_enable0_r;
	end
	buttons_re <= csrbank1_ev_enable0_re;
	interface2_bank_bus_dat_r <= 1'd0;
	if (csrbank2_sel) begin
		case (interface2_bank_bus_adr[2:0])
			1'd0: begin
				interface2_bank_bus_dat_r <= csrbank2_EnableDataWriteRegister0_w;
			end
			1'd1: begin
				interface2_bank_bus_dat_r <= csrbank2_OuputDataRegister0_w;
			end
			2'd2: begin
				interface2_bank_bus_dat_r <= csrbank2_SPI_EnableRegister0_w;
			end
			2'd3: begin
				interface2_bank_bus_dat_r <= csrbank2_InputDataRegisterCSR_w;
			end
			3'd4: begin
				interface2_bank_bus_dat_r <= csrbank2_DataClockRegisterCSR_w;
			end
			3'd5: begin
				interface2_bank_bus_dat_r <= sd_status_w;
			end
			3'd6: begin
				interface2_bank_bus_dat_r <= sd_pending_w;
			end
			3'd7: begin
				interface2_bank_bus_dat_r <= csrbank2_ev_enable0_w;
			end
		endcase
	end
	if (csrbank2_EnableDataWriteRegister0_re) begin
		soc_SD_WB_EnableDataWriteRegister_storage_full <= csrbank2_EnableDataWriteRegister0_r;
	end
	soc_SD_WB_EnableDataWriteRegister_re <= csrbank2_EnableDataWriteRegister0_re;
	if (csrbank2_OuputDataRegister0_re) begin
		soc_SD_WB_OuputDataRegister_storage_full[7:0] <= csrbank2_OuputDataRegister0_r;
	end
	soc_SD_WB_OuputDataRegister_re <= csrbank2_OuputDataRegister0_re;
	if (csrbank2_SPI_EnableRegister0_re) begin
		soc_SD_WB_SPI_EnableRegister_storage_full <= csrbank2_SPI_EnableRegister0_r;
	end
	soc_SD_WB_SPI_EnableRegister_re <= csrbank2_SPI_EnableRegister0_re;
	if (csrbank2_ev_enable0_re) begin
		sd_storage_full <= csrbank2_ev_enable0_r;
	end
	sd_re <= csrbank2_ev_enable0_re;
	interface3_bank_bus_dat_r <= 1'd0;
	if (csrbank3_sel) begin
		case (interface3_bank_bus_adr[0])
			1'd0: begin
				interface3_bank_bus_dat_r <= csrbank3_TilesControlRegisterCSR0_w;
			end
		endcase
	end
	if (csrbank3_TilesControlRegisterCSR0_re) begin
		soc_Video_WB_storage_full[13:0] <= csrbank3_TilesControlRegisterCSR0_r;
	end
	soc_Video_WB_re <= csrbank3_TilesControlRegisterCSR0_re;
	interface4_bank_bus_dat_r <= 1'd0;
	if (csrbank4_sel) begin
		case (interface4_bank_bus_adr[1:0])
			1'd0: begin
				interface4_bank_bus_dat_r <= soc_ctrl_reset_reset_w;
			end
			1'd1: begin
				interface4_bank_bus_dat_r <= csrbank4_scratch0_w;
			end
			2'd2: begin
				interface4_bank_bus_dat_r <= csrbank4_bus_errors_w;
			end
		endcase
	end
	if (csrbank4_scratch0_re) begin
		soc_ctrl_storage_full[31:0] <= csrbank4_scratch0_r;
	end
	soc_ctrl_re <= csrbank4_scratch0_re;
	sel_r <= sel;
	interface5_bank_bus_dat_r <= 1'd0;
	if (csrbank5_sel) begin
		case (interface5_bank_bus_adr[2:0])
			1'd0: begin
				interface5_bank_bus_dat_r <= csrbank5_load0_w;
			end
			1'd1: begin
				interface5_bank_bus_dat_r <= csrbank5_reload0_w;
			end
			2'd2: begin
				interface5_bank_bus_dat_r <= csrbank5_en0_w;
			end
			2'd3: begin
				interface5_bank_bus_dat_r <= soc_timer0_update_value_w;
			end
			3'd4: begin
				interface5_bank_bus_dat_r <= csrbank5_value_w;
			end
			3'd5: begin
				interface5_bank_bus_dat_r <= soc_timer0_eventmanager_status_w;
			end
			3'd6: begin
				interface5_bank_bus_dat_r <= soc_timer0_eventmanager_pending_w;
			end
			3'd7: begin
				interface5_bank_bus_dat_r <= csrbank5_ev_enable0_w;
			end
		endcase
	end
	if (csrbank5_load0_re) begin
		soc_timer0_load_storage_full[31:0] <= csrbank5_load0_r;
	end
	soc_timer0_load_re <= csrbank5_load0_re;
	if (csrbank5_reload0_re) begin
		soc_timer0_reload_storage_full[31:0] <= csrbank5_reload0_r;
	end
	soc_timer0_reload_re <= csrbank5_reload0_re;
	if (csrbank5_en0_re) begin
		soc_timer0_en_storage_full <= csrbank5_en0_r;
	end
	soc_timer0_en_re <= csrbank5_en0_re;
	if (csrbank5_ev_enable0_re) begin
		soc_timer0_eventmanager_storage_full <= csrbank5_ev_enable0_r;
	end
	soc_timer0_eventmanager_re <= csrbank5_ev_enable0_re;
	interface6_bank_bus_dat_r <= 1'd0;
	if (csrbank6_sel) begin
		case (interface6_bank_bus_adr[2:0])
			1'd0: begin
				interface6_bank_bus_dat_r <= soc_uart_rxtx_w;
			end
			1'd1: begin
				interface6_bank_bus_dat_r <= csrbank6_txfull_w;
			end
			2'd2: begin
				interface6_bank_bus_dat_r <= csrbank6_rxempty_w;
			end
			2'd3: begin
				interface6_bank_bus_dat_r <= soc_uart_eventmanager_status_w;
			end
			3'd4: begin
				interface6_bank_bus_dat_r <= soc_uart_eventmanager_pending_w;
			end
			3'd5: begin
				interface6_bank_bus_dat_r <= csrbank6_ev_enable0_w;
			end
		endcase
	end
	if (csrbank6_ev_enable0_re) begin
		soc_uart_eventmanager_storage_full[1:0] <= csrbank6_ev_enable0_r;
	end
	soc_uart_eventmanager_re <= csrbank6_ev_enable0_re;
	interface7_bank_bus_dat_r <= 1'd0;
	if (csrbank7_sel) begin
		case (interface7_bank_bus_adr[0])
			1'd0: begin
				interface7_bank_bus_dat_r <= csrbank7_tuning_word0_w;
			end
		endcase
	end
	if (csrbank7_tuning_word0_re) begin
		soc_uart_phy_storage_full[31:0] <= csrbank7_tuning_word0_r;
	end
	soc_uart_phy_re <= csrbank7_tuning_word0_re;
	if (sys_rst) begin
		soc_ctrl_storage_full <= 32'd305419896;
		soc_ctrl_re <= 1'd0;
		soc_ctrl_bus_errors <= 32'd0;
		soc_rom_bus_ack <= 1'd0;
		soc_sram_bus_ack <= 1'd0;
		soc_main_ram_bus_ack <= 1'd0;
		soc_interface_adr <= 14'd0;
		soc_interface_we <= 1'd0;
		soc_interface_dat_w <= 32'd0;
		soc_bus_wishbone_dat_r <= 32'd0;
		soc_bus_wishbone_ack <= 1'd0;
		soc_counter <= 2'd0;
		serial_tx <= 1'd1;
		soc_uart_phy_storage_full <= 32'd4947802;
		soc_uart_phy_re <= 1'd0;
		soc_uart_phy_sink_ready <= 1'd0;
		soc_uart_phy_uart_clk_txen <= 1'd0;
		soc_uart_phy_phase_accumulator_tx <= 32'd0;
		soc_uart_phy_tx_reg <= 8'd0;
		soc_uart_phy_tx_bitcount <= 4'd0;
		soc_uart_phy_tx_busy <= 1'd0;
		soc_uart_phy_source_valid <= 1'd0;
		soc_uart_phy_source_payload_data <= 8'd0;
		soc_uart_phy_uart_clk_rxen <= 1'd0;
		soc_uart_phy_phase_accumulator_rx <= 32'd0;
		soc_uart_phy_rx_r <= 1'd0;
		soc_uart_phy_rx_reg <= 8'd0;
		soc_uart_phy_rx_bitcount <= 4'd0;
		soc_uart_phy_rx_busy <= 1'd0;
		soc_uart_tx_pending <= 1'd0;
		soc_uart_tx_old_trigger <= 1'd0;
		soc_uart_rx_pending <= 1'd0;
		soc_uart_rx_old_trigger <= 1'd0;
		soc_uart_eventmanager_storage_full <= 2'd0;
		soc_uart_eventmanager_re <= 1'd0;
		soc_uart_tx_fifo_readable <= 1'd0;
		soc_uart_tx_fifo_level0 <= 5'd0;
		soc_uart_tx_fifo_produce <= 4'd0;
		soc_uart_tx_fifo_consume <= 4'd0;
		soc_uart_rx_fifo_readable <= 1'd0;
		soc_uart_rx_fifo_level0 <= 5'd0;
		soc_uart_rx_fifo_produce <= 4'd0;
		soc_uart_rx_fifo_consume <= 4'd0;
		soc_timer0_load_storage_full <= 32'd0;
		soc_timer0_load_re <= 1'd0;
		soc_timer0_reload_storage_full <= 32'd0;
		soc_timer0_reload_re <= 1'd0;
		soc_timer0_en_storage_full <= 1'd0;
		soc_timer0_en_re <= 1'd0;
		soc_timer0_value_status <= 32'd0;
		soc_timer0_zero_pending <= 1'd0;
		soc_timer0_zero_old_trigger <= 1'd0;
		soc_timer0_eventmanager_storage_full <= 1'd0;
		soc_timer0_eventmanager_re <= 1'd0;
		soc_timer0_value <= 32'd0;
		soc_Video_WB_storage_full <= 14'd0;
		soc_Video_WB_re <= 1'd0;
		soc_Audio_WB_AudioControlRegister_storage_full <= 4'd0;
		soc_Audio_WB_AudioControlRegister_re <= 1'd0;
		soc_Audio_WB_SoundTrackInitializationRegister_storage_full <= 16'd0;
		soc_Audio_WB_SoundTrackInitializationRegister_re <= 1'd0;
		soc_Audio_WB_InitializationEnableRegister_storage_full <= 1'd0;
		soc_Audio_WB_InitializationEnableRegister_re <= 1'd0;
		soc_Buttons_WB_button1_pending <= 1'd0;
		soc_Buttons_WB_button2_pending <= 1'd0;
		soc_Buttons_WB_button3_pending <= 1'd0;
		soc_Buttons_WB_button4_pending <= 1'd0;
		soc_SD_WB_DataClock_pending <= 1'd0;
		soc_SD_WB_DataClock_old_trigger <= 1'd0;
		soc_SD_WB_EnableDataWriteRegister_storage_full <= 1'd0;
		soc_SD_WB_EnableDataWriteRegister_re <= 1'd0;
		soc_SD_WB_OuputDataRegister_storage_full <= 8'd0;
		soc_SD_WB_OuputDataRegister_re <= 1'd0;
		soc_SD_WB_SPI_EnableRegister_storage_full <= 1'd0;
		soc_SD_WB_SPI_EnableRegister_re <= 1'd0;
		buttons_storage_full <= 4'd0;
		buttons_re <= 1'd0;
		sd_storage_full <= 1'd0;
		sd_re <= 1'd0;
		grant <= 1'd0;
		slave_sel_r <= 4'd0;
		count <= 20'd1000000;
		interface0_bank_bus_dat_r <= 32'd0;
		interface1_bank_bus_dat_r <= 32'd0;
		interface2_bank_bus_dat_r <= 32'd0;
		interface3_bank_bus_dat_r <= 32'd0;
		interface4_bank_bus_dat_r <= 32'd0;
		sel_r <= 1'd0;
		interface5_bank_bus_dat_r <= 32'd0;
		interface6_bank_bus_dat_r <= 32'd0;
		interface7_bank_bus_dat_r <= 32'd0;
	end
	regs0 <= serial_rx;
	regs1 <= regs0;
end

lm32_cpu #(
	.eba_reset(32'h00000000)
) lm32_cpu (
	.D_ACK_I(soc_lm32_dbus_ack),
	.D_DAT_I(soc_lm32_dbus_dat_r),
	.D_ERR_I(soc_lm32_dbus_err),
	.D_RTY_I(1'd0),
	.I_ACK_I(soc_lm32_ibus_ack),
	.I_DAT_I(soc_lm32_ibus_dat_r),
	.I_ERR_I(soc_lm32_ibus_err),
	.I_RTY_I(1'd0),
	.clk_i(sys_clk),
	.interrupt(soc_lm32_interrupt),
	.rst_i((sys_rst | soc_lm32_reset)),
	.D_ADR_O(soc_lm32_d_adr_o),
	.D_BTE_O(soc_lm32_dbus_bte),
	.D_CTI_O(soc_lm32_dbus_cti),
	.D_CYC_O(soc_lm32_dbus_cyc),
	.D_DAT_O(soc_lm32_dbus_dat_w),
	.D_SEL_O(soc_lm32_dbus_sel),
	.D_STB_O(soc_lm32_dbus_stb),
	.D_WE_O(soc_lm32_dbus_we),
	.I_ADR_O(soc_lm32_i_adr_o),
	.I_BTE_O(soc_lm32_ibus_bte),
	.I_CTI_O(soc_lm32_ibus_cti),
	.I_CYC_O(soc_lm32_ibus_cyc),
	.I_DAT_O(soc_lm32_ibus_dat_w),
	.I_SEL_O(soc_lm32_ibus_sel),
	.I_STB_O(soc_lm32_ibus_stb),
	.I_WE_O(soc_lm32_ibus_we)
);

reg [31:0] mem[0:8191];
reg [12:0] memadr;
always @(posedge sys_clk) begin
	memadr <= soc_rom_adr;
end

assign soc_rom_dat_r = mem[memadr];

initial begin
	$readmemh("mem.init", mem);
end

reg [31:0] mem_1[0:1023];
reg [9:0] memadr_1;
always @(posedge sys_clk) begin
	if (soc_sram_we[0])
		mem_1[soc_sram_adr][7:0] <= soc_sram_dat_w[7:0];
	if (soc_sram_we[1])
		mem_1[soc_sram_adr][15:8] <= soc_sram_dat_w[15:8];
	if (soc_sram_we[2])
		mem_1[soc_sram_adr][23:16] <= soc_sram_dat_w[23:16];
	if (soc_sram_we[3])
		mem_1[soc_sram_adr][31:24] <= soc_sram_dat_w[31:24];
	memadr_1 <= soc_sram_adr;
end

assign soc_sram_dat_r = mem_1[memadr_1];

reg [31:0] mem_2[0:4095];
reg [11:0] memadr_2;
always @(posedge sys_clk) begin
	if (soc_main_ram_we[0])
		mem_2[soc_main_ram_adr][7:0] <= soc_main_ram_dat_w[7:0];
	if (soc_main_ram_we[1])
		mem_2[soc_main_ram_adr][15:8] <= soc_main_ram_dat_w[15:8];
	if (soc_main_ram_we[2])
		mem_2[soc_main_ram_adr][23:16] <= soc_main_ram_dat_w[23:16];
	if (soc_main_ram_we[3])
		mem_2[soc_main_ram_adr][31:24] <= soc_main_ram_dat_w[31:24];
	memadr_2 <= soc_main_ram_adr;
end

assign soc_main_ram_dat_r = mem_2[memadr_2];

initial begin
	$readmemh("mem_2.init", mem_2);
end

reg [9:0] storage[0:15];
reg [9:0] memdat;
reg [9:0] memdat_1;
always @(posedge sys_clk) begin
	if (soc_uart_tx_fifo_wrport_we)
		storage[soc_uart_tx_fifo_wrport_adr] <= soc_uart_tx_fifo_wrport_dat_w;
	memdat <= storage[soc_uart_tx_fifo_wrport_adr];
end

always @(posedge sys_clk) begin
	if (soc_uart_tx_fifo_rdport_re)
		memdat_1 <= storage[soc_uart_tx_fifo_rdport_adr];
end

assign soc_uart_tx_fifo_wrport_dat_r = memdat;
assign soc_uart_tx_fifo_rdport_dat_r = memdat_1;

reg [9:0] storage_1[0:15];
reg [9:0] memdat_2;
reg [9:0] memdat_3;
always @(posedge sys_clk) begin
	if (soc_uart_rx_fifo_wrport_we)
		storage_1[soc_uart_rx_fifo_wrport_adr] <= soc_uart_rx_fifo_wrport_dat_w;
	memdat_2 <= storage_1[soc_uart_rx_fifo_wrport_adr];
end

always @(posedge sys_clk) begin
	if (soc_uart_rx_fifo_rdport_re)
		memdat_3 <= storage_1[soc_uart_rx_fifo_rdport_adr];
end

assign soc_uart_rx_fifo_wrport_dat_r = memdat_2;
assign soc_uart_rx_fifo_rdport_dat_r = memdat_3;

reg [7:0] mem_3[0:32];
reg [5:0] memadr_3;
always @(posedge sys_clk) begin
	memadr_3 <= adr;
end

assign dat_r = mem_3[memadr_3];

initial begin
	$readmemh("mem_3.init", mem_3);
end

Video Video(
	.CLK(soc_Video_WB_CLK),
	.Reset(soc_Video_WB_Reset),
	.TilesControlRegister(soc_Video_WB_TilesControlRegister),
	.TFT_RS(soc_Video_WB_TFT_RS),
	.TFT_RST(soc_Video_WB_TFT_RST),
	.TFT_SPI_CLK(soc_Video_WB_TFT_SPI_CLK),
	.TFT_SPI_CS(soc_Video_WB_TFT_SPI_CS),
	.TFT_SPI_MOSI(soc_Video_WB_TFT_SPI_MOSI)
);

Audio Audio(
	.AudioControlRegister(soc_Audio_WB_AudioControlRegister_storage),
	.CLK(soc_Audio_WB_CLK),
	.InitializationEnableRegister(soc_Audio_WB_InitializationEnableRegister_storage),
	.Reset(soc_Audio_WB_Reset),
	.SoundTrackInitializationRegister(soc_Audio_WB_SoundTrackInitializationRegister_storage),
	.DAC_I2S_CLK(soc_Audio_WB_DAC_I2S_CLK),
	.DAC_I2S_DATA(soc_Audio_WB_DAC_I2S_DATA),
	.DAC_I2S_WS(soc_Audio_WB_DAC_I2S_WS)
);

Buttons Buttons(
	.CLK(soc_Buttons_WB_CLK),
	.buttons(soc_Buttons_WB_Buttons),
	.Button1Interrupt(soc_Buttons_WB_Button1Interrupt),
	.Button2Interrupt(soc_Buttons_WB_Button2Interrupt),
	.Button3Interrupt(soc_Buttons_WB_Button3Interrupt),
	.Button4Interrupt(soc_Buttons_WB_Button4Interrupt),
	.data(soc_Buttons_WB_Data)
);

SD SD(
	.MasterCLK(soc_SD_WB_CLK),
	.OuputDataRegister(soc_SD_WB_OuputDataRegister_storage),
	.Reset(soc_SD_WB_Reset),
	.SPI_EnableRegister(soc_SD_WB_SPI_EnableRegister_storage),
	.SPI_MISO(soc_SD_WB_SD_SPI_MISO),
	.DataClockRegister(soc_SD_WB_DataClockRegister),
	.InputDataRegister(soc_SD_WB_InputDataRegister),
	.SPI_CLK(soc_SD_WB_SD_SPI_CLK),
	.SPI_CS(soc_SD_WB_SD_SPI_CS),
	.SPI_MOSI(soc_SD_WB_SD_SPI_MOSI)
);

endmodule
