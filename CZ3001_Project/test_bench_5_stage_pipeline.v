`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:06 04/09/2016
// Design Name:   pipelined_5_stage_cpu
// Module Name:   C:/Users/jwong048/Desktop/CZ3001_Project/test_bench_5_stage_pipeline.v
// Project Name:  CZ3001_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_5_stage_cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench_5_stage_pipeline;

	// Inputs
	reg clk;
	reg rst;
	reg [2:0] fileid;

	// Outputs
	wire [31:0] PCOUT;
	wire [31:0] INST;
	wire [31:0] rdata1;
	wire [31:0] rdata2;
	wire [31:0] aluout;
	wire zero;
	wire [4:0] waddrMux;
	wire [31:0] wdataMux;
	wire [31:0] read_data_DM;
	wire [31:0] rdata1_ID_EXE;
	wire [31:0] rdata2_ID_EXE;
	wire [31:0] rdata2_imm_ID_EXE;
	wire [31:0] imm_ID_EXE;
	wire [4:0] waddr_out_ID_EXE;
	wire alusrc_ID_EXE;
	wire [2:0] aluop_ID_EXE;
	wire wen_ID_EXE;
	wire memtoreg_ID_EXE;
	wire memwrite_ID_EXE;
	wire branch_ID_EXE;
	wire memread_ID_EXE;
	wire regdst_ID_EXE;
	wire [31:0] PCIN_ID_EXE;
	wire [31:0] rdata2_EX_MEM;
	wire [31:0] alu_result_EX_MEM;
	wire [4:0] waddr_out_EX_MEM;
	wire memwrite_EX_MEM;
	wire memread_EX_MEM;
	wire memtoreg_EX_MEM;
	wire wen_EX_MEM;
	wire [31:0] alu_result_MEM_WB;
	wire [4:0] waddr_out_MEM_WB;
	wire memtoreg_MEM_WB;
	wire WriteEn_MEM_WB;
	wire [31:0] rdata_DM_out_MEM_WB;

	// Instantiate the Unit Under Test (UUT)
	pipelined_5_stage_cpu uut (
		.clk(clk), 
		.rst(rst), 
		.fileid(fileid), 
		.PCOUT(PCOUT), 
		.INST(INST), 
		.rdata1(rdata1), 
		.rdata2(rdata2), 
		.aluout(aluout), 
		.zero(zero), 
		.waddrMux(waddrMux), 
		.wdataMux(wdataMux), 
		.read_data_DM(read_data_DM), 
		.rdata1_ID_EXE(rdata1_ID_EXE), 
		.rdata2_ID_EXE(rdata2_ID_EXE), 
		.rdata2_imm_ID_EXE(rdata2_imm_ID_EXE), 
		.imm_ID_EXE(imm_ID_EXE), 
		.waddr_out_ID_EXE(waddr_out_ID_EXE), 
		.alusrc_ID_EXE(alusrc_ID_EXE), 
		.aluop_ID_EXE(aluop_ID_EXE), 
		.wen_ID_EXE(wen_ID_EXE), 
		.memtoreg_ID_EXE(memtoreg_ID_EXE), 
		.memwrite_ID_EXE(memwrite_ID_EXE), 
		.branch_ID_EXE(branch_ID_EXE), 
		.memread_ID_EXE(memread_ID_EXE), 
		.regdst_ID_EXE(regdst_ID_EXE), 
		.PCIN_ID_EXE(PCIN_ID_EXE), 
		.rdata2_EX_MEM(rdata2_EX_MEM), 
		.alu_result_EX_MEM(alu_result_EX_MEM), 
		.waddr_out_EX_MEM(waddr_out_EX_MEM), 
		.memwrite_EX_MEM(memwrite_EX_MEM), 
		.memread_EX_MEM(memread_EX_MEM), 
		.memtoreg_EX_MEM(memtoreg_EX_MEM), 
		.wen_EX_MEM(wen_EX_MEM), 
		.alu_result_MEM_WB(alu_result_MEM_WB), 
		.waddr_out_MEM_WB(waddr_out_MEM_WB), 
		.memtoreg_MEM_WB(memtoreg_MEM_WB), 
		.WriteEn_MEM_WB(WriteEn_MEM_WB),
		.rdata_DM_out_MEM_WB(rdata_DM_out_MEM_WB)
	);
always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 1'b1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
#25 rst =1;
#25 rst=0;
	end
      
endmodule

