module CMP_UNIT #(
    parameter A_width = 16,
    parameter B_width = 16,
    parameter CMP_OUT_width = 16
) (
    input wire [A_width- 1:0] A_IN_CMP,
    input wire [B_width- 1:0] B_IN_CMP,
    input wire CLK_CMP,
    input wire RST_CMP,
    input wire [1:0] ALU_FUN_CPM,
    input wire CMP_EN,
    output reg CMP_Flag,
    output reg [CMP_OUT_width- 1:0] CMP_OUT
);

  localparam NOP = 2'b00;
  localparam equal = 2'b01;
  localparam Greater = 2'b10;
  localparam Less = 2'b11;

  always @(posedge CLK_CMP or negedge RST_CMP) begin
    if (!RST_CMP) begin
      CMP_OUT  <= 0;
      CMP_Flag <= 0;
    end else begin
      if (CMP_EN) begin
        CMP_Flag <= 1;
        case (ALU_FUN_CPM)
          NOP: CMP_OUT <= 0;
          equal: begin
            if (A_IN_CMP == B_IN_CMP) CMP_OUT <= 1;
            else CMP_OUT <= 0;
          end

          Greater: begin
            if (A_IN_CMP > B_IN_CMP) CMP_OUT <= 2;
            else CMP_OUT <= 0;
          end

          Less: begin
            if (A_IN_CMP < B_IN_CMP) CMP_OUT <= 2;
            else CMP_OUT <= 3;
          end

        endcase

      end else begin
        CMP_OUT <= 0;
        CMP_Flag <= 0;
      end


    end
  end

endmodule

