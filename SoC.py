#!/usr/bin/python3
#
#Llamado a migen 
#-----------------------------------------------------------------------	
from migen import *

from migen.genlib.io import CRG

from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform

from litex.soc.integration.soc_core import *
from litex.soc.integration.builder import *
from Hardware.Video import Video
from Hardware.Audio import Audio
from Hardware.Buttons import Buttons
from litex.soc.cores import gpio
##from ios import Led


#-----------------------------------------------------------------------
# Definicion de Pines
#
_io = [
    ("user_led"                 , 0 , Pins("U16"), IOStandard("LVCMOS33")),
    ("user_led"                 , 1 , Pins("E19"), IOStandard("LVCMOS33")),
    ("user_led"                 , 2 , Pins("U19"), IOStandard("LVCMOS33")),
    ("user_led"                 , 3 , Pins("V19"), IOStandard("LVCMOS33")),
    ("user_led"                 , 4 , Pins("W18"), IOStandard("LVCMOS33")),
    ("user_led"                 , 5 , Pins("U15"), IOStandard("LVCMOS33")),
    ("user_led"                 , 6 , Pins("U14"), IOStandard("LVCMOS33")),
    ("user_led"                 , 7 , Pins("V14"), IOStandard("LVCMOS33")),
    ("user_led"                 , 8 , Pins("V13"), IOStandard("LVCMOS33")),
    ("user_led"                 , 9 , Pins("V3" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 10, Pins("W3" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 11, Pins("U3" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 12, Pins("P3" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 13, Pins("N3" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 14, Pins("P1" ), IOStandard("LVCMOS33")),
    ("user_led"                 , 15, Pins("L1" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 0 , Pins("V17"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 1 , Pins("V16"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 2 , Pins("W16"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 3 , Pins("W17"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 4 , Pins("W15"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 5 , Pins("V15"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 6 , Pins("W14"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 7 , Pins("W13"), IOStandard("LVCMOS33")),
    ("user_sw"                  , 8 , Pins("V2" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 9 , Pins("T3" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 10, Pins("T2" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 11, Pins("R3" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 12, Pins("W2" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 13, Pins("U1" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 14, Pins("T1" ), IOStandard("LVCMOS33")),
    ("user_sw"                  , 15, Pins("R2" ), IOStandard("LVCMOS33")),    
    ("user_btn"                 , 0 , Pins("T18"), IOStandard("LVCMOS33")),
    ("user_btn"                 , 1 , Pins("W19"), IOStandard("LVCMOS33")),
    ("user_btn"                 , 2 , Pins("T17"), IOStandard("LVCMOS33")),
    ("user_btn"                 , 3 , Pins("U17"), IOStandard("LVCMOS33")),
    ("clk100"                   , 0 , Pins("W5" ), IOStandard("LVCMOS33")),
    ("cpu_reset"                , 0 , Pins("U18"), IOStandard("LVCMOS33")),

    #I2S-JB
    ("DAC_I2S_WS"               , 0 , Pins("A14"), IOStandard("LVCMOS33")),
    ("DAC_I2S_DATA"             , 0 , Pins("A16"), IOStandard("LVCMOS33")),
    ("DAC_I2S_CLK"              , 0 , Pins("B15"), IOStandard("LVCMOS33")),
    
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

    ("serial", 0,
        Subsignal("tx", Pins("A18")),
        Subsignal("rx", Pins("B18")),
        IOStandard("LVCMOS33"),
    ),
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
        
def csr_map_update(csr_map, csr_peripherals):
    csr_map.update(dict((n, v)
        for v, n in enumerate(csr_peripherals, start=max(csr_map.values()) + 1)))

#----------------------------------------------------------------------
#Creacion de Plataforma
platform = Platform()
#Definicion de pines como variables

leds                   = Cat(*[platform.request("user_led", i) for i in range(16) ])
switches               = Cat(*[platform.request("user_sw" , i) for i in range(16)])
buttons                = Cat(*[platform.request("user_btn", i) for i in range(4) ])
SystemClock            = ClockSignal()
#Reset                  = platform.request("cpu_reset"              , 0)
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
#   Buttons
platform.add_source("Hardware/Peripheral_Buttons/Buttons.v")
#   Video
platform.add_source("Hardware/Peripheral_Video/Video.v")
platform.add_source("Hardware/Peripheral_Video/ColorDecoder.v")
platform.add_source("Hardware/Peripheral_Video/VideoData.mem")
platform.add_source("Hardware/Peripheral_Video/InitialPosition.mem")
platform.add_source("Hardware/Peripheral_Video/Video_ClockManager.v")
#  Audio
platform.add_source("Hardware/Peripheral_Audio/Audio.v")
platform.add_source("Hardware/Peripheral_Audio/Audio_ClockManager.v")
platform.add_source("Hardware/Peripheral_Audio/Synthesizer.v")
platform.add_source("Hardware/Peripheral_Audio/Oscillator.v")
#	I2S
platform.add_source("Hardware/Peripheral_Audio/SubPeripheral_I2S/I2S.v")
platform.add_source("Hardware/Peripheral_Audio/SubPeripheral_I2S/SquareGenerator.v")
#	TFT_SPI
platform.add_source("Hardware/Peripheral_Video/SubPeripheral_TFT_SPI/TFT_SPI.v")
platform.add_source("Hardware/Peripheral_Video/SubPeripheral_TFT_SPI/InitializationRegister.v")
platform.add_source("Hardware/Peripheral_Video/SubPeripheral_TFT_SPI/SPI.v")


#	utilities

platform.add_source("Hardware/utilities/FrequencyGenerator.v")
platform.add_source("Hardware/utilities/Counter.v")
platform.add_source("Hardware/utilities/ButtonDebouncer.v")
platform.add_source("Hardware/utilities/StereoSignedAdder.v")




# Modulo Principal
class SoC(SoCCore):
    csr_peripherals = [         
        "Video_WB",
        "Audio_WB",
        "Buttons_WB",
    ]    
    
    csr_map_update(SoCCore.csr_map, csr_peripherals)
    

    def __init__(self, platform):
        interrupt_map= {
            'Buttons_WB': 7,
        }
        SoCCore.interrupt_map.update(interrupt_map)

        sys_clk_freq = int(100e6)
        # SoC with CPU
        SoCCore.__init__(self, platform,
            csr_data_width=32,
            cpu_type="lm32",
            clk_freq=100e6,
            ident="CPU Test SoC", ident_version=True,
            integrated_rom_size=0x8000,
            integrated_main_ram_size=16*1024)


        
        #self.submodules.Buttons = gpio.GPIOIn(buttons)
        self.submodules.crg         = CRG(platform.request("clk100"),platform.request("cpu_reset"))

        self.submodules.Video_WB    = Video()
        self.submodules.Audio_WB    = Audio()
        self.submodules.Buttons_WB  = Buttons()         

        self.CLK                    = Signal()
        self.Reset                  = Signal()        
        
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


         
        self.comb += [
            
            self.Buttons_WB.CLK.eq(SystemClock),
            self.Buttons_WB.Buttons.eq(buttons),
            self.Video_WB.CLK.eq(SystemClock),            
            self.Video_WB.Reset.eq(self.Reset), 
           

            TFT_SPI_MOSI.eq(self.Video_WB.TFT_SPI_MOSI),
            TFT_SPI_CLK.eq(self.Video_WB.TFT_SPI_CLK),
            TFT_SPI_CS.eq(self.Video_WB.TFT_SPI_CS),
            TFT_RS.eq(self.Video_WB.TFT_RS),
            TFT_RST.eq(self.Video_WB.TFT_RST),

            self.Audio_WB.CLK.eq(SystemClock),            
            self.Audio_WB.Reset.eq(self.Reset), 
            
            SD_SPI_MOSI.eq(self.Audio_WB.SD_SPI_MOSI),
            SD_SPI_CLK.eq(self.Audio_WB.SD_SPI_CLK),
            SD_SPI_CS.eq(self.Audio_WB.SD_SPI_CS),
            self.Audio_WB.SD_SPI_MISO.eq(SD_SPI_MISO),      
            SD_SPI_COUNT_DEBUG.eq(self.Audio_WB.SD_SPI_COUNT_DEBUG),        
            SD_SPI_UTILCOUNT_DEBUG.eq(self.Audio_WB.SD_SPI_UTILCOUNT_DEBUG),

            DAC_I2S_DATA.eq(self.Audio_WB.DAC_I2S_DATA),
            DAC_I2S_WS.eq(self.Audio_WB.DAC_I2S_WS),
            DAC_I2S_CLK.eq(self.Audio_WB.DAC_I2S_CLK)
        
  
        ]
  
#------------------------------------------------------------------------
# Sintetizacion de Modulo Principal
#
soc = SoC(platform)

#
# build
#
builder = Builder(soc, output_dir="build", csr_csv="MemoryMap.csv")
builder.build()


