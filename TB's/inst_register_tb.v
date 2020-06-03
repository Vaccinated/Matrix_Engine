module inst_register_tb();
reg enable, clock;
reg [3:0] address;
wire [31:0] dataout;

inst_register yupp(dataout, enable, clock, address);

initial begin
#0 clock = 0; enable = 0;
end

always begin
#1 clock = ~clock; enable = ~enable;
end

initial begin
$monitor("clk=%b, enable=%b, address=%b, dataout=%b",clock,enable,address,dataout);
#1 address=0000;
#2 address=0001;
#2 address=0010;
#2 address=0011;
#2 address=0100;
#2 address=0101;
#2 address=0110;
#2 address=0111;
#2 address=1000;
#2 address=1001;
#2 address=1010;
#2 address=1011;
#2 address=1100;
#2 address=1101;
#2 address=1110;
#2 address=1111;
$finish;
end
endmodule