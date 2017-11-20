`include "../In.vh"

module testIn();
    logic [3:0] A;
    wire [3:0] Y;

initial begin
    A = 4'b0000;
end

In i(.A(A), .Y(Y));
initial begin
  $display("Testing In coso");
  $display("A\tY");
  $monitor("%b\t%b",A , Y);
  #1 A = 4'b0001;
  #1 A = 4'b0101;
  #1 A = 4'b1101;
  #1 A = 4'b0000;
end
endmodule // 