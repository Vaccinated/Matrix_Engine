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
//Single register:


module register(DataOut, DataIn, Enable, ReadWrite, Clock);

input	Enable, ReadWrite, Clock;
input 	[255:0] DataIn;
output 	reg [255:0] DataOut;

reg		[255:0] MemArray;

always @ (posedge Clock)

	if (Enable)	
		begin
			if(ReadWrite) DataOut = MemArray;
			else MemArray = DataIn;
		end
	else
		DataOut = 255'bz;
		
endmodule