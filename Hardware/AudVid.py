#!/usr/bin/python3

#
#Llamado a migen 
#-----------------------------------------------------------------------	
from migen import *
from litex.soc.interconnect.csr import *




# Modulo Principal
class AudVid(Module,AutoCSR):
    def __init__(self):
    ##Entradas
        
        self.CLK                    = Signal()
        self.Reset                  = Signal()

        ##SD    
        self.SD_SPI_MISO            = Signal()

    ##Salidas

        self.SD_SPI_MOSI            = Signal()        
        self.SD_SPI_CLK             = Signal()
        self.SD_SPI_CS              = Signal()
        self.SD_SPI_COUNT_DEBUG     = Signal() 
        self.SD_SPI_UTILCOUNT_DEBUG = Signal()

        ##DAC 

        self.DAC_I2S_CLK            = Signal()
        self.DAC_I2S_DATA           = Signal()
        self.DAC_I2S_WS             = Signal()

        ##TFT

        self.TFT_SPI_MOSI           = Signal()
        self.TFT_SPI_CLK            = Signal()
        self.TFT_RS                 = Signal()
        self.TFT_RST                = Signal()
        self.TFT_SPI_CS             = Signal()

       
    ##Valores Internos
        self.TilesControlRegisterCSR  = CSRStorage(14)   ##[13:5] Pisicion Tile [4:1] Tile
        self.TilesControlRegister     = Signal(14)
 
        self.Track1ControlRegisterCSR = CSRStorage(5)
        self.Track1ControlRegister    = Signal(5)
        self.Track2ControlRegisterCSR = CSRStorage(5)
        self.Track2ControlRegister    = Signal(5)

        

        self.specials +=Instance("AudVid",

            i_Reset                  = self.Reset,
            i_CLK                    = self.CLK,                   
            i_TilesControlRegister   = self.TilesControlRegister,
            i_Track1ControlRegister  = self.Track1ControlRegister,
            i_Track2ControlRegister  = self.Track2ControlRegister,             
            o_TFT_SPI_CLK            = self.TFT_SPI_CLK,
            o_TFT_SPI_CS             = self.TFT_SPI_CS,
            o_TFT_SPI_MOSI           = self.TFT_SPI_MOSI,
            o_TFT_RST                = self.TFT_RST,
            o_TFT_RS                 = self.TFT_RS,            
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
        
        self.comb += self.TilesControlRegister.eq(self.TilesControlRegisterCSR.storage)
        self.comb += self.Track1ControlRegister.eq(self.Track1ControlRegisterCSR.storage)
        self.comb += self.Track2ControlRegister.eq(self.Track2ControlRegisterCSR.storage)  
