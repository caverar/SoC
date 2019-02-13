`timescale 1ns / 1ps


module InitializationRegister#(parameter InitFrequency=100, parameter delayUnit=1)(
    input  [24:0] pointer,
    output [15:0] OutData,
    output        RS,
    output reg    CS,
    input         CLK
    );
    //Instancias
    

    //Creacion de Registros Y Cables
    reg [16:0] Data [103:0];
    reg [6:0]  address;
    //Incializacion de Registros
    initial begin
        CS=0;
        address=0;

        //Dato basura
        Data[0]   = {1'b0,16'h0000};
        //Power Control 1
        Data[1]   = {1'b0,16'h0010};    
        Data[2]   = {1'b1,16'h0000};        
        //Power Control 2            
        Data[3]   = {1'b0,16'h0011}; 
        Data[4]   = {1'b1,16'h0000};           
        //Power Control 3    
        Data[5]   = {1'b0,16'h0012}; 
        Data[6]   = {1'b1,16'h0000};   
        //Power Control 4        
        Data[7]   = {1'b0,16'h0013}; 
        Data[8]   = {1'b1,16'h0000};                    
        //Power Control 5
        Data[9]   = {1'b0,16'h0014}; 
        Data[10]  = {1'b1,16'h0000};
    
        //Power-on sequence----------------------------------------
        //delay(40);     

        //Power Control 2    
        Data[11]  = {1'b0,16'h0011}; 
        Data[12]  = {1'b1,16'h0018};  
        //Power Control 3
        Data[13]  = {1'b0,16'h0012};
        Data[14]  = {1'b1,16'h6121};        
        //Power Control 4
        Data[15]  = {1'b0,16'h0013}; 
        Data[16]  = {1'b1,16'h006f};    
        //Power Control 5
        Data[17]  = {1'b0,16'h0014}; 
        Data[18]  = {1'b1,16'h495f};   
        //Power Control 1       
        Data[19]  = {1'b0,16'h0010};    
        Data[20]  = {1'b1,16'h0800};
  
        //delay(10);
        //Power Control 2    
        Data[21]  = {1'b0,16'h0011}; 
        Data[22]  = {1'b1,16'h103B};

        //delay(50);
        
        //DRIVER_OUTPUT_CTRL
        Data[23]  = {1'b0,16'h0001};    
        Data[24]  = {1'b1,16'h011C};        
        //LCD_AC_DRIVING_CTRL            
        Data[25]  = {1'b0,16'h0002}; 
        Data[26]  = {1'b1,16'h0100};           
        //ENTRY_MODE    
        Data[27]  = {1'b0,16'h0003}; 
        Data[28]  = {1'b1,16'h1038};   
        //DISP_CTRL1       
        Data[29]  = {1'b0,16'h0007}; 
        Data[30]  = {1'b1,16'h0000};                    
        //BLANK_PERIOD_CTRL1
        Data[31]  = {1'b0,16'h0008}; 
        Data[32]  = {1'b1,16'h0808};
        //FRAME_CYCLE_CTRL
        Data[33]  = {1'b0,16'h000B};    
        Data[34]  = {1'b1,16'h1100};        
        //INTERFACE_CTRL            
        Data[35]  = {1'b0,16'h000C}; 
        Data[36]  = {1'b1,16'h0000};           
        //OSC_CTRL   
        Data[37]  = {1'b0,16'h000F}; 
        Data[38]  = {1'b1,16'h0D01};   
        //VCI_RECYCLING      
        Data[39]  = {1'b0,16'h0015}; 
        Data[40]  = {1'b1,16'h0020};                    
        //RAM_ADDR_SET1
        Data[41]  = {1'b0,16'h0020}; 
        Data[42]  = {1'b1,16'h0000};
        //RAM_ADDR_SET2
        Data[43]  = {1'b0,16'h0021}; 
        Data[44]  = {1'b1,16'h0000};


        //Set GRAM area------------------------------------
            
        //GATE_SCAN_CTRL
        Data[45]  = {1'b0,16'h0030};    
        Data[46]  = {1'b1,16'h0000};        
        //VERTICAL_SCROLL_CTRL1            
        Data[47]  = {1'b0,16'h0031}; 
        Data[48]  = {1'b1,16'h00DB};           
        //VERTICAL_SCROLL_CTRL2   
        Data[49]  = {1'b0,16'h0032}; 
        Data[50]  = {1'b1,16'h0000};   
        //VERTICAL_SCROLL_CTRL3      
        Data[51]  = {1'b0,16'h0033}; 
        Data[52]  = {1'b1,16'h0000};                    
        //PARTIAL_DRIVING_POS1
        Data[53]  = {1'b0,16'h0034}; 
        Data[54]  = {1'b1,16'h00DB};
        //PARTIAL_DRIVING_POS2
        Data[55]  = {1'b0,16'h0035}; 
        Data[56]  = {1'b1,16'h0000};          


        //HORIZONTAL_WINDOW_ADDR1
        Data[57]  = {1'b0,16'h0036};    
        Data[58]  = {1'b1,16'h00AF};        
        //HORIZONTAL_WINDOW_ADDR2            
        Data[59]  = {1'b0,16'h0037}; 
        Data[60]  = {1'b1,16'h0000};           
        //VERTICAL_WINDOW_ADDR1   
        Data[61]  = {1'b0,16'h0038}; 
        Data[62]  = {1'b1,16'h00DB};   
        //VERTICAL_WINDOW_ADDR2      
        Data[63]  = {1'b0,16'h0039}; 
        Data[64]  = {1'b1,16'h0000};

        // Set GAMMA curve------------------------------------- 
        //GAMMA_CTRL1
        Data[65]  = {1'b0,16'h0050}; 
        Data[66]  = {1'b1,16'h0000};
        //GAMMA_CTRL2
        Data[67]  = {1'b0,16'h0051}; 
        Data[68]  = {1'b1,16'h0808};
        //GAMMA_CTRL3
        Data[69]  = {1'b0,16'h0052}; 
        Data[70]  = {1'b1,16'h080A};
        //GAMMA_CTRL4
        Data[71]  = {1'b0,16'h0053}; 
        Data[72]  = {1'b1,16'h000A};
        //GAMMA_CTRL5
        Data[73]  = {1'b0,16'h0054}; 
        Data[74]  = {1'b1,16'h0A08};
        //GAMMA_CTRL6
        Data[75]  = {1'b0,16'h0055}; 
        Data[76]  = {1'b1,16'h0808};
        //GAMMA_CTRL7
        Data[77]  = {1'b0,16'h0056}; 
        Data[78]  = {1'b1,16'h0000};
        //GAMMA_CTRL8
        Data[79]  = {1'b0,16'h0057}; 
        Data[80]  = {1'b1,16'h0A00};
        //GAMMA_CTRL9
        Data[81]  = {1'b0,16'h0058}; 
        Data[82]  = {1'b1,16'h0710};
        //GAMMA_CTRL10
        Data[83]  = {1'b0,16'h0059}; 
        Data[84]  = {1'b1,16'h0710}; 

        //-----------------------------------   
        //DISP_CTRL1
        Data[85]  = {1'b0,16'h0007}; 
        Data[86]  = {1'b1,16'h0012};
        //delay(50);
        //DISP_CTRL1
        Data[87]  = {1'b0,16'h0007}; 
        Data[88]  = {1'b1,16'h1017};  

        // Turn on backlight
        //setBacklight(true);
        //setOrientation(0);
       
        // Initialize variables
        //setBackgroundColor( COLOR_BLACK );

        
        //ENTRY MODE
        Data[89]  = {1'b0,16'h0003};
        Data[90]  = {1'b1,16'h1030}; //1038

        //HORIZONTAL_WINDOW_ADDR1
        Data[91]  = {1'b0,16'h0036};    
        Data[92]  = {1'b1,16'h00AF};        
        //HORIZONTAL_WINDOW_ADDR2            
        Data[93]  = {1'b0,16'h0037}; 
        Data[94]  = {1'b1,16'h0000};           
        //VERTICAL_WINDOW_ADDR1   
        Data[95]  = {1'b0,16'h0038}; 
        Data[96]  = {1'b1,16'h00DB};   
        //VERTICAL_WINDOW_ADDR2      
        Data[97]  = {1'b0,16'h0039}; 
        Data[98]  = {1'b1,16'h0000};
        //RAM_ADDR_SET1
        Data[99]  = {1'b0,16'h0020}; 
        Data[100] = {1'b1,16'h0000};
        //RAM_ADDR_SET2
        Data[101] = {1'b0,16'h0021}; 
        Data[102] = {1'b1,16'h0000};

        //Inicio de Transferencia de datos
        //WRITE DATA TO GRAM
        Data[103] = {1'b0,16'h0022};
    end
    
    always@(posedge CLK)begin
        if(pointer<11) begin
            address=pointer;
            CS=0;
        end else if(pointer>=(40*delayUnit)+11 && pointer< ((40*delayUnit)+21) ) begin  
            address=pointer-(40*delayUnit);              
            CS=0;
        end else if(pointer>=(60*delayUnit)+21 && pointer< ((60*delayUnit)+23) ) begin  
            address=pointer-(60*delayUnit);              
            CS=0; 
        end else if(pointer>=(110*delayUnit)+23 && pointer< ((110*delayUnit)+87) ) begin  
            address=pointer-(110*delayUnit);              
            CS=0;
        end else if(pointer>=(160*delayUnit)+87) begin  
            address=pointer-(160*delayUnit);              
            CS=0;    
        end else begin
            CS=1;
            address=0;
        end
    end
    //Asignaciones Combinacionales
    assign OutData=Data[address][15:0];
    assign RS=Data[address][16];
           
    
endmodule
