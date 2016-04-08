`include "define.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:06:52 03/17/2016 
// Design Name: 
// Module Name:    EX_MEM_stage 
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
module EX_MEM_stage(
	input  clk,  rst,
	input [`DSIZE-1:0] rdata2_in_EX_MEM,

	input [`DSIZE-1:0] alu_result_in_EX_MEM,
	
	//add inputs for control signals  
	input memWrite_in_EX_MEM,
	input memRead_in_EX_MEM,
	input memToReg_in_EX_MEM,
	
	input [`ASIZE-1:0]waddr_in_EX_MEM, 

	output reg [`DSIZE-1:0] rdata2_out_EX_MEM,

	output reg [`DSIZE-1:0] alu_result_out_EX_MEM,
	
	//add outputs for control signals
	output reg memWrite_out_EX_MEM,
	output reg memRead_out_EX_MEM,
	output reg memToReg_out_EX_MEM,
	
	output reg[`ASIZE-1:0]waddr_out_EX_MEM,
	
	//input and output for writeen signals
	input WriteEn_in_EX_MEM,
	output reg WriteEn_out_EX_MEM
    );

	always @ (posedge clk) begin
		if(rst)
			begin
				waddr_out_EX_MEM <= 0;
				rdata2_out_EX_MEM<=0;
				alu_result_out_EX_MEM<=0;
				memWrite_out_EX_MEM <= 0;
				memRead_out_EX_MEM <= 0;
				memToReg_out_EX_MEM<= 0;
				WriteEn_out_EX_MEM <= 0;
				
			end
	else
			begin
				waddr_out_EX_MEM <= waddr_in_EX_MEM;
				rdata2_out_EX_MEM<=rdata2_in_EX_MEM;
				alu_result_out_EX_MEM<=alu_result_in_EX_MEM;
				memWrite_out_EX_MEM <= memWrite_in_EX_MEM;
				memRead_out_EX_MEM <= memRead_in_EX_MEM;
				memToReg_out_EX_MEM<= memToReg_in_EX_MEM;
				WriteEn_out_EX_MEM <= WriteEn_in_EX_MEM;
			end
	
	end

endmodule
