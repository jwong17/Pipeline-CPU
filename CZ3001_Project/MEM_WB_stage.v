`include "define.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:15:04 03/17/2016 
// Design Name: 
// Module Name:    MEM_WB_stage 
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
module MEM_WB_stage(
		input  clk,  rst,
		input [`DSIZE-1:0] alu_result_in,
		//add inputs for control signals  
		
		input memToReg_in,
		input [`ASIZE-1:0]waddr_in, 

		//add outputs for control signals
		output reg memToReg_out,
		
		output reg [`DSIZE-1:0] alu_result_out,
		output reg[`ASIZE-1:0]waddr_out,
	
	//input and output for writeen signals
	input WriteEn_in,
	output reg WriteEn_out
    );

always @ (posedge clk) begin
		if(rst)
			begin
				alu_result_out<=0;
				waddr_out<=0;
				memToReg_out<=0;
				WriteEn_out<=0;
			end
	else
			begin
				alu_result_out<=alu_result_in;
				waddr_out<=waddr_in;
				memToReg_out<=memToReg_in;
				WriteEn_out<=WriteEn_in;
			end
	
	end

endmodule
