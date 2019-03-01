module reloj1_clk_wiz_0_0_clk_wiz (
  // Clock in ports
  // Clock out ports
  output        MasterClocK,
  output        SD_Clock,
  output        TFT_Clock,
  input         clk_in1
);
  // Input buffering
  //------------------------------------
  wire clk_in1_reloj1_clk_wiz_0_0;
  wire clk_in2_reloj1_clk_wiz_0_0;
  assign clk_in1_reloj1_clk_wiz_0_0=clk_in1;
  

  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        MasterClocK_reloj1_clk_wiz_0_0;
  wire        SD_Clock_reloj1_clk_wiz_0_0;
  wire        TFT_Clock_reloj1_clk_wiz_0_0;
  wire        clk_out4_reloj1_clk_wiz_0_0;
  wire        clk_out5_reloj1_clk_wiz_0_0;
  wire        clk_out6_reloj1_clk_wiz_0_0;
  wire        clk_out7_reloj1_clk_wiz_0_0;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_reloj1_clk_wiz_0_0;
  wire        clkfbout_buf_reloj1_clk_wiz_0_0;
  wire        clkfboutb_unused;
  wire        clkout0b_unused;
  wire        clkout1b_unused;
  wire        clkout2b_unused;
  wire        clkout3_unused;
  wire        clkout3b_unused;
  wire        clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg1 = 0;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg2 = 0;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg3 = 0;

  MMCME2_ADV #(
    .BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (1),
    .CLKFBOUT_MULT_F      (8.000),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (8.000),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKOUT1_DIVIDE       (64),
    .CLKOUT1_PHASE        (0.000),
    .CLKOUT1_DUTY_CYCLE   (0.500),
    .CLKOUT1_USE_FINE_PS  ("FALSE"),
    .CLKOUT2_DIVIDE       (128),
    .CLKOUT2_PHASE        (0.000),
    .CLKOUT2_DUTY_CYCLE   (0.500),
    .CLKOUT2_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (10.000))
  mmcm_adv_inst1
    // Output clocks
   (
    .CLKFBOUT            (clkfbout_reloj1_clk_wiz_0_0),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (MasterClocK_reloj1_clk_wiz_0_0),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (SD_Clock_reloj1_clk_wiz_0_0),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (TFT_Clock_reloj1_clk_wiz_0_0),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_reloj1_clk_wiz_0_0),
    .CLKIN1              (clk_in1_reloj1_clk_wiz_0_0),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0));

// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf1(
    .O(clkfbout_buf_reloj1_clk_wiz_0_0),
    .I(clkfbout_reloj1_clk_wiz_0_0)
  );


  BUFGCE clkout1_buf1(
    .O(MasterClocK),
    .CE(seq_reg1[7]),
    .I(MasterClocK_reloj1_clk_wiz_0_0)
  );

  BUFH clkout1_buf_en1(
    .O(MasterClocK_reloj1_clk_wiz_0_0_en_clk),
    .I(MasterClocK_reloj1_clk_wiz_0_0)
  );

  always @(posedge MasterClocK_reloj1_clk_wiz_0_0_en_clk)
        seq_reg1 <= {seq_reg1[6:0],locked_int};


  BUFGCE clkout2_buf1(
    .O(SD_Clock),
    .CE(seq_reg2[7]),
    .I(SD_Clock_reloj1_clk_wiz_0_0)
  );
 
  BUFH clkout2_buf_en1(
    .O(SD_Clock_reloj1_clk_wiz_0_0_en_clk),
    .I(SD_Clock_reloj1_clk_wiz_0_0)
  );
 
  always @(posedge SD_Clock_reloj1_clk_wiz_0_0_en_clk)
        seq_reg2 <= {seq_reg2[6:0],locked_int};


  BUFGCE clkout3_buf1(
    .O(TFT_Clock),
    .CE(seq_reg3[7]),
    .I(TFT_Clock_reloj1_clk_wiz_0_0)
  );
 
  BUFH clkout3_buf_en1(
    .O(TFT_Clock_reloj1_clk_wiz_0_0_en_clk),
    .I(TFT_Clock_reloj1_clk_wiz_0_0)
  );
 
  always @(posedge TFT_Clock_reloj1_clk_wiz_0_0_en_clk)
        seq_reg3 <= {seq_reg3[6:0],locked_int};

