//Gabriel Garves
//ALU Module
//
//ReadWrite 1 = Read;
//
//Opcode[7] = 1  signals to ALU begin calculations
//
//Opcode[6:3] This holds the scalar value if scale operation
//
//Opcode[2:0] This is the opcode
//
//Status = 0 signals to engine calculations are complete.
//
//Enable = 1 for reading or writing to internal memory.
//
//Matrices:
//Row 1 Column 1 would be DataIn[255:240]
//Row 1 Column 2 would be DataIn[239:224] etc


module alu(DataOut, DataIn, Enable, Opcode, ReadWrite, Clock, Status);

input	Enable, ReadWrite, Clock;
input	[7:0] Opcode;
input 	[255:0] DataIn;
output	reg Status = 1;
output 	reg [255:0] DataOut;

reg		[255:0] MemArray[0:2];	//256 by 3 memory

reg		[2:0] Address1 = 3'b00;	//Register1
reg		[2:0] Address2 = 3'b01;	//Register2
reg		[2:0] Address3 = 3'b10;	//Register3	(result)

reg 	toggle = 1'b1;		//Toggle between registers (more below)

parameter add   = 3'b001;	//Opcodes
parameter sub   = 3'b010;
parameter mult  = 3'b011;
parameter scale = 3'b100;
parameter trans = 3'b101;

