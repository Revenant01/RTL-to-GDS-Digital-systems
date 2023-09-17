module RegFile (

    input wire clk,
    input wire rst,
    input wire [15:0] WrData,
    input wire [2:0] address,
    input wire WrEn,
    RdEn,
    output reg [15:0] RdData

);

  // 2D Array
  reg [15:0] Reg_File[7:0];  //  reg [15:0] memory [7:0]; 


  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      Reg_File[0] <= 16'b0;
      Reg_File[1] <= 16'b0;
      Reg_File[2] <= 16'b0;
      Reg_File[3] <= 16'b0;
      Reg_File[4] <= 16'b0;
      Reg_File[5] <= 16'b0;
      Reg_File[6] <= 16'b0;
      Reg_File[7] <= 16'b0;

    end else begin
      if (RdEn && !WrEn) begin
        RdData <= Reg_File[address];
      end else if (WrEn && !RdEn) begin
        Reg_File[address] <= WrData;
      end
    end
  end

endmodule
