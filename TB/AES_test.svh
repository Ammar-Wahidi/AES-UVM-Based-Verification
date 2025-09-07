class AES_test extends uvm_test ;
`uvm_component_utils(AES_test)
AES_sequence aes_sequence ;
AES_sequence_rand aes_seq_rand ;
AES_sequence_keys aes_seq_keys ;
AES_env aes_env ;

virtual AES_interface vif_test ;

function new (string name = "AES_test", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Test = [%0t]",$time);
    aes_sequence = AES_sequence::type_id::create("aes_sequence",this);
    aes_seq_rand = AES_sequence_rand::type_id::create("aes_seq_rand",this);
    aes_seq_keys = AES_sequence_keys::type_id::create("aes_seq_keys",this);
    aes_env = AES_env::type_id::create("aes_env",this);
    if (!uvm_config_db#(virtual AES_interface)::get(this,"","vif_test",vif_test))
        `uvm_error(get_full_name(),"Error in receving Res from top [test]!")
    uvm_config_db#(virtual AES_interface)::set(this,"aes_env","vif_env",vif_test);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    $display("connect Test = [%0t]",$time);  
endfunction

task run_phase (uvm_phase phase);
    super.connect_phase(phase);
    $display("run Test = [%0t]",$time);
    phase.raise_objection(this);
    aes_sequence.start(aes_env.aes_agent.aes_sequencer);
    #90;
    phase.drop_objection(this);
    phase.raise_objection(this);
    aes_seq_rand.start(aes_env.aes_agent.aes_sequencer);
    phase.drop_objection(this);
    phase.raise_objection(this);
    aes_seq_keys.start(aes_env.aes_agent.aes_sequencer);
    phase.drop_objection(this);

endtask

endclass