endmodule
//----------------------------------------------------------------------
(* CORE_GENERATION_INFO = "reloj1_clk_wiz_0_0,clk_wiz_v6_0_1_0_0,{component_name=reloj1_clk_wiz_0_0,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=3,clkin1_period=10.000,clkin2_period=10.000,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *)

module reloj1_clk_wiz_0_0 (
  // Clock out ports
  output        MasterClocK,
  output        SD_Clock,
  output        TFT_Clock,
  // Clock in ports
  input         clk_in1
);

  reloj1_clk_wiz_0_0_clk_wiz inst(
    // Clock out ports  
    .MasterClocK(MasterClocK),
    .SD_Clock(SD_Clock),
    .TFT_Clock(TFT_Clock),
    // Clock in ports
    .clk_in1(clk_in1)
  );

endmodule
//------------------------------------------------------------------

(* CORE_GENERATION_INFO = "reloj1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=reloj1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "reloj1.hwdef" *) 
module reloj1
   (MasterCLK,
    SD_CLK,
    TFT_CLK,
    clk100);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.MASTERCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.MASTERCLK, CLK_DOMAIN /MainClockWizard_clk_out1, FREQ_HZ 100000000, PHASE 0.0" *) output MasterCLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SD_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SD_CLK, CLK_DOMAIN /MainClockWizard_clk_out1, FREQ_HZ 12500000, PHASE 0.0" *) output SD_CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.TFT_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.TFT_CLK, CLK_DOMAIN /MainClockWizard_clk_out1, FREQ_HZ 6250000, PHASE 0.0" *) output TFT_CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100, CLK_DOMAIN reloj1_clk_100MHz, FREQ_HZ 100000000, PHASE 0.000" *) input clk100;

  wire clk_100MHz_1;
  wire clk_wiz_0_MasterClocK;
  wire clk_wiz_0_SD_Clock;
  wire clk_wiz_0_TFT_Clock;

  assign MasterCLK = clk_wiz_0_MasterClocK;
  assign SD_CLK = clk_wiz_0_SD_Clock;
  assign TFT_CLK = clk_wiz_0_TFT_Clock;
  assign clk_100MHz_1 = clk100;

  reloj1_clk_wiz_0_0 MainClockWizard(
    .MasterClocK(clk_wiz_0_MasterClocK),
    .SD_Clock(clk_wiz_0_SD_Clock),
    .TFT_Clock(clk_wiz_0_TFT_Clock),
    .clk_in1(clk_100MHz_1)
  );
endmodule

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------

module reloj2_clk_wiz_0_0_clk_wiz (
  // Clock in ports
  // Clock out ports
  output        I2S_CLK,
  input         clk_in1
);
  // Input buffering
  //------------------------------------
