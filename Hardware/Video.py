#!/usr/bin/python3

#
#Llamado a migen 
#-----------------------------------------------------------------------	
from migen import *
from litex.soc.interconnect.csr import *




# Modulo Principal
class Video(Module,AutoCSR):
    def __init__(self):
    ##Entradas
        
        self.CLK                    = Signal()
        self.Reset                  = Signal()      

    ##Salidas        
        
        ##TFT

        self.TFT_SPI_MOSI           = Signal()
        self.TFT_SPI_CLK            = Signal()
        self.TFT_RS                 = Signal()
        self.TFT_RST                = Signal()
        self.TFT_SPI_CS             = Signal()

       
    ##Valores Internos
        self.TilesControlRegisterCSR  = CSRStorage(14)   ##[13:5] Pisicion Tile [4:1] Tile
        self.TilesControlRegister     = Signal(14)
 
       
        

        self.specials +=Instance("Video",

            i_Reset                  = self.Reset,
            i_CLK                    = self.CLK,                   
            i_TilesControlRegister   = self.TilesControlRegister,                     
            o_TFT_SPI_CLK            = self.TFT_SPI_CLK,
            o_TFT_SPI_CS             = self.TFT_SPI_CS,
            o_TFT_SPI_MOSI           = self.TFT_SPI_MOSI,
            o_TFT_RST                = self.TFT_RST,
            o_TFT_RS                 = self.TFT_RS,            
            
        )
        
        self.comb += self.TilesControlRegister.eq(self.TilesControlRegisterCSR.storage)
        
