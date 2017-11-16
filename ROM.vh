
module ROM(
  input logic [11:0] address,	// Dirección a la que quiero apuntar
  output logic [7:0] data);		// Contenido de la dirección a la que estoy apuntando
  
  logic [11:0] memory [0:25];
  
  initial
    $readmemh("ROMDATA.list", memory);
  
  assign data = memory[address];
endmodule