#!/usr/bin/python3

#
#Llamado a migen 
#-----------------------------------------------------------------------	
from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform


#-----------------------------------------------------------------------
# Definicion de Pines
#
_io = [
    ("user_led"     , 0 , Pins("U16"), IOStandard("LVCMOS33")),
    ("user_led"     , 1 , Pins("E19"), IOStandard("LVCMOS33")),
    ("user_led"     , 2 , Pins("U19"), IOStandard("LVCMOS33")),
    ("user_led"     , 3 , Pins("V19"), IOStandard("LVCMOS33")),
    ("user_led"     , 4 , Pins("W18"), IOStandard("LVCMOS33")),
    ("user_led"     , 5 , Pins("U15"), IOStandard("LVCMOS33")),
    ("user_led"     , 6 , Pins("U14"), IOStandard("LVCMOS33")),
    ("user_led"     , 7 , Pins("V14"), IOStandard("LVCMOS33")),
    ("user_led"     , 8 , Pins("V13"), IOStandard("LVCMOS33")),
    ("user_led"     , 9 , Pins("V3" ), IOStandard("LVCMOS33")),
    ("user_led"     , 10, Pins("W3" ), IOStandard("LVCMOS33")),
    ("user_led"     , 11, Pins("U3" ), IOStandard("LVCMOS33")),
    ("user_led"     , 12, Pins("P3" ), IOStandard("LVCMOS33")),
    ("user_led"     , 13, Pins("N3" ), IOStandard("LVCMOS33")),
    ("user_led"     , 14, Pins("P1" ), IOStandard("LVCMOS33")),
    ("user_led"     , 15, Pins("L1" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 0 , Pins("V17"), IOStandard("LVCMOS33")),
    ("user_sw"      , 1 , Pins("V16"), IOStandard("LVCMOS33")),
    ("user_sw"      , 2 , Pins("W16"), IOStandard("LVCMOS33")),
    ("user_sw"      , 3 , Pins("W17"), IOStandard("LVCMOS33")),
    ("user_sw"      , 4 , Pins("W15"), IOStandard("LVCMOS33")),
    ("user_sw"      , 5 , Pins("V15"), IOStandard("LVCMOS33")),
    ("user_sw"      , 6 , Pins("W14"), IOStandard("LVCMOS33")),
    ("user_sw"      , 7 , Pins("W13"), IOStandard("LVCMOS33")),
    ("user_sw"      , 8 , Pins("V2" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 9 , Pins("T3" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 10, Pins("T2" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 11, Pins("R3" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 12, Pins("W2" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 13, Pins("U1" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 14, Pins("T1" ), IOStandard("LVCMOS33")),
    ("user_sw"      , 15, Pins("R2" ), IOStandard("LVCMOS33")),
    ("Reset"        , 0 , Pins("U18"), IOStandard("LVCMOS33")),
    ("user_btn"     , 0 , Pins("T18"), IOStandard("LVCMOS33")),
    ("user_btn"     , 1 , Pins("W19"), IOStandard("LVCMOS33")),
    ("user_btn"     , 2 , Pins("T17"), IOStandard("LVCMOS33")),
    ("user_btn"     , 3 , Pins("U17"), IOStandard("LVCMOS33")),
    ("clk100"       , 0 , Pins("W5" ), IOStandard("LVCMOS33")),

    #SD_SPI_SPI-JC
    ("SD_SPI_MISO"         , 0 , Pins("K17"), IOStandard("LVCMOS33")),
    ("SD_SPI_MOSI"         , 0 , Pins("M18"), IOStandard("LVCMOS33")),
    ("SD_SPI_CLK"          , 0 , Pins("N17"), IOStandard("LVCMOS33")),
    ("SD_SPI_CS"           , 0 , Pins("P18"), IOStandard("LVCMOS33")),
    ("SPI_COUNT_DEBUG"     , 0 , Pins("L17"), IOStandard("LVCMOS33")),
    ("SPI_UTILCOUNT_DEBUG" , 0 , Pins("M19"), IOStandard("LVCMOS33")),
    

]

#-----------------------------------------------------------------------
#Defincinicion de Plataforma (Marca y referencia de FPGA)
#
class Platform(XilinxPlatform):
    default_clk_name = "clk100"
    default_clk_period = 10.0

    def __init__(self):
        XilinxPlatform.__init__(self, "xc7a35tcpg236-1", _io, toolchain="vivado")

    def do_finalize(self, fragment):
        XilinxPlatform.do_finalize(self, fragment)

#----------------------------------------------------------------------
#Creacion de Plataforma
platform = Platform()
#Definicion de pines como variables
SystemClock         = ClockSignal()
leds                = Cat(*[platform.request("user_led", i) for i in range(16)])
switches            = Cat(*[platform.request("user_sw" , i) for i in range(16)])
buttons             = Cat(*[platform.request("user_btn", i) for i in range(4) ])
SD_SPI_CLK          = platform.request("SD_SPI_CLK"          , 0)
SD_SPI_MOSI         = platform.request("SD_SPI_MOSI"         , 0)
SD_SPI_MISO         = platform.request("SD_SPI_MISO"         , 0)
SD_SPI_CS           = platform.request("SD_SPI_CS"           , 0)
Reset               = platform.request("Reset"               , 0)
SPI_COUNT_DEBUG     = platform.request("SPI_COUNT_DEBUG"     , 0)
SPI_UTILCOUNT_DEBUG = platform.request("SPI_UTILCOUNT_DEBUG" , 0)
#.......................................................................


#-----------------------------------------------------------------------
# DISEÑO
#


# Adicion de modulos en verilog
#	SD_SPI_SPI
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/SD_SPI.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/FullSPI.v")

#	utilities
platform.add_source("Hardware/utilities/FrequencyGenerator.v")
platform.add_source("Hardware/Peripheral_AudVid/AudVid_ClockManager.v")
platform.add_source("Hardware/utilities/Counter.v")
platform.add_source("Hardware/utilities/ButtonDebouncer.v")
platform.add_source("Hardware/utilities/ButtonDebouncerTester.v")


# Modulo Principal
class SOC(Module):
    def __init__(self):
        self.Leds                = Signal(16)
        self.SystemClock         = Signal()
        self.MasterCLK           = Signal()
        self.SD_SPI_MOSI         = Signal()
        self.SD_SPI_MISO         = Signal()
        self.SD_SPI_CLK          = Signal()
        self.SD_SPI_CS           = Signal()
        self.Reset               = Signal()
        self.SPI_COUNT_DEBUG     = Signal()
        self.SD_InputAddress     = Signal(16)
        self.SPI_UTILCOUNT_DEBUG = Signal()
        self.SD_WorkCLK          = Signal()

        self.specials +=Instance("ClockManager",
            i_InputCLK  = self.SystemClock,
            o_MasterCLK = self.MasterCLK,
            o_SDCLK     = self.SD_WorkCLK 
        )
        self.specials +=Instance("SD_SPI",
            i_MasterCLK           = self.MasterCLK,
            i_WorkCLK             = self.SD_WorkCLK,
            i_Reset               = self.Reset,
            i_SPI_MISO            = self.SD_SPI_MISO,
            o_SPI_MOSI            = self.SD_SPI_MOSI,
            o_SPI_CLK             = self.SD_SPI_CLK,
            o_SPI_CS              = self.SD_SPI_CS,
            o_SPI_COUNT_DEBUG     = self.SPI_COUNT_DEBUG,
            o_SPI_UTILCOUNT_DEBUG = self.SPI_UTILCOUNT_DEBUG,
            i_InputAddress        = self.SD_InputAddress
        )       
        self.comb += leds.eq(self.Leds)
        self.comb += self.SystemClock.eq(SystemClock)
        self.comb += SD_SPI_MOSI.eq(self.SD_SPI_MOSI)
        self.comb += SD_SPI_CLK.eq(self.SD_SPI_CLK)
        self.comb += SD_SPI_CS.eq(self.SD_SPI_CS)
        self.comb += self.SD_SPI_MISO.eq(SD_SPI_MISO)
        self.comb += self.Reset.eq(Reset)
        self.comb += SPI_COUNT_DEBUG.eq(self.SPI_COUNT_DEBUG)
        self.comb += self.SD_InputAddress.eq(switches)
        self.comb += SPI_UTILCOUNT_DEBUG.eq(self.SPI_UTILCOUNT_DEBUG)

#----------------------------------------------------------------------------------
# Sintetizacion de Modulo Principal
#
soc = SOC()
platform.build(soc)
