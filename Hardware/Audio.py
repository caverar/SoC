#!/usr/bin/python3

#
#Llamado a migen 
#-----------------------------------------------------------------------	


from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform
from litex.soc.interconnect.csr import *




# Modulo Principal
class Audio(Module,AutoCSR):
    def __init__(self):
    ##Entradas        
        self.CLK                    = Signal()
        self.Reset                  = Signal()
    ##Salidas
        self.DAC_I2S_CLK            = Signal()
        self.DAC_I2S_DATA           = Signal()
        self.DAC_I2S_WS             = Signal()
    ##Valores Internos        
        self.AudioControlRegisterCSR = CSRStorage(4)
        self.AudioControlRegister    = Signal(4)
    ##Instancia
        self.specials +=Instance("Audio",

            i_Reset                  = self.Reset,
            i_CLK                    = self.CLK,                   
            i_AudioControlRegister  =  self.AudioControlRegister,            
            o_DAC_I2S_DATA           = self.DAC_I2S_DATA,
            o_DAC_I2S_CLK            = self.DAC_I2S_CLK,  
            o_DAC_I2S_WS             = self.DAC_I2S_WS    
        )
                
        self.comb += self.AudioControlRegister.eq(self.AudioControlRegisterCSR.storage)
        

# Testeo
#-----------------------------------------------------------------------
# Definicion de Pines
#
_io = [
    
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
    ("clk100"     , 0 , Pins("W5" ), IOStandard("LVCMOS33")),
    ("cpu_reset"  , 0 , Pins("U18"), IOStandard("LVCMOS33")),

    #I2S-JB
    ("I2S_WS"     , 0 , Pins("A14"), IOStandard("LVCMOS33")),
    ("I2S_DATA"   , 0 , Pins("A16"), IOStandard("LVCMOS33")),
    ("I2S_CLK"    , 0 , Pins("B15"), IOStandard("LVCMOS33"))

]

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

switches       = Cat(*[platform.request("user_sw" , i) for i in range(16)])
I2S_DATA       = platform.request("I2S_DATA" , 0)
I2S_CLK        = platform.request("I2S_CLK"  , 0)
I2S_WS         = platform.request("I2S_WS"   , 0)
Reset          = platform.request("cpu_reset", 0)


platform.add_source("Hardware/Peripheral_Audio/SubPeripheral_I2S/I2S.v")
platform.add_source("Hardware/Peripheral_Audio/SubPeripheral_I2S/SquareGenerator.v")
platform.add_source("Hardware/Peripheral_Audio/Audio_ClockManager.v")
platform.add_source("Hardware/Peripheral_Audio/Synthesizer.v")
platform.add_source("Hardware/Peripheral_Audio/Oscillator.v")
platform.add_source("Hardware/Peripheral_Audio/Audio.v")
#	utilities

platform.add_source("Hardware/utilities/FrequencyGenerator.v")
platform.add_source("Hardware/utilities/StereoSignedAdder.v")
platform.add_source("Hardware/utilities/Counter.v")


soc = Audio()

soc.comb+=I2S_DATA.eq(soc.DAC_I2S_DATA)
soc.comb+=I2S_CLK.eq(soc.DAC_I2S_CLK)
soc.comb+=I2S_WS.eq(soc.DAC_I2S_WS)
soc.comb+=soc.CLK.eq(SystemClock)
soc.comb+=soc.Reset.eq(Reset)
soc.comb+=soc.AudioControlRegisterCSR.storage.eq(0x8)

platform.build(soc)
