`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:33 02/18/2016 
// Design Name: 
// Module Name:    pipelined_regfile_4stage 
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
module pipelined_regfile_4stage(
clk, rst, fileid, PCOUT, INST, 
rdata1, rdata2,aluout,zero,
waddrMux,wdataMux,read_data_DM,
rdata1_ID_EXE,
 rdata2_ID_EXE,
rdata2_imm_ID_EXE,
 imm_ID_EXE,
 waddr_out_ID_EXE,	
 alusrc_ID_EXE,
aluop_ID_EXE,

 wen_ID_EXE,
 memtoreg_ID_EXE,
 memwrite_ID_EXE,
 branch_ID_EXE,
 memread_ID_EXE,
 regdst_ID_EXE,

PCIN_ID_EXE,

//PIPE2
rdata2_EX_MEM,
alu_result_EX_MEM, 
waddr_out_EX_MEM,	

 memwrite_EX_MEM,
 memread_EX_MEM, 
 memtoreg_EX_MEM, 
 wen_EX_MEM,		

//PIPE3
 alu_result_MEM_WB, 
waddr_out_MEM_WB, 
 memtoreg_EX_WB,
 WriteEn_MEM_WB);


input clk;				
											
input	rst;

input [2:0] fileid; 
output [`ISIZE-1:0]PCOUT;
output [`DSIZE-1:0] rdata1;
output [`DSIZE-1:0] rdata2;
output [`DSIZE-1:0]INST;
output [`DSIZE-1:0] aluout;
output zero;


output [`ASIZE-1:0] waddrMux;
output [`DSIZE-1:0] wdataMux;

output [`DSIZE-1:0] read_data_DM;
//PIPE1
output [`DSIZE-1:0] rdata1_ID_EXE;
output [`DSIZE-1:0] rdata2_ID_EXE;
output [`DSIZE-1:0] rdata2_imm_ID_EXE;
output [`DSIZE-1:0] imm_ID_EXE;
output [`ASIZE-1:0] waddr_out_ID_EXE;	
output alusrc_ID_EXE;
output [2:0] aluop_ID_EXE;

output wen_ID_EXE;
output memtoreg_ID_EXE;
output memwrite_ID_EXE;
output branch_ID_EXE;
output memread_ID_EXE;
output regdst_ID_EXE;

output [`ISIZE-1:0]PCIN_ID_EXE;

//PIPE2
output [`DSIZE-1:0] rdata2_EX_MEM;
output [`DSIZE-1:0] alu_result_EX_MEM; 
output [`ASIZE-1:0] waddr_out_EX_MEM;	

output memwrite_EX_MEM;
output memread_EX_MEM; 
output memtoreg_EX_MEM; 
output wen_EX_MEM;		

//PIPE3
output [`DSIZE-1:0] alu_result_MEM_WB; 
output [`ASIZE-1:0] waddr_out_MEM_WB; 
output memtoreg_EX_WB;
output WriteEn_MEM_WB;

//control signals 
wire wen;
wire alusrc;
wire [2:0] aluop;
wire memtoreg;
wire memwrite;
wire branch;
wire memread;
wire regdst;

//AND GATE FOR BRANCH
wire pcsrc;
assign pcsrc = zero & branch_ID_EXE;

//Program counter
wire [`ISIZE-1:0]PCIN, nPC;

//adder
wire [`ISIZE-1:0] res;
assign res = PCIN_ID_EXE + imm_ID_EXE; 

PC1 pc(
	.clk(clk),
	.rst(rst),
	.nextPC(PCIN),
	.currPC(PCOUT)
);//PCOUT is your PC value and PCIN is your next PC


assign PCIN = PCOUT + 32'b1; //increments PC to PC +1


