//Gabriel Garves
//Execution Engine
//
//32-Bit ISA      opcode        src1         src2       dest  
//				inst[31:24]	 inst[23:16]  inst[15:8]  inst[7:0]
//		 
//Opcode: 
//0000_0001 -> add
//0000_0010	-> sub
//0000_0011 -> multiply
//0000_0100 -> scale
//0000_0101 -> transpose
//1111_1111 -> stop
//
//inst[16], inst[8], inst[0] Represents value in RAM if high
//inst[17], inst[9], inst[1] Represents value in Register if high
//inst[23:20], inst [15:12], inst[7:4] holds address for RAM 
//
//inst [15:12] can hold scalar value for scale operation
//
//ReadWrite 1 = Read
//

module exe(Clock,Status,DataIn,Enable,ReadWrite,Address,Opcode);

input Clock;			
input Status;			//From ALU
input [31:0] DataIn;	//From Inst_register

output reg [3:0] Enable;		//RAM=0, Register=1, ALU=2, Inst_register=3
output reg [2:0] ReadWrite;		//RAM=0, Register=1, ALU=2
output reg [3:0] Address;		//To all except ALU
output reg [7:0] Opcode;		//To ALU

parameter Fetch     = 3'b000;	//6 different states
parameter Decode    = 3'b001;
parameter LoadR1    = 3'b010;
parameter LoadR2    = 3'b011;
parameter SignalALU = 3'b100;
parameter Store     = 3'b101;

reg [2:0] state = 3'b000;		//For case statement
reg [3:0] PC  = 4'b0000;		//Program Counter
reg [31:0] inst;				//Holds current Instruction
reg [1:0] stall = 1'b0;			//Delays a clock cycle so data is in sync.

always @ (posedge Clock)
begin
	case (state)
	Fetch     : begin	
					Enable = 4'b1000;			//Signal Inst_register 
					Address  = PC;				//and send address
					stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = Decode;		//Next state
							Enable =4'b0000;	//Update enables
							inst = DataIn;			//Put instruction in a register. 
							stall = stall + 1'b1;
							end
				end
	
	Decode    : begin
					PC = PC + 1'b1;				//increment PC
					state = LoadR1;				//Move to next state
					if(inst[31:24] == 8'hff)	//Stop opcode
						$stop; 
				end
	
	LoadR1    : begin				
					if(inst[16])
						begin
						Enable = 4'b0001;		//Enable RAM
						ReadWrite = 3'b001;		//Set RAM to read and ALU to write
						Address = inst[23:20];	//Put address for RAM on bus
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = LoadR2;		//Next state
							Enable =4'b0100;	//Enable ALU disable RAM
							stall = stall + 1'b1;
							end
						end
					else if (inst[17])
						begin
						Enable = 4'b0010;		//Enable Register
						ReadWrite = 3'b010;		//Set Register to read and ALU to write
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = LoadR2;		//Next state
							Enable =4'b0100;	//Enable ALU disable RAM
							stall = stall + 1'b1;
							end
						end
				end
	
	LoadR2	  : begin							//If scale or transpose, still need to
					if(inst[8])					//clock through even if R2 is never used.
						begin
						Enable = 4'b0001;		//Enable RAM
						ReadWrite = 4'b0001;	//Set RAM to read and ALU to write
						Address = inst[15:12];	//Put address for RAM on bus
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = SignalALU;	//Next state
							Enable =4'b0100;    //Enable ALU disable RAM
							stall = stall + 1'b1;
							end
						end
					else if (inst[9])
						begin
						Enable = 4'b0010;		////Enable Register and ALU
						ReadWrite = 3'b010;		//Set Register to read and ALU to write
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = SignalALU;	//Next state
							Enable =4'b0100;    //Enable ALU disable RAM
							stall = stall + 1'b1;
							end
						end
				end
	
	SignalALU : begin
					Enable = 4'b0000;			//Update Enables
					Opcode[7] = 1'b1;			//Tells ALU to go
					Opcode[2:0] = inst[26:24];	//Operation encoded here
					Opcode[6:3] = inst[15:12];	//Scalar if needed
					if(!Status)
						begin
						state = Store;			//Move to next state when ALU is done
						Opcode = 8'bz;			//Update Opcode
						end
				end
	
	Store	  : begin
					if(inst[0])					
						begin
						Enable = 4'b0100;		//Enable ALU
						ReadWrite = 3'b100;		//Set ALU to read and RAM to write 
						Address = inst[7:4];	//Put address for RAM on bus
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = Fetch;		//Next state
							Enable =4'b0001;    //Enables
							stall = stall + 1'b1;
							end
						end
					else if (inst[1])
						begin
						Enable = 4'b0100;		//Enable Register and ALU
						ReadWrite = 3'b100;		//Set ALU to read and RAM to write 
						stall = stall + 1'b1;
						if(stall == 2'b11)
							begin
							state = Fetch;		//Next state
							Enable =4'b0010;    //Enables
							stall = stall + 1'b1;
							end
						end
				end
	default : $stop;	//error check
	endcase
end
endmodule