class AES_driver extends uvm_driver #(AES_sequence_item);
`uvm_component_utils(AES_driver)
AES_sequence_item item_drv ;

virtual AES_interface vif_drv ;

function new (string name ="AES_driver",uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Driver = [%0t]",$time);
    item_drv = AES_sequence_item::type_id::create("item_drv") ;
    if(!uvm_config_db#(virtual AES_interface)::get(this,"","set_vif",vif_drv))
    begin
        `uvm_error(get_full_name(),"Error in receiving RES from agt [drv]!")
    end
    
endfunction

function void connect_phase (uvm_phase phase) ;
    super.connect_phase(phase);
    $display("connect Driver = [%0t]",$time);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever
    begin
        $display("run Driver = [%0t]",$time) ;
        `uvm_info ("DRIVER", $sformatf ("Waiting for data from sequencer"), UVM_MEDIUM)
        seq_item_port.get_next_item(item_drv);
        @(posedge vif_drv.cb_dr);
        vif_drv.cb_dr.reset <= item_drv.reset ;
        vif_drv.cb_dr.valid_in <= item_drv.valid_in ;
        vif_drv.cb_dr.plan_text_128 <= item_drv.plan_text_128;
        vif_drv.cb_dr.cipher_key_128 <= item_drv.cipher_key_128;
        $display("--------------------------Drv---------------------------------");
        $display("[%0t] Drv: \nrst = %0b \nValid in = %0b \nplan text = %0h \ncipher key = %0h \n",$time
        ,item_drv.reset,item_drv.valid_in,item_drv.plan_text_128,item_drv.cipher_key_128); 
        seq_item_port.item_done();
    end
endtask
endclass