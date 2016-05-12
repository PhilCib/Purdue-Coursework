module decode
  (
    input wire clk,
    input wire n_rst,
    input wire scl,
    input wire sda_in,
    input wire [7:0] starting_byte,
    output reg rw_mode,
    output reg address_match,
    output wire stop_found,
    output wire start_found
    );
    reg nxt_state, cur_state, cur_state2, nxt_state2, a, b, c, d;
    always_ff @(posedge clk, negedge n_rst) begin
      if (n_rst == 1'b0) begin
        nxt_state <= 1'b1;
        //cur_state <= 1'b1;
        nxt_state2 <= 1'b1;
        //cur_state2 <= 1'b1;
        //a <= 1'b1;
        b <= 1'b1;
        //c <= 1'b1;
        d <= 1'b1;
      end
      else begin
        nxt_state <= cur_state;
        nxt_state2 <= cur_state2;
        b <= a;
        d <= c;
      end
    end
    
    always_comb
    begin
        cur_state = sda_in;
        cur_state2 = nxt_state;
        a = scl;
        c = b;
    end
    
    assign start_found = (nxt_state2 & !nxt_state) & b & d;
    assign stop_found = (nxt_state & !nxt_state2) & b & d;
    always_comb begin//combinational block for comparing the address
      if (starting_byte[7:1] == 7'b1111000) begin
         address_match = 1'b1;
      end
      else begin
         address_match = 1'b0;
      end
       rw_mode = starting_byte[0];
    end
  endmodule
  
      
      
    