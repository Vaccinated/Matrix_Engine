//Gabriel Garves
//ALU Module
//testbench
//


module alu_tb();
reg enable, readwrite, clk;
reg [7:0] opcode;
reg [255:0] in;
wire [255:0] out;
wire status;

alu yupp(out, in, enable, opcode, readwrite, clk, status);

initial begin
$monitor("clk=%b E=%b RW=%b Op=%h in=%h out=%h",clk,enable,readwrite,opcode,in,out);
#1 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 0; 	opcode = 8'b0000_0001;	in = 255'h0004_000c_0004_0022_0007_0006_000b_0009_0009_0002_0008_000d_0002_000f_0010_0003;  
#2 clk = 0; enable = 1; readwrite = 0; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 0; 	opcode = 8'b0000_0001;	in = 255'h0017_002d_001f_0016_0007_0006_0004_0001_0012_000c_000d_000c_000d_0005_0007_0013;  
#2 clk = 0; enable = 1; readwrite = 0; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 0; readwrite = 0; 	opcode = 8'b1000_0001;	in = 0;  
#2 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b1000_0001;	in = 0;  //add
#2 clk = 1; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 0; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 0; readwrite = 0; 	opcode = 8'b1000_0010;	in = 0;  //sub
#2 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b1000_0010;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 0; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 0; readwrite = 0; 	opcode = 8'b1000_0011;	in = 0;  //mult
#2 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b1000_0011;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 0; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 1; enable = 0; readwrite = 0; 	opcode = 8'b1011_1100;	in = 0;  //scale
#2 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b1011_1100;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 1; 	opcode = 8'b0000_1001;	in = 0;  
#2 clk = 0; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0; 
#2 clk = 1; enable = 0; readwrite = 0; 	opcode = 8'b1000_0101;	in = 0;  //trans
#2 clk = 0; enable = 0; readwrite = 0; 	opcode = 8'b1000_0101;	in = 0;  
#2 clk = 1; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;  
#2 clk = 0; enable = 1; readwrite = 1; 	opcode = 8'b0000_0001;	in = 0;   

$finish;
end
endmodule