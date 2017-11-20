`include "../busDriver.vh"

module testbusDriver();
    logic [3:0] A;
    logic enable;
    wire [3:0] Y;

    initial begin
      A = 4'b0101;
      enable = 0;
    end

    busDriver bD(.A(A), .enable(enable), .Y(Y));

    initial begin
      $display("Testing Bus Driver");
      $display("A\tenable\tY");
      $monitor("%b\t%b\t%b", A, enable, Y);
      #1 enable = 1;
      #1 A = 4'b1100;
      #1 enable = 0;
    end

endmodule