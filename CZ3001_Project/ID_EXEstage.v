`include "define.v"

module ID_EXE_stage (
	
	input  clk,  rst, 
	input [`DSIZE-1:0] rdata1_in_ID_EXE,
	input [`DSIZE-1:0] rdata2_in_ID_EXE,
	input [`DSIZE-1:0] imm_in_ID_EXE,
	input [2:0] opcode_in_ID_EXE,
	input alusrc_in_ID_EXE,
	input [`ASIZE-1:0]waddr_in_ID_EXE, 
	
	//add inputs for control signals  
	input memWrite_in_ID_EXE,
	input memRead_in_ID_EXE,
	input memToReg_in_ID_EXE,
	input branch_in_ID_EXE,
	
	//program counter signal
	input [`ISIZE-1:0] npc_in_ID_EXE,

	output reg [`DSIZE-1:0] rdata1_out_ID_EXE,
	output reg [`DSIZE-1:0] rdata2_out_ID_EXE,
	output reg [`DSIZE-1:0] imm_out_ID_EXE,
	output reg [2:0] opcode_out_ID_EXE,
	output reg alusrc_out_ID_EXE,
	output reg[`ASIZE-1:0]waddr_out_ID_EXE,
	
	//add outputs for control signals
	output reg memWrite_out_ID_EXE,
	output reg memRead_out_ID_EXE,
	output reg memToReg_out_ID_EXE,
	output reg branch_out_ID_EXE,
	
	//program counter signal
	output reg [`ISIZE-1:0] npc_out_ID_EXE,
	
	//input and output for writeen signals
	input WriteEn_in_ID_EXE,
	output reg WriteEn_out_ID_EXE
	
);



//here we have not taken write enable (wen) as it is always 1 for R and I type instructions.
//ID_EXE register to save the values.



always @ (posedge clk) begin
	if(rst)
	begin
		waddr_out_ID_EXE <= 0;
		rdata1_out_ID_EXE <= 0;
		rdata2_out_ID_EXE <= 0;
		imm_out_ID_EXE <=0;
		opcode_out_ID_EXE <=0;
		alusrc_out_ID_EXE <=0;
		memWrite_out_ID_EXE <= 0;
		memRead_out_ID_EXE <= 0;
		memToReg_out_ID_EXE<= 0;
		WriteEn_out_ID_EXE <= 0;
		branch_out_ID_EXE <= 0;
		npc_out_ID_EXE <= 0;
	end
   else
	begin
		waddr_out_ID_EXE <= waddr_in_ID_EXE;
		rdata1_out_ID_EXE <= rdata1_in_ID_EXE;
		rdata2_out_ID_EXE <= rdata2_in_ID_EXE;
		imm_out_ID_EXE <= imm_in_ID_EXE;
		opcode_out_ID_EXE <= opcode_in_ID_EXE;
		alusrc_out_ID_EXE <= alusrc_in_ID_EXE;
		memWrite_out_ID_EXE <= memWrite_in_ID_EXE;
		memRead_out_ID_EXE <= memRead_in_ID_EXE;
		memToReg_out_ID_EXE<= memToReg_in_ID_EXE;
		WriteEn_out_ID_EXE <= WriteEn_in_ID_EXE;
		branch_out_ID_EXE <= branch_in_ID_EXE;
		npc_out_ID_EXE <= npc_in_ID_EXE;
	end
 
end
endmodule


