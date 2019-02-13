create_project -force -name top -part xc7a35tcpg236-1
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ButtonDebouncerTester.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ButtonDebouncerTester.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/TFT_SPI.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/TFT_SPI.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/SPI.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/SPI.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/SD_SPI.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/SD_SPI.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ButtonDebouncer.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ButtonDebouncer.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_I2S/SquareGenerator.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_I2S/SquareGenerator.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/FullSPI.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/FullSPI.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ClockManager.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/ClockManager.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/AudVid.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/AudVid.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/Counter.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/Counter.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_I2S/I2S.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_I2S/I2S.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/FrequencyGenerator.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/utilities/FrequencyGenerator.v}]
add_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/InitializationRegister.v}
set_property library work [get_files {/home/camilo/MEGA/Universidad/2018-2/Digital2/Proyecto/SoC/Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/InitializationRegister.v}]
add_files {top.v}
set_property library work [get_files {top.v}]
read_xdc top.xdc
synth_design -top top -part xc7a35tcpg236-1
report_timing_summary -file top_timing_synth.rpt
report_utilization -hierarchical -file top_utilization_hierarchical_synth.rpt
report_utilization -file top_utilization_synth.rpt
opt_design
place_design
report_utilization -hierarchical -file top_utilization_hierarchical_place.rpt
report_utilization -file top_utilization_place.rpt
report_io -file top_io.rpt
report_control_sets -verbose -file top_control_sets.rpt
report_clock_utilization -file top_clock_utilization.rpt
route_design
phys_opt_design
report_timing_summary -no_header -no_detailed_paths
write_checkpoint -force top_route.dcp
report_route_status -file top_route_status.rpt
report_drc -file top_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file top_timing.rpt
report_power -file top_power.rpt
write_bitstream -force top.bit 
quit