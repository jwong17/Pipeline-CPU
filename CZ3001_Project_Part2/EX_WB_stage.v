`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:40 02/18/2016 
// Design Name: 
// Module Name:    EX_WB_stage 
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
module EX_WB_stage(
	input  clk,  rst, 
	input [`DSIZE-1:0] alu_in,
	input [`ASIZE-1:0] waddr_in, 
	
	
	output reg [`DSIZE-1:0] alu_out,
	output reg[`ASIZE-1:0] waddr_out

    );
	
	
	always @ (posedge clk) begin
		if(rst)
			begin
				waddr_out<=0;
				alu_out<=0;
			end
	else
			begin
				waddr_out<=waddr_in;
				alu_out<=alu_in;
			end
	
	end

endmodule