//instruction memory
memory im( 
	.clk(clk), 
	.rst(rst), 
	.wen(1'b0), 
	.addr(PCOUT), 
	.data_in(32'b0), 
	.fileid(fileid),
	.data_out(INST)
);//note that memory read is having one clock cycle delay as memory is a slow operation

//DATA MEMORY
dmemory dm( 
		.clk(clk), 
		.rst(rst), 
		.memwrite(memwrite_EX_MEM), 
		.memread(memread_EX_MEM),
		.addr(alu_result_EX_MEM), 
		.data_in(rdata2_EX_MEM), 
		.fileid(fileid),
		.data_out(read_data_DM)
);


//initialization of regfiles is done as hardcoding here



control C0 (
.inst_cntrl(INST[31:26]),
.wen_cntrl(wen),
.alusrc_cntrl(alusrc), 
.aluop_cntrl(aluop), 
.regdst_cntrl(regdst),
.branch_cntrl(branch),
.memwrite_cntrl(memwrite),
.MemRead_cntrl(memread),
.MemToReg_cntrl(memtoreg)
);


regfile  RF0 ( 
		.clk(clk), 
		.rst(rst), 
		.wen(WriteEn_MEM_WB), 
		.raddr1(INST[25:21]), 
		.raddr2(INST[20:16]), 
		.waddr(waddr_out_MEM_WB), 
		.wdata(wdataMux),
		.rdata1(rdata1), 
		.rdata2(rdata2)
);//note that waddr needs to come from pipeline register 





//sign extension for immediate needs to be done for I type instuction.
//you can add that here
wire [`DSIZE-1:0]extended_imm;
//assign extended_imm=({16'b0,INST[15:0]}); //zero extension
assign extended_imm=({{16{INST[15]}},INST[15:0]}); // sign extension

//PIPELINE STAGE 1
ID_EXE_stage PIPE1(
		.clk(clk), 
		.rst(rst), 
		.rdata1_in_ID_EXE(rdata1),
		.rdata2_in_ID_EXE(rdata2),
		.imm_in_ID_EXE(extended_imm),
		.opcode_in_ID_EXE(aluop), 
		.alusrc_in_ID_EXE(alusrc), 
		.waddr_in_ID_EXE(waddrMux),
		.memWrite_in_ID_EXE(memwrite),
		.memRead_in_ID_EXE(memread),
		.memToReg_in_ID_EXE(memtoreg),
		.branch_in_ID_EXE(branch),
		.npc_in_ID_EXE(PCIN),
		.WriteEn_in_ID_EXE(wen), 
		.waddr_out_ID_EXE(waddr_out_ID_EXE),
		.imm_out_ID_EXE(imm_ID_EXE), 
		.rdata1_out_ID_EXE(rdata1_ID_EXE), 
		.rdata2_out_ID_EXE(rdata2_ID_EXE),
		.alusrc_out_ID_EXE(alusrc_ID_EXE), 
		.opcode_out_ID_EXE(aluop_ID_EXE), 
		.memWrite_out_ID_EXE(memwrite_ID_EXE),
		.memRead_out_ID_EXE(memread_ID_EXE), 
		.memToReg_out_ID_EXE(memtoreg_ID_EXE),
		 .branch_out_ID_EXE(branch_ID_EXE), 
		 .npc_out_ID_EXE(PCIN_ID_EXE),
		 .WriteEn_out_ID_EXE(wen_ID_EXE)
 );//immediate value is only zero extended. As we are concentrationg only on R type instuctions, this is not an issue.



//ALU
alu ALU0 ( .a(rdata1_ID_EXE), .b(rdata2_imm_ID_EXE), .op(aluop_ID_EXE), .out(aluout), .zero(zero));//ALU takes its input from pipeline register and the output of mux.
 

//PIPELINE STAGE 2
EX_MEM_stage PIPE2(
	  .clk(clk),
	  .rst(rst), 
	  .rdata2_in_EX_MEM(rdata2), 
	  .alu_result_in_EX_MEM(aluout),
	  .waddr_in_EX_MEM(waddr_out_ID_EXE),
	  .memWrite_in_EX_MEM(memwrite_ID_EXE), 
	  .memRead_in_EX_MEM(memread_ID_EXE), 
	  .memToReg_in_EX_MEM(memtoreg_ID_EXE), 
	  .WriteEn_in_EX_MEM(wen_ID_EXE),
	  .rdata2_out_EX_MEM(rdata2_EX_MEM),
	  .alu_result_out_EX_MEM(alu_result_EX_MEM), 
	  .memWrite_out_EX_MEM(memwrite_EX_MEM), 
	  .memRead_out_EX_MEM(memread_EX_MEM), 
	  .memToReg_out_EX_MEM(memtoreg_EX_MEM), 
	  .WriteEn_out_EX_MEM(wen_EX_MEM) ,
	  .waddr_out_EX_MEM(waddr_out_EX_MEM)
  );



//PIPELINE STAGE 3
MEM_WB_stage PIPE3(
		.clk(clk), 
		.rst(rst), 
		.alu_result_in(alu_result_EX_MEM), 
		.WriteEn_in(wen_EX_MEM), 
		.memToReg_in(memtoreg_EX_MEM), 
		.waddr_in(waddr_out_EX_MEM), 
		.memToReg_out(memtoreg_EX_WB), 
		.alu_result_out(alu_result_MEM_WB), 
		.waddr_out(waddr_out_MEM_WB), 
		.WriteEn_out(WriteEn_MEM_WB)
);


//mux
assign rdata2_imm_ID_EXE=alusrc_ID_EXE ? imm_ID_EXE : rdata2_ID_EXE;// mux for selecting immedaite or the rdata2 value

//mux for waddr fo regfile
assign waddrMux=regdst? INST[20:16]: INST[15:11]; //mux for selecting rt or rd

//mux for memtoreg

assign wdataMux= memtoreg_EX_WB ? alu_result_MEM_WB : read_data_DM;  

//mux for branch based on pcsrc control signal
//assign nPC = pcsrc ? (res-1'b1) : PCIN;

endmodule


