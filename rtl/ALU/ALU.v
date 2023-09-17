`inclue "ALU_cases.vh"
module ALU #(
    parameter OPER_WIDTH = 8,
    OUT_WIDTH = OPER_WIDTH * 2
) (
    input  wire [OPER_WIDTH-1:0]  i_a,
    input  wire [OPER_WIDTH-1:0]  i_b,
    input  wire                   i_en,
    input  wire [           3:0]  i_fun,
    input  wire                   i_clk,
    input  wire                   i_rst,
    output reg  [ OUT_WIDTH-1:0]  o_alu_out,
    output reg                    o_out_valid
);


reg [OUT_WIDTH-1:0] alu_out;
reg out_valid


always @ (posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
        o_alu_out <= 'b0;
        o_out_valid <= 'b0;
    end else begin
        o_alu_out <= alu_out;
        o_out_valid <= out_valid;
    end
end


always @(*) begin
    alu_out = 'b0;
    out_valid = 'b0;

    if (i_en) begin
        case (ALU_FUN) 
     `ADD   : begin
               alu_out = i_a+i_b;
              end
     `SUB   : begin
               alu_out = i_a - i_b;
              end
     `MUL   : begin
               alu_out = i_a*i_b;
              end
     `DIV   : begin
               alu_out = i_a/i_b;
              end
     `AND   : begin
               alu_out = i_a & i_b;
              end
     `OR    : begin
               alu_out = i_a | i_b;
              end
     `NAND  : begin
               alu_out = ~ (i_a & i_b);
              end
     `NOR   : begin
               alu_out = ~ (i_a | i_b);
              end     
     `XOR   : begin
               alu_out =  (i_a ^ i_b);
              end
     `XNOR  : begin
               alu_out = ~ (i_a ^ i_b);
              end           
     `EQL   : begin
              if (i_a == i_b) alu_out = 'b1;
              else alu_out = 'b0;
              end
     `GRT   : begin
               if (i_a > i_b) alu_out = 'b10;
               else alu_out = 'b0;
              end 
     `LESS  : begin
               if (i_a < i_b) alu_out = 'b11;
               else alu_out = 'b0;
              end     
     `SHR   : begin
               alu_out = i_a>>1;
              end
     `SHL   : begin 
               alu_out = i_a<<1;
              end
    default: begin
               alu_out = 'b0;
             end
    endcase

    end else begin
        alu_out = 'b0;
    end
end

endmodule
