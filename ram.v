// a Simple memory in Verilog
// with separate input and output data buses
// Mark W. Welker
//
// If memory not enabled data out should be hiz
// Route data to/from memory array as per ReadWrite bit
// ReadWrite 1 = Read; at risingedge
//
// Modified by Gabriel Garves
//
// 256 wide by 16 deep RAM:


module ram(DataOut, DataIn, Address, Enable, ReadWrite, Clock);

input	Enable, ReadWrite, Clock;
input 	[255:0] DataIn;
input	[3:0] Address;
output 	reg [255:0] DataOut;

reg		[255:0] MemArray[0:15];

initial begin
MemArray[0] = 255'h0004_000c_0004_0022_0007_0006_000b_0009_0009_0002_0008_000d_0002_000f_0010_0003;
MemArray[1] = 255'h0017_002d_001f_0016_0007_0006_0004_0001_0012_000c_000d_000c_000d_0005_0007_0013;
end

always @ (posedge Clock)

	if (Enable)	
		begin
			if(ReadWrite) DataOut = MemArray[Address];
			else MemArray[Address] = DataIn;
		end
	else
		DataOut = 255'bz;
		
//always @ (negedge Clock)						//Reset Data bus
		//DataOut = 255'bz;
		
endmodule
