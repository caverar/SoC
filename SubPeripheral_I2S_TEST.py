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
    ("user_led"   , 0 , Pins("U16"), IOStandard("LVCMOS33")),
    ("user_led"   , 1 , Pins("E19"), IOStandard("LVCMOS33")),
    ("user_led"   , 2 , Pins("U19"), IOStandard("LVCMOS33")),
    ("user_led"   , 3 , Pins("V19"), IOStandard("LVCMOS33")),
    ("user_led"   , 4 , Pins("W18"), IOStandard("LVCMOS33")),
    ("user_led"   , 5 , Pins("U15"), IOStandard("LVCMOS33")),
    ("user_led"   , 6 , Pins("U14"), IOStandard("LVCMOS33")),
    ("user_led"   , 7 , Pins("V14"), IOStandard("LVCMOS33")),
    ("user_led"   , 8 , Pins("V13"), IOStandard("LVCMOS33")),
    ("user_led"   , 9 , Pins("V3" ), IOStandard("LVCMOS33")),
    ("user_led"   , 10, Pins("W3" ), IOStandard("LVCMOS33")),
    ("user_led"   , 11, Pins("U3" ), IOStandard("LVCMOS33")),
    ("user_led"   , 12, Pins("P3" ), IOStandard("LVCMOS33")),
    ("user_led"   , 13, Pins("N3" ), IOStandard("LVCMOS33")),
    ("user_led"   , 14, Pins("P1" ), IOStandard("LVCMOS33")),
    ("user_led"   , 15, Pins("L1" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 0 , Pins("V17"), IOStandard("LVCMOS33")),
    ("user_sw"    , 1 , Pins("V16"), IOStandard("LVCMOS33")),
    ("user_sw"    , 2 , Pins("W16"), IOStandard("LVCMOS33")),
    ("user_sw"    , 3 , Pins("W17"), IOStandard("LVCMOS33")),
    ("user_sw"    , 4 , Pins("W15"), IOStandard("LVCMOS33")),
    ("user_sw"    , 5 , Pins("V15"), IOStandard("LVCMOS33")),
    ("user_sw"    , 6 , Pins("W14"), IOStandard("LVCMOS33")),
    ("user_sw"    , 7 , Pins("W13"), IOStandard("LVCMOS33")),
    ("user_sw"    , 8 , Pins("V2" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 9 , Pins("T3" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 10, Pins("T2" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 11, Pins("R3" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 12, Pins("W2" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 13, Pins("U1" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 14, Pins("T1" ), IOStandard("LVCMOS33")),
    ("user_sw"    , 15, Pins("R2" ), IOStandard("LVCMOS33")),
    ("user_btn"   , 0 , Pins("U18"), IOStandard("LVCMOS33")),
    ("user_btn"   , 1 , Pins("T18"), IOStandard("LVCMOS33")),
    ("user_btn"   , 2 , Pins("W19"), IOStandard("LVCMOS33")),
    ("user_btn"   , 3 , Pins("T17"), IOStandard("LVCMOS33")),
    ("user_btn"   , 4 , Pins("U17"), IOStandard("LVCMOS33")),
    ("clk100"     , 0 , Pins("W5" ), IOStandard("LVCMOS33")),

    #I2S-JB
    ("I2S_WS"     , 0 , Pins("A14"), IOStandard("LVCMOS33")),
    ("I2S_DATA"   , 0 , Pins("A16"), IOStandard("LVCMOS33")),
    ("I2S_CLK"    , 0 , Pins("B15"), IOStandard("LVCMOS33"))

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
SystemClock    = ClockSignal()
leds           = Cat(*[platform.request("user_led", i) for i in range(1) ])
switches       = Cat(*[platform.request("user_sw" , i) for i in range(16)])
buttons        = Cat(*[platform.request("user_btn", i) for i in range(5) ])
I2S_DATA       = platform.request("I2S_DATA" , 0)
I2S_CLK        = platform.request("I2S_CLK"  , 0)
I2S_WS         = platform.request("I2S_WS"   , 0)

#.......................................................................


#-----------------------------------------------------------------------
# DISEÑO
#


# Adicion de modulos en verilog
#	I2S
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_I2S/I2S.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_I2S/SquareGenerator.v")

#	utilities
platform.add_source("utilities/ClockManager.v")
platform.add_source("utilities/FrequencyGenerator.v")
platform.add_source("utilities/Counter.v")
platform.add_source("utilities/ButtonDebouncer.v")
platform.add_source("utilities/ButtonDebouncerTester.v")


# Modulo Principal
class SOC(Module):
    def __init__(self):

        self.SystemClock = Signal()
        self.MasterCLK   = Signal()
        self.I2SCLK      = Signal()
        self.I2S_CLK     = Signal()
        self.I2S_DATA    = Signal()
        self.I2S_WS      = Signal()
        self.I2S_CLK     = Signal()


        self.specials +=Instance("ClockManager",
            i_InputCLK  = self.SystemClock,
            o_MasterCLK = self.MasterCLK,
            o_I2SCLK    = self.I2SCLK
        )

        self.specials +=Instance("I2S",

            i_MasterCLK= self.MasterCLK,
            i_I2SCLK   = self.I2SCLK,
            o_I2S_DATA = self.I2S_DATA,
            o_I2S_WS   = self.I2S_WS,
            o_I2S_CLK  = self.I2S_CLK,
        )
        

        self.comb +=self.SystemClock.eq(SystemClock)
        self.comb +=I2S_DATA.eq(self.I2S_DATA)
        self.comb +=I2S_WS.eq(self.I2S_WS)
        self.comb +=I2S_CLK.eq(self.I2S_CLK)
        self.comb +=leds.eq(self.I2SCLK)
 


        
       



#------------------------------------------------------------------------
# Sintetizacion de Modulo Principal
#
soc = SOC()
platform.build(soc)
