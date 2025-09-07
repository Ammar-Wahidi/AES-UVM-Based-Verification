import uvm_pkg ::* ;
`include "uvm_macros.svh"
import AES_pack_UVM ::* ;
module AES_top ();
bit clk ;

AES_interface aes_intf(clk) ;

AES AES_128_regs(
.clk(aes_intf.clk),
.reset(aes_intf.reset),
.valid_in(aes_intf.valid_in),
.plan_text_128(aes_intf.plan_text_128),
.cipher_key_128(aes_intf.cipher_key_128),
.cipher_text_128(aes_intf.cipher_text_128),
.valid_out(aes_intf.valid_out)
);

initial clk = 0;
always #10 clk = ~clk ;

initial 
begin
    uvm_config_db#(virtual AES_interface)::set(null,"uvm_test_top","vif_test",aes_intf);
    run_test("AES_test");
end
endmodule