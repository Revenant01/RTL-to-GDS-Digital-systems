module clkDiv #(
    parameter ratio_width = 8
)(
    input  wire                     i_clk,
    input  wire                     i_rst, 
    input  wire                     i_clk_en,
    input  wire [ratio_width-1:0]   i_div_ratio,
    output reg                      o_div_clk
);

  reg [ratio_width-1 : 0] counter;

  always @ (posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
        counter    <= 'b0;
        o_div_clk  <= 'b0;
    end else begin
        if (clk_en) begin 

            if ( &(counter[ratio_width-2:0]) )   o_div_clk <= 'b1;
 
            else if (&counter)   o_div_clk <= 'b0;

            else  counter <= counter +'b1;
       
        end 
    end 
  end

endmodule