#!/usr/bin/python3

#
#Llamado a migen 
#-----------------------------------------------------------------------	
from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform
from litex.soc.interconnect.csr import *


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
    ("user_btn"   , 0 , Pins("T18"), IOStandard("LVCMOS33")),
    ("user_btn"   , 1 , Pins("W19"), IOStandard("LVCMOS33")),
    ("user_btn"   , 2 , Pins("T17"), IOStandard("LVCMOS33")),
    ("user_btn"   , 3 , Pins("U17"), IOStandard("LVCMOS33")),
    ("clk100"     , 0 , Pins("W5" ), IOStandard("LVCMOS33")),
    ("Reset"      , 0 , Pins("U18"), IOStandard("LVCMOS33")),

    #I2S-JB
    ("DAC_I2S_WS"             , 0 , Pins("A14"), IOStandard("LVCMOS33")),
    ("DAC_I2S_DATA"           , 0 , Pins("A16"), IOStandard("LVCMOS33")),
    ("DAC_I2S_CLK"            , 0 , Pins("B15"), IOStandard("LVCMOS33")),
    
    #SPI_TFT-JA
    ("TFT_SPI_CS"             , 0 , Pins("J1" ), IOStandard("LVCMOS33")),
    ("TFT_RST"                , 0 , Pins("L2" ), IOStandard("LVCMOS33")),
    ("TFT_RS"                 , 0 , Pins("J2" ), IOStandard("LVCMOS33")),
    ("TFT_SPI_MOSI"           , 0 , Pins("G2" ), IOStandard("LVCMOS33")),
    ("TFT_SPI_CLK"            , 0 , Pins("H1" ), IOStandard("LVCMOS33")),

    #SD_SPI_SPI-JC
    ("SD_SPI_MISO"            , 0 , Pins("K17"), IOStandard("LVCMOS33")),
    ("SD_SPI_MOSI"            , 0 , Pins("M18"), IOStandard("LVCMOS33")),
    ("SD_SPI_CLK"             , 0 , Pins("N17"), IOStandard("LVCMOS33")),
    ("SD_SPI_CS"              , 0 , Pins("P18"), IOStandard("LVCMOS33")),
    ("SD_SPI_COUNT_DEBUG"     , 0 , Pins("L17"), IOStandard("LVCMOS33")),
    ("SD_SPI_UTILCOUNT_DEBUG" , 0 , Pins("M19"), IOStandard("LVCMOS33")),
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

leds                   = Cat(*[platform.request("user_led", i) for i in range(16) ])
switches               = Cat(*[platform.request("user_sw" , i) for i in range(16)])
buttons                = Cat(*[platform.request("user_btn", i) for i in range(4) ])
SystemClock            = ClockSignal()
Reset                  = platform.request("Reset"                  , 0)
DAC_I2S_DATA           = platform.request("DAC_I2S_DATA"           , 0)
DAC_I2S_CLK            = platform.request("DAC_I2S_CLK"            , 0)
DAC_I2S_WS             = platform.request("DAC_I2S_WS"             , 0)
SD_SPI_CLK             = platform.request("SD_SPI_CLK"             , 0)
SD_SPI_MOSI            = platform.request("SD_SPI_MOSI"            , 0)
SD_SPI_MISO            = platform.request("SD_SPI_MISO"            , 0)
SD_SPI_CS              = platform.request("SD_SPI_CS"              , 0)
SD_SPI_COUNT_DEBUG     = platform.request("SD_SPI_COUNT_DEBUG"     , 0)
SD_SPI_UTILCOUNT_DEBUG = platform.request("SD_SPI_UTILCOUNT_DEBUG" , 0)
TFT_SPI_CLK            = platform.request("TFT_SPI_CLK"            , 0)
TFT_SPI_MOSI           = platform.request("TFT_SPI_MOSI"           , 0)
TFT_RS                 = platform.request("TFT_RS"                 , 0)
TFT_RST                = platform.request("TFT_RST"                , 0)
TFT_SPI_CS             = platform.request("TFT_SPI_CS"             , 0)

#.......................................................................


#-----------------------------------------------------------------------
# DISEÑO
#


# Adicion de modulos en verilog
#   AudVid
platform.add_source("Hardware/Peripheral_AudVid/AudVid.v")
platform.add_source("Hardware/Peripheral_AudVid/ColorDecoder.v")
#	I2S
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_I2S/I2S.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_I2S/SquareGenerator.v")
#	TFT_SPI
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/TFT_SPI.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/InitializationRegister.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_TFT_SPI/SPI.v")
#	SD_SPI_SPI
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/SD_SPI.v")
platform.add_source("Hardware/Peripheral_AudVid/SubPeripheral_SD_SPI/FullSPI.v")
#	utilities
platform.add_source("utilities/ClockManager.v")
platform.add_source("utilities/FrequencyGenerator.v")
platform.add_source("utilities/Counter.v")
platform.add_source("utilities/ButtonDebouncer.v")
platform.add_source("utilities/ButtonDebouncerTester.v")


