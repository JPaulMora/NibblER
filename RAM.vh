//RAM 
//            ________________ 
//           |                | 
//           |                | 
//           |                | 
//           |      RAM       | 
//           |                | 
//           |                | 
//           |________________| 
// 12 bits de direccionamiento - operand + programbytes

module RAM (
address     , // Address Input
data        , // Data (salida o lectura del buffer tri estado)
cs          , // chip seleccionado, en este caso solo hay 1
we            // WriteEnable (estan gruardando en la memoria?)
);          
// con esto se puede facilitar si se quiere cambiar las dimensiones del RAM
parameter DATA_WIDTH = 4 ;
parameter ADDR_WIDTH = 12 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input [ADDR_WIDTH-1:0] address ; //en este caso [11:0]
input                                     cs;
input                                     we;

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

//-------------- CODE ------------------ 

// buffer tri estado alta impedancia
assign data = (cs) ? data_out : 8'bz; // alta impedancia si no esta en chip selececcionado y en lectura

// Guardar datos en la RAM seleccionada
always @ (address or data or cs or we) //lee por cada cambio en alguno de los puertos
begin
   if ( cs && we ) begin //si chip esta selecionado y esta modo de escribir
       mem[address] = data;
   end
end

// Lectura de la ram seleccionada
always @ (address or cs or we)
begin 
    if (cs && !we)  begin
         data_out = mem[address]; 
    end
end

endmodule
