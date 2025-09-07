class AES_agent extends uvm_agent;
`uvm_component_utils(AES_agent)
AES_sequencer aes_sequencer ;
AES_driver aes_driver ;
AES_monitor aes_monitor ;

uvm_analysis_port #(AES_sequence_item) AP_agt ;

virtual AES_interface vif_agt ;

function new(string name = "AES_agent", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Agent = [%0t]",$time);
    aes_sequencer = AES_sequencer::type_id::create("aes_sequencer",this);
    aes_driver = AES_driver::type_id::create("aes_driver",this);
    aes_monitor = AES_monitor::type_id::create("aes_monitor",this);

    if(!uvm_config_db#(virtual AES_interface)::get(this,"","vif_agt",vif_agt))
        `uvm_error(get_full_name(),"Error in receiving RES from env [agt]!")
    uvm_config_db#(virtual AES_interface)::set(this,"aes_driver","set_vif",vif_agt);
    uvm_config_db#(virtual AES_interface)::set(this,"aes_monitor","set_vif",vif_agt);
    AP_agt = new("AP_agt",this) ;
endfunction

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase) ;
    $display("connect Agent = [%0t]",$time);
    aes_monitor.AP_mon.connect(AP_agt);
    aes_driver.seq_item_port.connect(aes_sequencer.seq_item_export);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase) ;
    $display("run Agent = [%0t]",$time);
endtask
endclass 