# Modulo Principal
class SOC(Module,AutoCSR):
    def __init__(self):

        self.SystemClock            = Signal()
        self.MasterCLK              = Signal()
        self.Reset                  = Signal()
        self.I2SCLK                 = Signal()
        self.TFT_WorkCLK            = Signal()
        self.SD_WorkCLK             = Signal()
        
        self.DAC_I2S_CLK            = Signal()
        self.DAC_I2S_DATA           = Signal()
        self.DAC_I2S_WS             = Signal()

        self.TFT_SPI_MOSI           = Signal()
        self.TFT_SPI_CLK            = Signal()
        self.TFT_RS                 = Signal()
        self.TFT_RST                = Signal()
        self.TFT_SPI_CS             = Signal()

        self.SD_SPI_MOSI            = Signal()
        self.SD_SPI_MISO            = Signal()
        self.SD_SPI_CLK             = Signal()
        self.SD_SPI_CS              = Signal()
        self.SD_SPI_COUNT_DEBUG     = Signal() 
        self.SD_SPI_UTILCOUNT_DEBUG = Signal()

        self.TilesPositionData      = Signal(5)
        self.TilesPositionAddress   = Signal(9)


        
        self.specials +=Instance("ClockManager",
            i_InputCLK  = self.SystemClock,
            o_MasterCLK = self.MasterCLK,
            o_I2SCLK    = self.I2SCLK,
            o_TFTCLK    = self.TFT_WorkCLK,
            o_SDCLK     = self.SD_WorkCLK 
        )

        self.specials +=Instance("AudVid",

            i_Reset                  = self.Reset,
            i_MasterCLK              = self.MasterCLK,  
            i_I2SCLK                 = self.I2SCLK,                 
            i_TilesPositionData      = self.TilesPositionData,      ## [4:0]
            i_TilesPositionAddress   = self.TilesPositionAddress,   ## [8:0]    
            i_TFT_WorkCLK            = self.TFT_WorkCLK,
            o_TFT_SPI_CLK            = self.TFT_SPI_CLK,
            o_TFT_SPI_CS             = self.TFT_SPI_CS,
            o_TFT_SPI_MOSI           = self.TFT_SPI_MOSI,
            o_TFT_RST                = self.TFT_RST,
            o_TFT_RS                 = self.TFT_RS,
            i_SD_WorkCLK             = self.SD_WorkCLK,
            o_SD_SPI_CLK             = self.SD_SPI_CLK,
            o_SD_SPI_CS              = self.SD_SPI_CS,    
            o_SD_SPI_MOSI            = self.SD_SPI_MOSI,
            i_SD_SPI_MISO            = self.SD_SPI_MISO,
            o_SD_SPI_COUNT_DEBUG     = self.SD_SPI_COUNT_DEBUG,
            o_SD_SPI_UTILCOUNT_DEBUG = self.SD_SPI_UTILCOUNT_DEBUG,
            o_DAC_I2S_DATA           = self.DAC_I2S_DATA,
            o_DAC_I2S_CLK            = self.DAC_I2S_CLK,  
            o_DAC_I2S_WS             = self.DAC_I2S_WS

    
        )
        
        
        self.comb += self.Reset.eq(Reset)


        #self.comb +=leds.eq(self.Leds)
        #self.comb +=self.switches.eq(switches)
        self.comb +=self.SystemClock.eq(SystemClock)

        self.comb +=TFT_SPI_MOSI.eq(self.TFT_SPI_MOSI)
        self.comb +=TFT_SPI_CLK.eq(self.TFT_SPI_CLK)
        self.comb +=TFT_SPI_CS.eq(self.TFT_SPI_CS)
        self.comb +=TFT_RS.eq(self.TFT_RS)
        self.comb +=TFT_RST.eq(self.TFT_RST)

        
        self.comb += SD_SPI_MOSI.eq(self.SD_SPI_MOSI)
        self.comb += SD_SPI_CLK.eq(self.SD_SPI_CLK)
        self.comb += SD_SPI_CS.eq(self.SD_SPI_CS)
        self.comb += self.SD_SPI_MISO.eq(SD_SPI_MISO)        
        self.comb += SD_SPI_COUNT_DEBUG.eq(self.SD_SPI_COUNT_DEBUG)        
        self.comb += SD_SPI_UTILCOUNT_DEBUG.eq(self.SD_SPI_UTILCOUNT_DEBUG)

        self.comb += DAC_I2S_DATA.eq(self.DAC_I2S_DATA)
        self.comb += DAC_I2S_WS.eq(self.DAC_I2S_WS)
        self.comb += DAC_I2S_CLK.eq(self.DAC_I2S_CLK)

 


        
       



#------------------------------------------------------------------------
# Sintetizacion de Modulo Principal
#
soc = SOC()
platform.build(soc)
