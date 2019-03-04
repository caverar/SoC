from migen import *
from litex.soc.interconnect.csr import *
from litex.soc.interconnect.csr_eventmanager import *




# Modulo Principal
class Buttons(Module,AutoCSR):
    def __init__(self):
    ##Interrupciones

        self.submodules.ev = EventManager()
        self.ev.button1    = EventSourcePulse()
        self.ev.button2    = EventSourcePulse()
        self.ev.button3    = EventSourcePulse()
        self.ev.button4    = EventSourcePulse()
        #self.ev.finalize()
    ##Entradas
        
        self.CLK                    = Signal()        
        self.Buttons                = Signal(4) 
        

       
    ##Valores Internos
        self.DataRegister               = CSRStatus(4)
        self.Data                       = Signal(4)
        self.Button1Interrupt           = Signal()
        self.Button2Interrupt           = Signal()
        self.Button3Interrupt           = Signal()
        self.Button4Interrupt           = Signal()

 
        

        self.specials +=Instance("Buttons",           
            i_CLK                   = self.CLK,                   
            i_buttons               = self.Buttons,                 
            o_data                  = self.Data,
            o_Button1Interrupt      = self.Button1Interrupt,
            o_Button2Interrupt      = self.Button2Interrupt,
            o_Button3Interrupt      = self.Button3Interrupt,
            o_Button4Interrupt      = self.Button4Interrupt,           
        )

        self.comb += self.Data.eq(self.DataRegister.status)
        self.comb += self.ev.button1.trigger.eq( self.Button1Interrupt )
        self.comb += self.ev.button2.trigger.eq( self.Button2Interrupt )
        self.comb += self.ev.button3.trigger.eq( self.Button3Interrupt )
        self.comb += self.ev.button4.trigger.eq( self.Button4Interrupt )
