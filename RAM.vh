//RAM 
//            ________________ 
//           |                | 
//           |                | 
//           |                | 
//           |      RAM       | 
//           |                | 
//           |                | 
//           |________________| 
// 12 bits de direccionamiento 

module RAM (
address     , // Address Input
data        , // Data bi-directional
cs          , // Chip Select
we            // Write Enable/Read Enable
);          
// con esto se puede facilitar si se quiere cambiar las dimensiones del RAM
parameter DATA_WIDTH = 4 ;
parameter ADDR_WIDTH = 12 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input [ADDR_WIDTH-1:0] address ;
input                                     cs;
input                                     we;

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

//-------------- CODE ------------------ 

// buffer tri estado despues de leer (se utiliza para regresar la informacion despues de algun cambio)
// output : When we = 0, cs = 1
assign data = (cs && !we) ? data_out : 8'bz; // alta impedancia si no esta en chip selececcionado y en lectura

// Guardar datos en la RAM 
// Write Operation : When we = 1, cs = 1
always @ (address or data or cs or we)
begin : MEM_WRITE
   if ( cs && we ) begin //si chip esta selecionado y esta modo de escribir
       mem[address] = data;
   end
end

// Lectura
// Read Operation : When we = 0, cs = 1 //cuando esta modo de lectura y chip seleccionado
always @ (address or cs or we)
begin : MEM_READ 
    if (cs && !we)  begin
         data_out = mem[address];
    end
end

endmodule
