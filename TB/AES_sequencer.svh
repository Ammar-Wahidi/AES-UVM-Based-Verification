class AES_sequencer extends uvm_sequencer#(AES_sequence_item) ;
`uvm_component_utils(AES_sequencer)
AES_sequence_item item_sequencer ;

function new (string name = "AES_sequencer", uvm_component parent = null) ;
super.new(name,parent);
endfunction 

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Sequencer = [%0t]",$time);
    item_sequencer = AES_sequence_item::type_id::create("item_sequencer") ;
endfunction

function void connect_phase (uvm_phase phase) ;
    super.connect_phase(phase);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
endtask 

endclass