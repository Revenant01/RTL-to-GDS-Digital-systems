module clkgate(
    input wire i_ref_clk;
    input wire i_clk_en;
    output reg o_gated_clk;
);

reg latch_out;

always @ (i_ref_clk or i_clk_en) begin
    if (!i_ref_clk) begin
        latch_out <= i_clk_en;
    end
end

assign o_gated_clk = i_ref_clk && latch_out;

/*



TLATNCAX12M U0_TLATNCAX12M (
.CK(i_ref_clk),
.E(i_clk_en),
.ECK(o_gated_clk)
);

*/


endmodule