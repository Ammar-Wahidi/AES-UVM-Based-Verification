class AES_monitor extends uvm_monitor ;
`uvm_component_utils(AES_monitor)
AES_sequence_item item_mon ;

uvm_analysis_port #(AES_sequence_item) AP_mon ;

virtual AES_interface vif_mon ;

function new (string name = "AES_monitor", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Monitor = [%0t]",$time);
    item_mon = AES_sequence_item::type_id::create("item_mon");
    if(!uvm_config_db#(virtual AES_interface)::get(this,"","set_vif",vif_mon))
    begin
        `uvm_error(get_full_name(),"Error in receiving RES from agt [mon]!")
    end
    AP_mon = new("AP_mon",this);
endfunction 

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    $display("connect Monitor = [%0t]",$time);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever 
    begin
        $display("run Monitor = [%0t]",$time);
        @(posedge vif_mon.cb_mon);
        item_mon.reset <= vif_mon.cb_mon.reset ;
        item_mon.valid_in <= vif_mon.cb_mon.valid_in ;
        item_mon.plan_text_128 <= vif_mon.cb_mon.plan_text_128;
        item_mon.cipher_key_128 <= vif_mon.cb_mon.cipher_key_128;
        item_mon.cipher_text_128 <= vif_mon.cb_mon.cipher_text_128 ;
        item_mon.valid_out <= vif_mon.cb_mon.valid_out ;
        #2;
        $display("--------------------------Mon---------------------------------");
        $display("[%0t] mon: \nrst = %0b \nValid in = %0b \nplan text = %0h \cipher key = %0h \ncipher text = %0h \nValid out = %0h",$time
        ,item_mon.reset,item_mon.valid_in,item_mon.plan_text_128,item_mon.cipher_key_128,item_mon.cipher_text_128,item_mon.valid_out); 
        #1step AP_mon.write(item_mon);
           
    end
endtask

endclass