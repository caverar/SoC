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
    ("user_led", 0 , Pins("U16"), IOStandard("LVCMOS33")),
    ("user_led", 1 , Pins("E19"), IOStandard("LVCMOS33")),
    ("user_led", 2 , Pins("U19"), IOStandard("LVCMOS33")),
    ("user_led", 3 , Pins("V19"), IOStandard("LVCMOS33")),
    ("user_led", 4 , Pins("W18"), IOStandard("LVCMOS33")),
    ("user_led", 5 , Pins("U15"), IOStandard("LVCMOS33")),
    ("user_led", 6 , Pins("U14"), IOStandard("LVCMOS33")),
    ("user_led", 7 , Pins("V14"), IOStandard("LVCMOS33")),
    ("user_led", 8 , Pins("V13"), IOStandard("LVCMOS33")),
    ("user_led", 9 , Pins("V3" ), IOStandard("LVCMOS33")),
    ("user_led", 10, Pins("W3" ), IOStandard("LVCMOS33")),
    ("user_led", 11, Pins("U3" ), IOStandard("LVCMOS33")),
    ("user_led", 12, Pins("P3" ), IOStandard("LVCMOS33")),
    ("user_led", 13, Pins("N3" ), IOStandard("LVCMOS33")),
    ("user_led", 14, Pins("P1" ), IOStandard("LVCMOS33")),
    ("user_led", 15, Pins("L1" ), IOStandard("LVCMOS33")),
    ("user_sw" , 0 , Pins("V17"), IOStandard("LVCMOS33")),
    ("user_sw" , 1 , Pins("V16"), IOStandard("LVCMOS33")),
    ("user_sw" , 2 , Pins("W16"), IOStandard("LVCMOS33")),
    ("user_sw" , 3 , Pins("W17"), IOStandard("LVCMOS33")),
    ("user_sw" , 4 , Pins("W15"), IOStandard("LVCMOS33")),
    ("user_sw" , 5 , Pins("V15"), IOStandard("LVCMOS33")),
    ("user_sw" , 6 , Pins("W14"), IOStandard("LVCMOS33")),
    ("user_sw" , 7 , Pins("W13"), IOStandard("LVCMOS33")),
    ("user_sw" , 8 , Pins("V2" ), IOStandard("LVCMOS33")),
    ("user_sw" , 9 , Pins("T3" ), IOStandard("LVCMOS33")),
    ("user_sw" , 10, Pins("T2" ), IOStandard("LVCMOS33")),
    ("user_sw" , 11, Pins("R3" ), IOStandard("LVCMOS33")),
    ("user_sw" , 12, Pins("W2" ), IOStandard("LVCMOS33")),
    ("user_sw" , 13, Pins("U1" ), IOStandard("LVCMOS33")),
    ("user_sw" , 14, Pins("T1" ), IOStandard("LVCMOS33")),
    ("user_sw" , 15, Pins("R2" ), IOStandard("LVCMOS33")),
    ("user_btn",  0, Pins("U18"), IOStandard("LVCMOS33")),
    ("user_btn",  1, Pins("T18"), IOStandard("LVCMOS33")),
    ("user_btn",  2, Pins("W19"), IOStandard("LVCMOS33")),
    ("user_btn",  3, Pins("T17"), IOStandard("LVCMOS33")),
    ("user_btn",  4, Pins("U17"), IOStandard("LVCMOS33")),
    ("clk100"  ,  0, Pins("W5" ), IOStandard("LVCMOS33")),

    #SPI_TFT-JA
    ("TFT_CS"  ,  0, Pins("J1" ), IOStandard("LVCMOS33")),
    ("TFT_RST" ,  0, Pins("L2" ), IOStandard("LVCMOS33")),
    ("TFT_RS"  ,  0, Pins("J2" ), IOStandard("LVCMOS33")),
    ("TFT_MOSI",  0, Pins("G2" ), IOStandard("LVCMOS33")),
    ("TFT_CLK" ,  0, Pins("H1" ), IOStandard("LVCMOS33"))

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
SystemClock = ClockSignal()
leds        = Cat(*[platform.request("user_led", i) for i in range(16)])
switches    = Cat(*[platform.request("user_sw" , i) for i in range(16)])
buttons     = Cat(*[platform.request("user_btn", i) for i in range(5) ])
TFT_CLK     = platform.request("TFT_CLK" , 0)
TFT_MOSI    = platform.request("TFT_MOSI", 0)
TFT_RS      = platform.request("TFT_RS"  , 0)
TFT_RST     = platform.request("TFT_RST" , 0)
TFT_CS      = platform.request("TFT_CS"  , 0)
#.......................................................................


#-----------------------------------------------------------------------
# DISEÑO
#


# Adicion de modulos en verilog
#	TFT_SPI
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/TFT_SPI.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/InitializationRegister.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/SPI.v")

#	utilities
platform.add_source("Hardware/utilities/FrequencyGenerator.v")
platform.add_source("Hardware/utilities/Counter.v")
platform.add_source("Hardware/utilities/ButtonDebouncer.v")
platform.add_source("Hardware/utilities/ButtonDebouncerTester.v")


# Modulo Principal
class SOC(Module):
    def __init__(self):

        self.Leds        = Signal(16)
        self.switches    = Signal(16)
        self.SystemClock = Signal()
        self.TFT_MOSI    = Signal()
        self.TFT_CLK     = Signal()
        self.TFT_RS      = Signal()
        self.TFT_RST     = Signal()
        self.TFT_CS      = Signal()

        self.specials +=Instance("TFT_SPI",
            i_data       = self.switches,
            i_MasterCLK  = self.SystemClock,
            o_SPI_MOSI   = self.TFT_MOSI,
            o_SPI_CLK    = self.TFT_CLK,
            o_SPI_CS     = self.TFT_CS,
            o_RS         = self.TFT_RS,
            o_RST        = self.TFT_RST,
            o_OutputData = self.Leds
        )
        
        self.comb +=leds.eq(self.Leds)
        self.comb +=self.switches.eq(switches)
        self.comb +=self.SystemClock.eq(SystemClock)
        self.comb +=TFT_MOSI.eq(self.TFT_MOSI)
        self.comb +=TFT_CLK.eq(self.TFT_CLK)
        self.comb +=TFT_CS.eq(self.TFT_CS)
        self.comb +=TFT_RS.eq(self.TFT_RS)
        self.comb +=TFT_RST.eq(self.TFT_RST)





#------------------------------------------------------------------------
# Sintetizacion de Modulo Principal
#
soc = SOC()
platform.build(soc)
