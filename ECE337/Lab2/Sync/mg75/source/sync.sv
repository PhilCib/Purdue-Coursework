// 337 TA Provided Lab 2 8-bit adder wrapper file template
// This code serves as a template for the 8-bit adder design wrapper file 
// STUDENT: Replace this message and the above header section with an
// appropriate header based on your other code files

module sync
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);

reg d;
always_ff @ (posedge clk, negedge n_rst)
begin
  if(1'b0 == n_rst)
    begin
      sync_out <= 1'b0;
      d <= 1'b0;
    end
  else
    begin
      d <= async_in;
      sync_out <= d;
    end
  end 
endmodule