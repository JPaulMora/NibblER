
//Add Operand module for ALU
module addop(A, B, carry, out);
  input [3:0] A, B, out;
  output carry;

  assign {carry, out} = A + B;
endmodule

//Mult Operand module for ALU
module multop(A, B, carry, out);
    input [3:0] A, B, out;
    output carry;

  assign {carry, out} = A * B;
endmodule

//ST
module ST(A,B,out);
  
endmodule
//LIT - IN - LD
module nor(A,B,out);

endmodule
//NOR
module nor(A,B,out);

endmodule

