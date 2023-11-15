//mealy,pattern :- BBCBC,one_hot encoding
module mealy(clk,rst,d_i,valid_i,pattern);

parameter S_RESET = 5'b00001;
parameter S_B = 5'b00010;
parameter S_BB = 5'b00100;
parameter S_BBC = 5'b01000;
parameter S_BBCB = 5'b10000;
parameter B = 1'b1;
parameter C = 1'b0;

input clk,rst,d_i,valid_i;
output reg pattern;
reg [4:0]state,next_state;

 always@(posedge clk)begin
  if(rst==1)begin
  pattern = 0;
  state = S_RESET;
  next_state = S_RESET;
  end
  else begin
    pattern = 0;
	if(valid_i==1)begin
	case(state)
	   S_RESET:begin
	   if(d_i==B)next_state=S_B;
	   else next_state=S_RESET;
	   end
	   S_B:begin
	   if(d_i==B)next_state=S_BB;
	   else next_state=S_RESET;
	   end
	   S_BB:begin
	   if(d_i==B)next_state=S_BB;
	   else next_state=S_BBC;
	   end
	   S_BBC:begin
	   if(d_i==B)next_state=S_BBCB;
	   else next_state=S_RESET;
	   end
	   S_BBCB:begin
	   if(d_i==B)begin
	   next_state=S_BB;
	   end
	   else begin
	   next_state=S_RESET;
	   pattern = 1;
	   end
	   end
	  default:begin
	   $display("Error condition");
	   next_state = S_RESET;
	   end
	   endcase
	   end
	   end
	   end
 	always@(next_state)state=next_state;

  endmodule