// a Simple memory in Verilog
// with separate input and output data buses
// Mark W. Welker
//
// If memory not enabled data out should be hiz
// Route data to/from memory array as per ReadWrite bit
// ReadWrite 1 = Read; at risingedge
//
//Modified by Gabriel Garves
//
//32 by 15 deep Instruction Register (ROM for now): 


module inst_register(DataOut, Enable, Clock, Address);

input	Enable, Clock;
input	[3:0] Address;
output 	reg [31:0] DataOut;

reg		[31:0] MemArray [0:15];

always @ (posedge Clock)

	if (Enable)	
		begin
			DataOut = MemArray[Address];
		end
	else
		DataOut = 32'bz;

initial begin	 //instructions
				 //opcode     src1     scr2     dest
MemArray[0]  = 32'b00000001_00000001_00010001_00100001;	 	//add
MemArray[1]  = 32'b00000010_00100001_00000001_00110001;		//sub
MemArray[2]  = 32'b00000101_00100001_00000010_01000001;	    //transpose
MemArray[3]  = 32'b00000100_01000001_01110010_00000010;     //scale
MemArray[4]  = 32'b00000011_00000010_01000001_01010001;     //multiply
MemArray[5]  = 32'b11111111_00000000_00000000_00000000;     //stop
MemArray[6]  = 32'b00000000_00000000_00000000_00000000;
MemArray[7]  = 32'b00000000_00000000_00000000_00000000;
MemArray[8]  = 32'b00000000_00000000_00000000_00000000;
MemArray[9]  = 32'b00000000_00000000_00000000_00000000;
MemArray[10] = 32'b00000000_00000000_00000000_00000000;
MemArray[11] = 32'b00000000_00000000_00000000_00000000;
MemArray[12] = 32'b00000000_00000000_00000000_00000000;
MemArray[13] = 32'b00000000_00000000_00000000_00000000;
MemArray[14] = 32'b00000000_00000000_00000000_00000000;
MemArray[15] = 32'b00000000_00000000_00000000_00000000;
end
endmodule