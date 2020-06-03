module register_tb();
reg enable, readwrite, clk;
reg [255:0] in;
wire [255:0] out;

register yupp(out, in, enable, readwrite, clk);

initial begin
#0 clk = 1'b0; enable = 1'b0;
end

initial 
forever
begin
#1 clk = ~clk; enable = ~enable;
end

initial begin
$monitor("clk=%b enable=%b readwrite=%b in=%h out=%h",clk,enable,readwrite,in,out);
#1 readwrite = 0; in = 255'b1111;
#2 readwrite = 1; in = 255'b0;
#2 readwrite = 0; in = 255'b0;
$stop;
end
endmodule