always @ (posedge Clock)
begin
	if (Opcode[7])					//ALU Calculations
		case (Opcode[2:0])
			add:  	begin
						MemArray[2][255:240] = MemArray[0][255:240] + MemArray[1][255:240];		MemArray[2][239:224] = MemArray[0][239:224] + MemArray[1][239:224];		MemArray[2][223:208] = MemArray[0][223:208] + MemArray[1][223:208];		MemArray[2][207:192] = MemArray[0][207:192] + MemArray[1][207:192];
						MemArray[2][191:176] = MemArray[0][191:176] + MemArray[1][191:176];		MemArray[2][175:160] = MemArray[0][175:160] + MemArray[1][175:160];		MemArray[2][159:144] = MemArray[0][159:144] + MemArray[1][159:144];		MemArray[2][143:128] = MemArray[0][143:128] + MemArray[1][143:128];
						MemArray[2][127:112] = MemArray[0][127:112] + MemArray[1][127:112];		MemArray[2][111:96]  = MemArray[0][111:96]  + MemArray[1][111:96];		MemArray[2][95:80]   = MemArray[0][95:80]   + MemArray[1][95:80];		MemArray[2][79:64]   = MemArray[0][79:64]   + MemArray[1][79:64];
						MemArray[2][63:48]   = MemArray[0][63:48]   + MemArray[1][63:48];		MemArray[2][47:32]   = MemArray[0][47:32]   + MemArray[1][47:32];		MemArray[2][31:16]   = MemArray[0][31:16]   + MemArray[1][31:16];		MemArray[2][15:0]    = MemArray[0][15:0]    + MemArray[1][15:0];
						Status = 1'b0;
					end
				  
			sub:  	begin
						MemArray[2][255:240] = MemArray[0][255:240] - MemArray[1][255:240];		MemArray[2][239:224] = MemArray[0][239:224] - MemArray[1][239:224];		MemArray[2][223:208] = MemArray[0][223:208] - MemArray[1][223:208];		MemArray[2][207:192] = MemArray[0][207:192] - MemArray[1][207:192];
						MemArray[2][191:176] = MemArray[0][191:176] - MemArray[1][191:176];		MemArray[2][175:160] = MemArray[0][175:160] - MemArray[1][175:160];		MemArray[2][159:144] = MemArray[0][159:144] - MemArray[1][159:144];		MemArray[2][143:128] = MemArray[0][143:128] - MemArray[1][143:128];
						MemArray[2][127:112] = MemArray[0][127:112] - MemArray[1][127:112];		MemArray[2][111:96]  = MemArray[0][111:96]  - MemArray[1][111:96];		MemArray[2][95:80]   = MemArray[0][95:80]   - MemArray[1][95:80];		MemArray[2][79:64]   = MemArray[0][79:64]   - MemArray[1][79:64];
						MemArray[2][63:48]   = MemArray[0][63:48]   - MemArray[1][63:48];		MemArray[2][47:32]   = MemArray[0][47:32]   - MemArray[1][47:32];		MemArray[2][31:16]   = MemArray[0][31:16]   - MemArray[1][31:16];		MemArray[2][15:0]    = MemArray[0][15:0]    - MemArray[1][15:0];
						Status = 1'b0;
					end
		
			trans:	begin
						MemArray[2][255:240] = MemArray[0][255:240];							MemArray[2][239:224] = MemArray[0][191:176];							MemArray[2][223:208] = MemArray[0][127:112]; 							MemArray[2][207:192] = MemArray[0][63:48];
						MemArray[2][191:176] = MemArray[0][239:224];							MemArray[2][175:160] = MemArray[0][175:160];							MemArray[2][159:144] = MemArray[0][111:96];								MemArray[2][143:128] = MemArray[0][47:32];
						MemArray[2][127:112] = MemArray[0][223:208];							MemArray[2][111:96]  = MemArray[0][159:144]; 							MemArray[2][95:80]   = MemArray[0][95:80];  							MemArray[2][79:64]   = MemArray[0][31:16];  
						MemArray[2][63:48]   = MemArray[0][207:192];  							MemArray[2][47:32]   = MemArray[0][143:128];  							MemArray[2][31:16]   = MemArray[0][79:64]; 								MemArray[2][15:0]    = MemArray[0][15:0];  
						Status = 1'b0;
					end
					
			mult:	begin
						MemArray[2][255:240] = (MemArray[0][255:240]*MemArray[1][255:240] + MemArray[0][239:224]*MemArray[1][191:176] + MemArray[0][223:208]*MemArray[1][127:112] + MemArray[0][207:192]*MemArray[1][63:48]);		//R1C1
						MemArray[2][239:224] = (MemArray[0][255:240]*MemArray[1][239:224] + MemArray[0][239:224]*MemArray[1][175:160] + MemArray[0][223:208]*MemArray[1][111:96]  + MemArray[0][207:192]*MemArray[1][47:32]);		//R1C2
						MemArray[2][223:208] = (MemArray[0][255:240]*MemArray[1][223:208] + MemArray[0][239:224]*MemArray[1][159:144] + MemArray[0][223:208]*MemArray[1][95:80]   + MemArray[0][207:192]*MemArray[1][31:16]);		//R1C3
						MemArray[2][207:192] = (MemArray[0][255:240]*MemArray[1][207:192] + MemArray[0][239:224]*MemArray[1][143:128] + MemArray[0][223:208]*MemArray[1][79:64]   +  MemArray[0][207:192]*MemArray[1][15:0]);		//R1C4
						
						MemArray[2][191:176] = (MemArray[0][191:176]*MemArray[1][255:240] + MemArray[0][175:160]*MemArray[1][191:176] + MemArray[0][159:144]*MemArray[1][127:112] + MemArray[0][143:128]*MemArray[1][63:48]);		//R2C1
						MemArray[2][175:160] = (MemArray[0][191:176]*MemArray[1][239:224] + MemArray[0][175:160]*MemArray[1][175:160] + MemArray[0][159:144]*MemArray[1][111:96]  + MemArray[0][143:128]*MemArray[1][47:32]);		//R2C2
						MemArray[2][159:144] = (MemArray[0][191:176]*MemArray[1][223:208] + MemArray[0][175:160]*MemArray[1][159:144] + MemArray[0][159:144]*MemArray[1][95:80]   + MemArray[0][143:128]*MemArray[1][31:16]);		//R2C3
						MemArray[2][143:128] = (MemArray[0][191:176]*MemArray[1][207:192] + MemArray[0][175:160]*MemArray[1][143:128] + MemArray[0][159:144]*MemArray[1][79:64]   +  MemArray[0][143:128]*MemArray[1][15:0]);		//R2C4
						
						MemArray[2][127:112] = (MemArray[0][127:112]*MemArray[1][255:240] + MemArray[0][111:96]*MemArray[1][191:176]  + MemArray[0][95:80]*MemArray[1][127:112]   + MemArray[0][79:64]*MemArray[1][63:48]);		//R3C1
						MemArray[2][111:96]  = (MemArray[0][127:112]*MemArray[1][239:224] + MemArray[0][111:96]*MemArray[1][175:160]  + MemArray[0][95:80]*MemArray[1][111:96]    + MemArray[0][79:64]*MemArray[1][47:32]);		//R3C2
						MemArray[2][95:80]   = (MemArray[0][127:112]*MemArray[1][223:208] + MemArray[0][111:96]*MemArray[1][159:144]  + MemArray[0][95:80]*MemArray[1][95:80]     + MemArray[0][79:64]*MemArray[1][31:16]);		//R3C3
						MemArray[2][79:64]   = (MemArray[0][127:112]*MemArray[1][207:192] + MemArray[0][111:96]*MemArray[1][143:128]  + MemArray[0][95:80]*MemArray[1][79:64]     +  MemArray[0][79:64]*MemArray[1][15:0]);		//R3C4
																																	 										      
						MemArray[2][63:48] 	 = (MemArray[0][63:48]*MemArray[1][255:240]   + MemArray[0][47:32]*MemArray[1][191:176]   + MemArray[0][31:16]*MemArray[1][127:112]   + MemArray[0][15:0]*MemArray[1][63:48]);		//R4C1
						MemArray[2][47:32] 	 = (MemArray[0][63:48]*MemArray[1][239:224]   + MemArray[0][47:32]*MemArray[1][175:160]   + MemArray[0][31:16]*MemArray[1][111:96]    + MemArray[0][15:0]*MemArray[1][47:32]);		//R4C2
						MemArray[2][31:16] 	 = (MemArray[0][63:48]*MemArray[1][223:208]   + MemArray[0][47:32]*MemArray[1][159:144]   + MemArray[0][31:16]*MemArray[1][95:80]     + MemArray[0][15:0]*MemArray[1][31:16]);		//R4C3
						MemArray[2][15:0]  	 = (MemArray[0][63:48]*MemArray[1][207:192]   + MemArray[0][47:32]*MemArray[1][143:128]   + MemArray[0][31:16]*MemArray[1][79:64]     +  MemArray[0][15:0]*MemArray[1][15:0]);		//R4C4
						
						Status = 1'b0;
					end
					
			scale:	begin
						MemArray[2][255:240] = MemArray[0][255:240] * Opcode[6:3]; 				MemArray[2][239:224] = MemArray[0][239:224] * Opcode[6:3];				MemArray[2][223:208] = MemArray[0][223:208] * Opcode[6:3];				MemArray[2][207:192] = MemArray[0][207:192] * Opcode[6:3];
						MemArray[2][191:176] = MemArray[0][191:176] * Opcode[6:3]; 				MemArray[2][175:160] = MemArray[0][175:160] * Opcode[6:3];				MemArray[2][159:144] = MemArray[0][159:144] * Opcode[6:3];				MemArray[2][143:128] = MemArray[0][143:128] * Opcode[6:3];
						MemArray[2][127:112] = MemArray[0][127:112] * Opcode[6:3]; 				MemArray[2][111:96]  = MemArray[0][111:96]  * Opcode[6:3];				MemArray[2][95:80]   = MemArray[0][95:80]   * Opcode[6:3];				MemArray[2][79:64]   = MemArray[0][79:64]   * Opcode[6:3];
						MemArray[2][63:48]   = MemArray[0][63:48]   * Opcode[6:3];  			MemArray[2][47:32]   = MemArray[0][47:32]   * Opcode[6:3];				MemArray[2][31:16]   = MemArray[0][31:16]   * Opcode[6:3];				MemArray[2][15:0]    = MemArray[0][15:0]    * Opcode[6:3];
						Status = 1'b0;
					end
					
			default: $stop;		//error check
		endcase
		
	else if (Enable && toggle && !ReadWrite)	//toggle variable allows for switching														
			begin							    //between Register1 and Register2
				MemArray[Address1] = DataIn;    //without address input
				toggle = ~toggle;	
			end
			
	else if(Enable && !toggle && !ReadWrite)	//Must clock through both these exactly once per operation
			begin								//ALU only uses register1 for scale and transpose
				MemArray[Address2] = DataIn;	
				toggle = ~toggle;				
			end
			
	else if(Enable && ReadWrite)				//Throw results on the bus
			DataOut = MemArray[Address3];
	else
		begin
		DataOut = 255'bz;                       //Prevent Xs'
		Status = 1'b1;							//Reset Status bit
		end
end
endmodule	