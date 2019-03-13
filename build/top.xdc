 ## user_sw:0
set_property LOC V17 [get_ports user_sw]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw]
 ## user_sw:1
set_property LOC V16 [get_ports user_sw_1]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_1]
 ## user_sw:2
set_property LOC W16 [get_ports user_sw_2]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_2]
 ## user_sw:3
set_property LOC W17 [get_ports user_sw_3]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_3]
 ## user_sw:4
set_property LOC W15 [get_ports user_sw_4]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_4]
 ## user_sw:5
set_property LOC V15 [get_ports user_sw_5]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_5]
 ## user_sw:6
set_property LOC W14 [get_ports user_sw_6]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_6]
 ## user_sw:7
set_property LOC W13 [get_ports user_sw_7]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_7]
 ## user_sw:8
set_property LOC V2 [get_ports user_sw_8]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_8]
 ## user_sw:9
set_property LOC T3 [get_ports user_sw_9]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_9]
 ## user_sw:10
set_property LOC T2 [get_ports user_sw_10]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_10]
 ## user_sw:11
set_property LOC R3 [get_ports user_sw_11]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_11]
 ## user_sw:12
set_property LOC W2 [get_ports user_sw_12]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_12]
 ## user_sw:13
set_property LOC U1 [get_ports user_sw_13]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_13]
 ## user_sw:14
set_property LOC T1 [get_ports user_sw_14]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_14]
 ## user_sw:15
set_property LOC R2 [get_ports user_sw_15]
set_property IOSTANDARD LVCMOS33 [get_ports user_sw_15]
 ## SD_SPI_CS:0
set_property LOC J3 [get_ports SD_SPI_CS]
set_property IOSTANDARD LVCMOS33 [get_ports SD_SPI_CS]
 ## SD_SPI_CLK:0
set_property LOC L3 [get_ports SD_SPI_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports SD_SPI_CLK]
 ## SD_SPI_MOSI:0
set_property LOC M2 [get_ports SD_SPI_MOSI]
set_property IOSTANDARD LVCMOS33 [get_ports SD_SPI_MOSI]
 ## SD_SPI_MISO:0
set_property LOC N2 [get_ports SD_SPI_MISO]
set_property IOSTANDARD LVCMOS33 [get_ports SD_SPI_MISO]
 ## cpu_reset:0
set_property LOC U18 [get_ports cpu_reset]
set_property IOSTANDARD LVCMOS33 [get_ports cpu_reset]
 ## clk100:0
set_property LOC W5 [get_ports clk100]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]

create_clock -name clk100 -period 10.0 [get_nets clk100]

set_false_path -quiet -to [get_nets -filter {mr_ff == TRUE}]

set_false_path -quiet -to [get_pins -filter {REF_PIN_NAME == PRE} -of [get_cells -filter {ars_ff1 == TRUE || ars_ff2 == TRUE}]]

set_max_delay 2 -quiet -from [get_pins -filter {REF_PIN_NAME == Q} -of [get_cells -filter {ars_ff1 == TRUE}]] -to [get_pins -filter {REF_PIN_NAME == D} -of [get_cells -filter {ars_ff2 == TRUE}]]