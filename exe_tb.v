//Gabriel Garves
//
//Matrix engine testbench

module exe_tb();

reg Clock;			
wire Status;				    
wire [3:0] Enable;		
wire [2:0] ReadWrite;	
wire [3:0] Address;		
wire [7:0] Opcode;
wire [31:0] Data1;
wire [255:0] ALUData;
wire [255:0] Data;

//wiring:

exe one(Clock,Status,Data1,Enable,ReadWrite,Address,Opcode);

alu two(ALUData, Data, Enable[2], Opcode, ReadWrite[2], Clock, Status);

register three(Data, ALUData, Enable[1], ReadWrite[1], Clock);

ram four(Data, ALUData, Address, Enable[0], ReadWrite[0], Clock);

inst_register five(Data1, Enable[3], Clock, Address);

initial
#0 Clock = 0;

initial 
repeat(85)
begin
$monitor("clk=%b E=%b RW=%b Op=%b Add=%h S=%b Data1=%b Data=%h",Clock,Enable,ReadWrite,Opcode,Address,Status,Data1,Data);
#1 Clock = 1;
#1 Clock = 0;
end

endmodule