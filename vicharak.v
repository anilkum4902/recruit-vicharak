`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.09.2024 14:56:20
// Design Name: 
// Module Name: vicharak
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module vicharak(clk,rst);
input clk,rst;
reg [18:0] mem [1024:0];
reg [18:0] r[1024:0];
reg [3:0] pc;
reg [0:3] A,B;
reg [18:0] instrn_reg;
reg [4:0] op_code;
reg [4:0] ALU_OUT;
reg [5:0] immed;
reg [5:0] LWD;
reg [4:0] Dst;
integer i;
parameter Add=4'b0001 , 
sub=4'b0010 , mul=4'b0011 , div=4'b0100 ,inc=4'b0101 ,
dec=4'b0110,And=4'b0111,Or=4'b1000,Nand=4'b1001,Nor=4'b1010,
Xor=4'b1011,Xnor=4'b1100,jmp=4'b1101,Beql=4'b1110,Bnql=4'b1111,Lw=5'b10000,sw=5'b10001;
initial
begin
 for (i = 0; i < 1024; i = i + 1) begin
  mem[i] = $random %(1 << 19);  
   end
   end
 initial
  begin
  for (i = 0; i < 1024; i = i + 1) begin
  r[i] = $random % (1 << 19);  
  end
  end      
       
always@(posedge clk) begin
if(rst)
pc=4'b0000;
else
instrn_reg=mem[pc];
op_code=instrn_reg[18:15];

case(op_code)
 Add: begin
 Dst=instrn_reg[14:11];
 A=instrn_reg[10:7];
 B=instrn_reg[6:3];
 ALU_OUT=r[A]+r[B];
 pc=pc+1;
 r[Dst]=ALU_OUT;
 end
 sub: begin
  Dst=instrn_reg[14:11];
  A=instrn_reg[10:7];
  B=instrn_reg[6:3];
  ALU_OUT=r[A]-r[B];
  pc=pc+1;
  r[Dst]=ALU_OUT;
 end
 mul: begin
  Dst=instrn_reg[14:11];
 A=instrn_reg[10:7];
 B=instrn_reg[6:3];
 ALU_OUT=r[A]-r[B];
 pc=pc+1;
 r[Dst]=ALU_OUT;
 end
 div: begin
  Dst=instrn_reg[14:11];
  A=instrn_reg[10:7];
  B=instrn_reg[6:3];
  ALU_OUT=r[A]/r[B];
  pc=pc+1;
  r[Dst]=ALU_OUT;
  end
  And: begin
   Dst=instrn_reg[14:11];
   A=instrn_reg[10:7];
   B=instrn_reg[6:3];
   ALU_OUT=r[A]&r[B];
   pc=pc+1;
   r[Dst]=ALU_OUT;
   end
   Nand :begin
    Dst=instrn_reg[14:11];
    A=instrn_reg[10:7];
    B=instrn_reg[6:3];
    ALU_OUT=~(r[A]/r[B]);
    pc=pc+1;
    r[Dst]=ALU_OUT;
    end
    Or : begin
     Dst=instrn_reg[14:11];
     A=instrn_reg[10:7];
     B=instrn_reg[6:3];
     ALU_OUT=r[A]|r[B];
     pc=pc+1;
     r[Dst]=ALU_OUT; 
     end
     Nor : begin
      Dst=instrn_reg[14:11];
      A=instrn_reg[10:7];
      B=instrn_reg[6:3];
      ALU_OUT=~(r[A]|r[B]);
      pc=pc+1;
      r[Dst]=ALU_OUT;
      end
      Xor: begin
       Dst=instrn_reg[14:11];
       A=instrn_reg[10:7];
       B=instrn_reg[6:3];
       ALU_OUT=r[A]^r[B];
       pc=pc+1;
       r[Dst]=ALU_OUT;
       end
       Xnor: begin
        Dst=instrn_reg[14:11];
        A=instrn_reg[10:7];
        B=instrn_reg[6:3];
        ALU_OUT=~(r[A]^r[B]);
        pc=pc+1;
        r[Dst]=ALU_OUT;
       end
       Lw : begin
       Dst=instrn_reg[14:11];
       A=instrn_reg[6:3];
       immed=instrn_reg[10:7];
       ALU_OUT=r[A]+immed;
       LWD=mem[ALU_OUT];
       r[Dst]=LWD;
       end
       sw : begin
       B=instrn_reg[14:11];
       A=instrn_reg[10:7];
       immed=instrn_reg[6:3];
       ALU_OUT=r[A]+immed;
       mem[ALU_OUT]=r[B];
       end
       Beql:begin
       A=instrn_reg[14:11];
       B=instrn_reg[10:7];
       immed=instrn_reg[6:3];
       if(r[A]==r[B])begin
       pc=immed;
       end
       end
       Bnql :begin
         A=instrn_reg[14:11];
         B=instrn_reg[10:7];
         immed=instrn_reg[6:3];
         if(r[A]!=r[B])begin
         pc=immed;
         end
         end
       jmp: begin
       pc=instrn_reg[14:0];
       end
       endcase
       end
       
  endmodule
 