wire clk_in1_reloj2_clk_wiz_0_0;
wire clk_in2_reloj2_clk_wiz_0_0;
assign clk_in1_reloj2_clk_wiz_0_0=clk_in1;

  // Clocking PRIMITIVE
  //------------------------------------

  // Instantiation of the MMCM PRIMITIVE
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused

  wire        I2S_CLK_reloj2_clk_wiz_0_0;
  wire        clk_out2_reloj2_clk_wiz_0_0;
  wire        clk_out3_reloj2_clk_wiz_0_0;
  wire        clk_out4_reloj2_clk_wiz_0_0;
  wire        clk_out5_reloj2_clk_wiz_0_0;
  wire        clk_out6_reloj2_clk_wiz_0_0;
  wire        clk_out7_reloj2_clk_wiz_0_0;

  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        psdone_unused;
  wire        locked_int;
  wire        clkfbout_reloj2_clk_wiz_0_0;
  wire        clkfbout_buf_reloj2_clk_wiz_0_0;
  wire        clkfboutb_unused;
  wire        clkout0b_unused;
  wire        clkout1_unused;
  wire        clkout1b_unused;
  wire        clkout2_unused;
  wire        clkout2b_unused;
  wire        clkout3_unused;
  wire        clkout3b_unused;
  wire        clkout4_unused;
  wire        clkout5_unused;
  wire        clkout6_unused;
  wire        clkfbstopped_unused;
  wire        clkinstopped_unused;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg  [7 :0] seq_reg1 = 0;

  MMCME2_ADV #(
    .BANDWIDTH            ("OPTIMIZED"),
    .CLKOUT4_CASCADE      ("FALSE"),
    .COMPENSATION         ("ZHOLD"),
    .STARTUP_WAIT         ("FALSE"),
    .DIVCLK_DIVIDE        (5),
    .CLKFBOUT_MULT_F      (55.125),
    .CLKFBOUT_PHASE       (0.000),
    .CLKFBOUT_USE_FINE_PS ("FALSE"),
    .CLKOUT0_DIVIDE_F     (78.125),
    .CLKOUT0_PHASE        (0.000),
    .CLKOUT0_DUTY_CYCLE   (0.500),
    .CLKOUT0_USE_FINE_PS  ("FALSE"),
    .CLKIN1_PERIOD        (10.000))
  mmcm_adv_inst2 (
    // Output clocks
    .CLKFBOUT            (clkfbout_reloj2_clk_wiz_0_0),
    .CLKFBOUTB           (clkfboutb_unused),
    .CLKOUT0             (I2S_CLK_reloj2_clk_wiz_0_0),
    .CLKOUT0B            (clkout0b_unused),
    .CLKOUT1             (clkout1_unused),
    .CLKOUT1B            (clkout1b_unused),
    .CLKOUT2             (clkout2_unused),
    .CLKOUT2B            (clkout2b_unused),
    .CLKOUT3             (clkout3_unused),
    .CLKOUT3B            (clkout3b_unused),
    .CLKOUT4             (clkout4_unused),
    .CLKOUT5             (clkout5_unused),
    .CLKOUT6             (clkout6_unused),
     // Input clock control
    .CLKFBIN             (clkfbout_buf_reloj2_clk_wiz_0_0),
    .CLKIN1              (clk_in1_reloj2_clk_wiz_0_0),
    .CLKIN2              (1'b0),
     // Tied to always select the primary input clock
    .CLKINSEL            (1'b1),
    // Ports for dynamic reconfiguration
    .DADDR               (7'h0),
    .DCLK                (1'b0),
    .DEN                 (1'b0),
    .DI                  (16'h0),
    .DO                  (do_unused),
    .DRDY                (drdy_unused),
    .DWE                 (1'b0),
    // Ports for dynamic phase shift
    .PSCLK               (1'b0),
    .PSEN                (1'b0),
    .PSINCDEC            (1'b0),
    .PSDONE              (psdone_unused),
    // Other control and status signals
    .LOCKED              (locked_int),
    .CLKINSTOPPED        (clkinstopped_unused),
    .CLKFBSTOPPED        (clkfbstopped_unused),
    .PWRDWN              (1'b0),
    .RST                 (1'b0)
  );

// Clock Monitor clock assigning
//--------------------------------------
 // Output buffering
  //-----------------------------------

  BUFG clkf_buf2(
    .O (clkfbout_buf_reloj2_clk_wiz_0_0),
    .I (clkfbout_reloj2_clk_wiz_0_0)
  );


  BUFGCE clkout1_buf2(
    .O(I2S_CLK),
    .CE(seq_reg1[7]),
    .I(I2S_CLK_reloj2_clk_wiz_0_0)
  );

  BUFH clkout1_buf_en2(
    .O(I2S_CLK_reloj2_clk_wiz_0_0_en_clk),
    .I(I2S_CLK_reloj2_clk_wiz_0_0)
  );
  always @(posedge I2S_CLK_reloj2_clk_wiz_0_0_en_clk)
        seq_reg1 <= {seq_reg1[6:0],locked_int};

endmodule
//-----------------------------------------------------------------------
//*CORE_GENERATION_INFO = "reloj2_clk_wiz_0_0,clk_wiz_v6_0_1_0_0,{component_name=reloj2_clk_wiz_0_0,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=1,clkin1_period=10.000,clkin2_period=10.000,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *)

module reloj2_clk_wiz_0_0(
  // Clock out ports
  output        I2S_CLK,
  // Clock in ports
  input         clk_in1
);

  reloj2_clk_wiz_0_0_clk_wiz inst(
    // Clock out ports  
    .I2S_CLK(I2S_CLK),
    // Clock in ports
    .clk_in1(clk_in1)
  );

endmodule

//---------------------------------------------------------
(* CORE_GENERATION_INFO = "reloj2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=reloj2,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "reloj2.hwdef" *) 
module reloj2
   (I2S_CLK,
    clk100);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.I2S_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.I2S_CLK, CLK_DOMAIN /AudioClock_clk_out1, FREQ_HZ 14112000, PHASE 0.0" *) output I2S_CLK;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK100 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK100, CLK_DOMAIN reloj2_clk_100MHz, FREQ_HZ 100000000, PHASE 0.000" *) input clk100;

  wire AudioClock_I2S_CLK;
  wire clk_100MHz_1;
  reg I2SCLK;

  //assign I2S_CLK = I2SCLK;

  BUFG I2S_Synchronizer(
    .O (I2S_CLK),
    .I (I2SCLK)
  );

  assign clk_100MHz_1 = clk100;

//Divisor de frecuencia en 10
  reg  [2:0] counter;
  initial begin counter=0; I2SCLK=0; end 
  always@(posedge AudioClock_I2S_CLK) begin
    if(counter<10/2)begin
      counter=counter+1;
      I2SCLK=0;
    end else if(counter<10) begin
      counter=counter+1;
      I2SCLK=1;
    end else begin
      counter=0;
      I2SCLK=1;
    end    
   end

  reloj2_clk_wiz_0_0 AudioClock(
    .I2S_CLK(AudioClock_I2S_CLK),
    .clk_in1(clk_100MHz_1)
  );
endmodule

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
module AudVid_ClockManager(
  input  InputCLK,
  output MasterCLK,
  output I2SCLK,
  output TFTCLK,
  output SDCLK
  );
  wire InputCLK_Buffered;
  // IBUF InputBuffer(
  //   .O (InputCLK_Buffered),
  //   .I (InputCLK)
  // );
  assign InputCLK_Buffered =InputCLK;
  reloj2 Reloj2(
    .I2S_CLK(I2SCLK),
    .clk100(InputCLK_Buffered)
  );
  reloj1 Reloj1(
    .MasterCLK(MasterCLK),
    .SD_CLK(SDCLK),
    .TFT_CLK(TFTCLK),
    .clk100(InputCLK_Buffered)
  );
  
endmodule
