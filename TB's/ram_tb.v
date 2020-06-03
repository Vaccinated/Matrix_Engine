module ram_tb();
reg enable, readwrite, clk;
reg [255:0] in;
reg [3:0] address;
wire [255:0] out;

ram yupp(out, in, address, enable, readwrite, clk);

initial begin
#0 clk = 1'b1; enable = 1'b0;
end

initial 
forever
begin
#1 clk = ~clk;
end

initial begin
$monitor("clk=%b enable=%b readwrite=%b address=%b in=%h out=%h",clk,enable,readwrite,address,in,out);
#1 enable = 1; readwrite = 0; address = 0000; in = 255'b0;
#2 enable = 1; readwrite = 0; address = 0001; in = 255'b1;
#2 enable = 1; readwrite = 0; address = 0010; in = 255'b10;
#2 enable = 1; readwrite = 0; address = 0011; in = 255'b11;
#2 enable = 1; readwrite = 0; address = 0100; in = 255'b100;
#2 enable = 1; readwrite = 1; address = 0000; in = 255'b1;
#2 enable = 0; readwrite = 1; address = 0001; in = 255'b0;
#2 enable = 1; readwrite = 1; address = 0010; in = 255'b0;
#2 enable = 1; readwrite = 1; address = 0011; in = 255'b0;
#2 enable = 1; readwrite = 1; address = 0100; in = 255'b0;
$finish;
end
endmodule