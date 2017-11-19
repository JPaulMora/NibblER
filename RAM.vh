//RAM
//            ________________
//           |                |
//           |                |
//           |                |
//           |      RAM       |
//           |                |
//           |                |
//           |________________|
// LD, ST, CMPM, ADDM,
// NORM
// 12 bits de direccionamiento
module RAM(
clk         , // Clock Input
address     , // Address Input
data        , // Data bi-directional
csRAM       , // Chip Select
weRAM           // Write Enable/Read Enable
);
parameter DATA_WIDTH = 4 ;
parameter ADDR_WIDTH = 12 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input                  clk         ;
input [ADDR_WIDTH-1:0] address     ;
input                  csRAM          ;
input                  weRAM         ;

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data       ;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] mem [0:4055]; //la memoria entera 12^12
reg                  oe_r;
//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When weRAM = 0, csRAM = 1
assign data = (csRAM && !weRAM) ? data_out : 8'bz; 

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (posedge clk)
begin : MEM_WRITE
   if ( csRAM && weRAM ) begin
       mem[address] = data;
   end
end

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
always @ (posedge clk)
begin : MEM_READ
  if (csRAM && !weRAM) begin
    data_out = mem[address];
    oe_r = 1;
  end else begin
    oe_r = 0;
  end
end


endmodule 