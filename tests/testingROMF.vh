`include "../ROM.vh"
`include "../Fetch.vh"

module ROMFETCH();
logic [11:0] address; 
logic clk, reset, phase;
wire [7:0] program_byte; 
wire [3:0] instr, operand;

rom progRom(.address(address), .data(program_byte));  
Fetch fetch_FF(.clk(clk), .reset(reset), .D(program_byte), .Q({instr, operand}), .enable(phase)); 

initial
    #100 $finish;
initial begin
    reset = 0;
    clk = 0;
    address = 0;
    phase = 0;
end
initial begin
    $display("cl rst ph address\tprogam_byte\tinstr operand");
    $monitor("%b  %b   %b  %b\t%b\t%b %b", clk, reset, phase, address, program_byte, instr, operand);        
    #10 reset = 1;
    #10 reset = 0;
    #5 phase = 1;
    #5 address = 'h001;
    #5 address = 'h002;
    #5 address = 'h003;
    #5 address = 'h004;
    #5 address = 'h005;
    #5 address = 'h006;
    
end
always 
    #5 clk = ~clk;
endmodule