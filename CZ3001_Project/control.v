//control unit for write enable and ALU control

`include "define.v"

module control(
  input [5:0] inst_cntrl, 
  output reg wen_cntrl,
  output reg alusrc_cntrl,
  output reg [2:0] aluop_cntrl,
  output reg  regdst_cntrl,
  output reg branch_cntrl,
  output reg  memwrite_cntrl,
  output reg  MemRead_cntrl,
  output reg  MemToReg_cntrl
  );
  
  always@(inst_cntrl)
  begin
		wen_cntrl=1;
		alusrc_cntrl=0;
		branch_cntrl=0;
		regdst_cntrl=1;
		MemRead_cntrl=0;
		MemToReg_cntrl=1;
		memwrite_cntrl=0;
 
    case(inst_cntrl)
			`ADD: begin
					
					alusrc_cntrl=0;
					aluop_cntrl=inst_cntrl[2:0];
			end
        `SUB: begin
                
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `AND: begin
                
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `XOR: begin
                
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
        end
     
        `COM: begin
                
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
        end
        `MUL: begin
               
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
			end
		  `ADDI: begin
                
					 alusrc_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
					 regdst_cntrl=0;
        end
		  `LW: begin
					regdst_cntrl=0;
					MemRead_cntrl=1;
					MemToReg_cntrl=0;
					alusrc_cntrl=1;
					aluop_cntrl=inst_cntrl[2:0];
		  
			end
			
		  `SW: begin
					 wen_cntrl=0;
					 alusrc_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
					 regdst_cntrl=0;
					 MemToReg_cntrl=0;
					 memwrite_cntrl=1;
        end
		  `BEQ: begin
				wen_cntrl=0;
				regdst_cntrl=1;
				branch_cntrl=1;
				aluop_cntrl=3'b001; 
				end
		  
		default: begin
				wen_cntrl=0;
				alusrc_cntrl=0;
				aluop_cntrl=inst_cntrl[2:0];
		end	
		
    endcase
  end
  
endmodule
