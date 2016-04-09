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
		input [`DSIZE-1:0] alu_result_in_MEM_WB,
		input [`DSIZE-1:0] rdata_DM_in_MEM_WB,
		//add inputs for control signals  
		
		input memToReg_in_MEM_WB,
		input [`ASIZE-1:0]waddr_in_MEM_WB, 
		
		//add outputs for control signals
		output reg memToReg_out_MEM_WB,
		
		output reg [`DSIZE-1:0] rdata_DM_out_MEM_WB,
		output reg [`DSIZE-1:0] alu_result_out_MEM_WB,
		output reg[`ASIZE-1:0]waddr_out_MEM_WB,
	
	//input and output for writeen signals
	input WriteEn_in_MEM_WB,
	output reg WriteEn_out_MEM_WB
    );

always @ (posedge clk) begin
		if(rst)
			begin
				alu_result_out_MEM_WB<=0;
				waddr_out_MEM_WB<=0;
				memToReg_out_MEM_WB<=0;
				WriteEn_out_MEM_WB<=0;
				rdata_DM_out_MEM_WB<=0;
			end
	else
			begin
				alu_result_out_MEM_WB<=alu_result_in_MEM_WB;
				waddr_out_MEM_WB<=waddr_in_MEM_WB;
				memToReg_out_MEM_WB<=memToReg_in_MEM_WB;
				WriteEn_out_MEM_WB<=WriteEn_in_MEM_WB;
				rdata_DM_out_MEM_WB<=rdata_DM_in_MEM_WB;
			end
	
	end

endmodule
