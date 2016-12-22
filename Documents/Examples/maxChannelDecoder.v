//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:     
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


/*! 
 *  @file 	rxParser.v 
 *  @brief	rxParser 
 */ 
 
 
 /* TODO: 
 */
 
//----------------------------
//synopsys translate_off
//`include "timescale.v"
//synopsys translate_on
//`include "config.v"
`timescale 1ns / 1ps
//----------------------------

`define ASYNC_RESET				        // синхронный сброс
//`define ASYNC_RESET	,posedge rst	// ассинхронный сброс




module maxChannelDecoder  

    (
    input rst,				    //%¬ход, сброс
    input clk,				    //%¬ход, синхронизаци€ 
	input enClk,				//%¬ход, синхронизаци€ 
	input signed [10:0] filter_out1,
	input signed [10:0] filter_out2,
	input signed [10:0] infoFilterOut1, //% выход модуля согласованного фильтра данных
	input signed [10:0] infoFilterOut2, //% выход модуля согласованного фильтра данных
	input infoValid1,			//% строб данных
	input infoValid2,			//% строб данных
	input synchro1,
	input synchro2,
	input infoBit1,           //%»нфо бит 
	input infoBit2,           //%»нфо бит 
	
	output reg synchro,
	output reg infoBit,
	output reg infoValid
    );
    
    



//synopsys translate_off	
    initial begin
    	// if ((TYPE_RESET!="asynchronous") || (TYPE_RESET!="synchronous")) begin
			// $display("Parameter Error : The TYPE_RESET is set to %s.  Legal values for this parameter is asynchronous or synchronous .", TYPE_RESET);
			// $finish;        
        // end
 	end
//synopsys translate_on	

    


//-----------------------------------------------------------
//% max decoder
//-----------------------------------------------------------		
logic signed [10:0]	InfoFilterOut1temp,filter_out1temp ; 
logic signed [10:0]	InfoFilterOut2temp,filter_out2temp ; 
logic [6:0] ShiftinfoValid2;
logic [6:0] ShiftinfoValid1;
logic [6:0] ShiftSynchro1;
logic [6:0] ShiftSynchro2;
logic [15:0] count;
logic [3:0] count1,count2;


logic muxValid,muxSyncro;

integer i;

	always @(posedge clk `ASYNC_RESET)
        if(rst)
		begin
            {infoBit,infoValid,InfoFilterOut1temp,InfoFilterOut2temp,synchro,muxValid,muxSyncro,filter_out1temp,filter_out2temp,count,count1,count2} <= 0;
			for (i = 0 ; i <= (6) ; i = i + 1)
			begin
				ShiftinfoValid2[i]     <= 0;
				ShiftinfoValid1[i]     <= 0;
				ShiftSynchro1[i]     <= 0;
				ShiftSynchro2[i]     <= 0;
			end	
		end	
        else if (enClk)
		
		begin
	
				if ((!(&count1)))
					count1  <= count1 + 1;
				else	
					filter_out1temp<=0;
					
				if ((!(&count2)))
					count2  <= count2 + 1;
				else	
					filter_out2temp<=0;

					
				if (synchro1)
				begin
					filter_out1temp <= filter_out1;
					count1<= 0;				
				end	
				
				
				if (synchro2)
				begin
					filter_out2temp <= filter_out2;					
					count2<= 0;
				end
				
				
				
					//----------------------------------------------
			
				InfoFilterOut1temp <= infoValid1 ? infoFilterOut1 : InfoFilterOut1temp;
				InfoFilterOut2temp <= infoValid2 ? infoFilterOut2 : InfoFilterOut2temp;
				
				ShiftinfoValid1[0]     <= infoValid1;
				ShiftinfoValid2[0]     <= infoValid2;
				
				ShiftSynchro1[0]     <= synchro1;
				ShiftSynchro2[0]     <= synchro2;
				
				for (i = 1 ; i <= 6 ; i = i + 1)
				begin
					ShiftSynchro1[i]      <= ShiftSynchro1[i-1];
					ShiftSynchro2[i]      <= ShiftSynchro2[i-1];
				
					ShiftinfoValid1[i] <= ShiftinfoValid1[i-1];
					ShiftinfoValid2[i] <= ShiftinfoValid2[i-1];
				end
				
				//----------------------------------------------
				if (ShiftinfoValid1[2] && ShiftinfoValid2 && InfoFilterOut1temp < InfoFilterOut2temp)// && count>=41)
					muxValid <= 1;
				else if (ShiftinfoValid1[2] && ShiftinfoValid2 && InfoFilterOut1temp > InfoFilterOut2temp)//&& count>=41)	
					muxValid <= 0;
				else if (ShiftinfoValid1[2] && (!(|ShiftinfoValid2)))//&& count>=41)	
					muxValid <= 0;
				else if (ShiftinfoValid2[2] && (!(|ShiftinfoValid1)))//&& count>=41)		
					muxValid <= 1;
					
				
				 // muxValid <= 0;
				//----------------------------------------------
					
				infoValid <= muxValid ? ShiftinfoValid2[6] : ShiftinfoValid1[6];	
				infoBit   <= muxValid ? infoBit2 : infoBit1;	
				synchro   <= (filter_out1temp > filter_out2temp) ? ShiftSynchro1[6] : ShiftSynchro2[6];
				//synchro   <= ShiftSynchro1[6] ;
				
				if (infoValid)
					{count} <= 0;
				else
				begin
					if ((!(&count)))
						count  <= count + 1;
				
				end
				
		end

endmodule