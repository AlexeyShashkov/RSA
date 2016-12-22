`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:39:41 10/18/2015
// Design Name:   rxPacketDecoder
// Module Name:   D:/project/SDR/project/dmr/tbnRxPacketDecoder.v
// Project Name:  dmr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rxPacketDecoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tbnRxPacketDecoder;

	// Inputs
	reg rst;
	reg clk,clkTb;
	reg enClk;
	reg  data_in;

	// Outputs
	wire DataValid;
	wire [7:0] DataRx;
	
	
		parameter bitBarker    = 2'b11;
		
		
		parameter Barker13 = {<<{bitBarker,bitBarker,bitBarker,bitBarker,bitBarker,~bitBarker,~bitBarker,bitBarker,bitBarker,~bitBarker,bitBarker,~bitBarker,bitBarker}};	
		parameter Barker7 = {{bitBarker,bitBarker,bitBarker,~bitBarker,~bitBarker,bitBarker,~bitBarker}};
		parameter Barker5 = {bitBarker,bitBarker,bitBarker,~bitBarker,bitBarker};

		parameter Data1 = {{~Barker7,~Barker7,Barker7}};
		//parameter Data1 = {~Barker5,~Barker5,Barker5};
		

		//parameter PREAMB = 260'b11110000111100001111111100000000111111111111111111110000111100001111000000001111111100000000000000000000000011110000111100000000111111110000000000000000000000001111000011110000000011111111000000000000000000001111000011110000111111110000000011111111111111111111; 
		parameter PREAMB = {Barker13,~Barker13,~Barker13,~Barker13,Barker13}; 
		parameter DATA = {Data1,~Data1,Data1,Data1,Data1,Data1,Data1,~Data1,
								Data1,~Data1,Data1,Data1,Data1,Data1,~Data1,Data1,
								Data1,~Data1,Data1,Data1,Data1,Data1,~Data1,~Data1,
								Data1,~Data1,Data1,Data1,Data1,~Data1,Data1,Data1,
								Data1,~Data1,Data1,Data1,Data1,~Data1,Data1,~Data1,
								Data1,~Data1,Data1,Data1,Data1,~Data1,~Data1,Data1,
								Data1,~Data1,Data1,Data1,Data1,~Data1,~Data1,~Data1,
								Data1,~Data1,Data1,Data1,~Data1,Data1,Data1,Data1,
								Data1,~Data1,Data1,Data1,~Data1,Data1,Data1,~Data1,
								Data1,~Data1,Data1,Data1,~Data1,Data1,~Data1,Data1,
								Data1,~Data1,Data1,Data1,~Data1,Data1,~Data1,~Data1,
								//12
								Data1,~Data1,Data1,Data1,~Data1,~Data1,Data1,Data1,
								//13
								Data1,~Data1,Data1,Data1,~Data1,~Data1,Data1,~Data1,
								//14
								Data1,~Data1,Data1,Data1,~Data1,~Data1,~Data1,Data1,
								//15
								Data1,Data1,Data1,Data1,~Data1,~Data1,Data1,~Data1,
								//16
								Data1,Data1,Data1,Data1,~Data1,Data1,~Data1,Data1,
								//count
								Data1,Data1,Data1,~Data1,Data1,Data1,Data1,Data1,
								//18
								Data1,Data1,Data1,~Data1,Data1,Data1,~Data1,Data1,
								//19
								Data1,Data1,Data1,~Data1,Data1,Data1,~Data1,~Data1,
								//20
								Data1,Data1,Data1,~Data1,Data1,~Data1,Data1,Data1,
								//21
								Data1,Data1,Data1,~Data1,Data1,~Data1,Data1,~Data1};
		
		parameter RXDATA = {PREAMB,DATA};
		parameter N = $bits(RXDATA);
		
		
		
//defparam uut.IMPULSE_PREAMB_RESPONSE = PREAMB;
//defparam uut.IMPULSE_DATA_RESPONSE = Data1;
//defparam uut.NUMBER_OF_DATA 		= 20*8;	

	// Instantiate the Unit Under Test (UUT)
	rxPacketDecoder uut (
		.rst(rst), 
		.clk(clk), 
		.enClk(1), 
		.data_in({data_in,1'b1}), 
		.DataValid(DataValid), 
		.DataRx(DataRx)
	);		
		
		
//rs_enc rs_enc_Mod (
//	.data_in(data_in), // input [7 : 0] data_in
//	.start(start), // input start
//	.bypass(bypass), // input bypass
//	.sclr(sclr), // input sclr
//	.data_out(data_out), // output [7 : 0] data_out
//	.info(info), // output info
//	.ce(ce), // input ce
//	.clk(clk)); // input clk		
		
		
		
		integer j;
		
		integer monitor;

	initial begin
		// Initialize Inputs
		rst = 1;
		clk = 1;
		clkTb = 1;
		data_in = 0;
		
		
		monitor = $fopen("monitor.txt","w");

		repeat(10)	@(posedge clk);
		rst = 0;	
        
		repeat(500)	@(posedge clk);
		data_in = 0;
        
		$display("Start packet")  ;
		for(j = N-1; j >= 0; j=j - 1) 
		begin
			//@(posedge clkTb);
			@(posedge clk);
			data_in = RXDATA[j];
			$fwrite(monitor,"%d\n",data_in);
		end
		$fclose(monitor);
		$display("End packet")  ;
		
//		data_in = 0;
//		repeat(40000)	
//		begin
//			@(posedge clk);
//			$fwrite(monitor,"%d\n",data_in);
//		end
		
		
        
		for(j = N-1; j >= 0; j=j - 1) 
		begin
			@(posedge clkTb);
			data_in = RXDATA[j];
		end		

	end
	
///////////////////////////////////////////////////////////////////
//
// Clock generation
//
///////////////////////////////////////////////////////////////////
always #10.00 clkTb   = ~clkTb;		
always #10 clk   = ~clk;		
      
endmodule
      


