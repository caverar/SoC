from migen import *
from migen.build.generic_platform import *
from migen.build.xilinx import XilinxPlatform
from litex.soc.interconnect.csr import *
from litex.soc.interconnect.csr_eventmanager import *



# Modulo Principal
class SD(Module,AutoCSR):
    def __init__(self):

        self.submodules.ev = EventManager()
        self.ev.DataClock  = EventSourceProcess() 
        #EventSourcePulse()
    ##Entradas        
        self.CLK                        = Signal()
        self.Reset                      = Signal()
        self.SD_SPI_MISO                = Signal()
    ##Salidas
        self.SD_SPI_MOSI                = Signal()
        self.SD_SPI_CLK                 = Signal()
        self.SD_SPI_CS                  = Signal()
    ##Valores Internos        
        
        self.EnableDataWriteRegister    = CSRStorage()
        self.OuputDataRegister          = CSRStorage(8)
        self.SPI_EnableRegister         = CSRStorage()
        self.SPI_EnableCSRegister       = CSRStorage()


        self.InputDataRegisterCSR       = CSRStatus(8)
        self.DataClockRegisterCSR       = CSRStatus()       
        self.InputDataRegister          = Signal(8)
        self.DataClockRegister          = Signal()
      
    ##Instancia
       
        self.specials +=Instance("SD",
            i_MasterCLK                 = self.CLK,    
            i_Reset                     = self.Reset,
            i_SPI_MISO                  = self.SD_SPI_MISO,
            o_SPI_MOSI                  = self.SD_SPI_MOSI,
            o_SPI_CLK                   = self.SD_SPI_CLK,
            o_SPI_CS                    = self.SD_SPI_CS,            
            o_DataClockRegister         = self.DataClockRegister,
            o_InputDataRegister         = self.InputDataRegister,    
            i_OuputDataRegister         = self.OuputDataRegister.storage, 
            i_SPI_EnableRegister        = self.SPI_EnableRegister.storage,
            i_SPI_EnableCSRegister      = self.SPI_EnableCSRegister.storage 

        )
        self.comb +=[
            self.InputDataRegisterCSR.status.eq(self.InputDataRegister),
            self.DataClockRegisterCSR.status.eq(self.DataClockRegister),
            self.ev.DataClock.trigger.eq( self.DataClockRegister==1)            
        ]
        

# Testeo
#-----------------------------------------------------------------------
# Definicion de Pines
#
# _io = [
    
#     ("user_sw"    , 0 , Pins("V17"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 1 , Pins("V16"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 2 , Pins("W16"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 3 , Pins("W17"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 4 , Pins("W15"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 5 , Pins("V15"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 6 , Pins("W14"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 7 , Pins("W13"), IOStandard("LVCMOS33")),
#     ("user_sw"    , 8 , Pins("V2" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 9 , Pins("T3" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 10, Pins("T2" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 11, Pins("R3" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 12, Pins("W2" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 13, Pins("U1" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 14, Pins("T1" ), IOStandard("LVCMOS33")),
#     ("user_sw"    , 15, Pins("R2" ), IOStandard("LVCMOS33")),
#     ("clk100"     , 0 , Pins("W5" ), IOStandard("LVCMOS33")),
#     ("cpu_reset"  , 0 , Pins("U18"), IOStandard("LVCMOS33")),

#     #SD_SPI-JXADC
#     ("SD_SPI_CS"        , 0 , Pins("J3" ), IOStandard("LVCMOS33")),
#     ("SD_SPI_CLK"       , 0 , Pins("L3" ), IOStandard("LVCMOS33")),
#     ("SD_SPI_MOSI"      , 0 , Pins("M2" ), IOStandard("LVCMOS33")),
#     ("SD_SPI_MISO"      , 0 , Pins("N2" ), IOStandard("LVCMOS33")),

# ]

# class Platform(XilinxPlatform):
#     default_clk_name = "clk100"
#     default_clk_period = 10.0

#     def __init__(self):
#         XilinxPlatform.__init__(self, "xc7a35tcpg236-1", _io, toolchain="vivado")

#     def do_finalize(self, fragment):
#         XilinxPlatform.do_finalize(self, fragment)

#  #----------------------------------------------------------------------
# #Creacion de Plataforma
# platform    = Platform()
# #Definicion de pines como variables
# SystemClock = ClockSignal()

# switches    = Cat(*[platform.request("user_sw" , i) for i in range(16)])
# SD_SPI_CS   = platform.request("SD_SPI_CS"   , 0)
# SD_SPI_CLK  = platform.request("SD_SPI_CLK"  , 0)
# SD_SPI_MOSI = platform.request("SD_SPI_MOSI" , 0)
# SD_SPI_MISO = platform.request("SD_SPI_MISO" , 0)
# Reset       = platform.request("cpu_reset", 0)


# platform.add_source("Hardware/Peripheral_SD/SD.v")
# platform.add_source("Hardware/Peripheral_SD/FullSPI.v")

# #	utilities

# platform.add_source("Hardware/utilities/FrequencyGenerator.v")



# soc = SD()

# soc.comb +=[
#     SD_SPI_CS.eq(soc.SD_SPI_CS),
#     SD_SPI_CLK.eq(soc.SD_SPI_CLK),
#     SD_SPI_MOSI.eq(soc.SD_SPI_MOSI),
#     soc.SD_SPI_MISO.eq(SD_SPI_MISO),
#     soc.CLK.eq(SystemClock),
#     soc.Reset.eq(Reset),
#     soc.SPI_EnableRegister.storage.eq(1)
# ] 

# platform.build(soc)