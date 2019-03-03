

module CM2 (
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


module Audio_ClockManager(
		input  InputCLK,
		output MasterCLK,
		output I2SCLK  	
 	);
		wire I2SCLK_x10;
		wire I2SCLK;
		// IBUF InputBuffer(
		//   .O (InputCLK_Buffered),
		//   .I (InputCLK)
		// );
		assign MasterCLK=InputCLK;
		
		CM2 cm2(
			.I2S_CLK(I2SCLK_x10),
			.clk_in1(InputCLK)
		);  	

		// BUFGCE I2S_Synchronizer(
		// 	.O (I2SCLK),
		// 	.I(I2S_CLK),
		// 	.CE(I2SCLK_x10)
		// );
	assign I2SCLK=I2S_CLK;
		

	//Divisor de frecuencia en 10
		reg  [2:0] counter;
		reg I2S_CLK;
		initial begin counter=0; I2S_CLK=0; end 
		always@(posedge I2SCLK_x10) begin
			 if(counter<5)begin
				counter<=counter+1;
					I2S_CLK<=0;
			end else if(counter<10) begin
					counter<=counter+1;
					I2S_CLK<=1;
			end else begin
					counter<=0;
					I2S_CLK<=1;
			 end    
		 end  
endmodule
