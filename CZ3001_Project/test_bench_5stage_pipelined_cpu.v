`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:18:17 04/08/2016
// Design Name:   pipelined_regfile_4stage
// Module Name:   C:/Users/jwong048/Desktop/CZ3001_Project/test_bench_5stage_pipelined_cpu.v
// Project Name:  CZ3001_Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_regfile_4stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench_5stage_pipelined_cpu;

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

	// Instantiate the Unit Under Test (UUT)
	pipelined_regfile_4stage uut (
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
		.wdataMux(wdataMux)
	);
always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 3'b1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
#25 rst =1;
#25 rst=0;
	end
      
endmodule

