module AES(plan_text_128, cipher_key_128, cipher_text_128,valid_in, clk, reset,valid_out);


//--------------------------------------
// --------------------inputs-----------
//--------------------------------------
input logic[127:0] plan_text_128;
input logic[127:0] cipher_key_128;
input valid_in;
input reset;
input clk;

logic[127:0] plan_text_128_reg;
logic[127:0] cipher_key_128_reg;

wire[127:0] plan_text_128_wire;
wire[127:0] cipher_key_128_wire;


always @(posedge clk or negedge reset) begin
  if(!reset)
    begin
      plan_text_128_reg  <= 128'b0;
      cipher_key_128_reg <= 128'b0;
    end
  else
    begin
      plan_text_128_reg  <= plan_text_128;
      cipher_key_128_reg <= cipher_key_128;
    end
end

assign plan_text_128_wire = plan_text_128_reg;
assign cipher_key_128_wire = cipher_key_128_reg;

//---------------------------------
//------------output---------------
//---------------------------------
output logic[127:0] cipher_text_128;
output logic        valid_out      ;
logic               valid_out_r    ;

//-------------------------------

logic [127:0] encrypted_128,decrypted_128;

reg [127:0] encrypted_128_reg,decrypted_128_reg;

wire [127:0] encrypted_128_wire,decrypted_128_wire;

always @(posedge clk or negedge reset) begin
  if(!reset)
    begin
      decrypted_128_reg <= 128'b0;
      encrypted_128_reg <= 128'b0;
      valid_out_r <= 0;
      valid_out <= 0 ;
    end
  else
    begin
      encrypted_128_reg <= encrypted_128;
      decrypted_128_reg <= decrypted_128;
      valid_out_r <= valid_in;
      valid_out <= valid_out_r ;
    end
end

assign encrypted_128_wire = encrypted_128_reg;

assign decrypted_128_wire = decrypted_128_reg;

AES_Encrypt a(plan_text_128_wire,cipher_key_128_wire,encrypted_128);

AES_Decrypt a2(encrypted_128_wire,cipher_key_128_wire,decrypted_128);


assign cipher_text_128= (valid_in) ? encrypted_128_wire : decrypted_128_wire;


endmodule