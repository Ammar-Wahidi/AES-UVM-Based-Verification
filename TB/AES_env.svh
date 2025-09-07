class AES_env extends uvm_env ;
`uvm_component_utils(AES_env)
AES_agent aes_agent ;
AES_scoreboard aes_scoreboard ;
AES_subscriber aes_subscriber ;

virtual AES_interface vif_env;

function new(string name = "AES_env", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    $display("build ENV = [%0t]",$time);
    aes_agent = AES_agent::type_id::create("aes_agent",this);
    aes_scoreboard = AES_scoreboard::type_id::create("aes_scoreboard",this);
    aes_subscriber = AES_subscriber::type_id::create("aes_subscriber",this);
    if(!uvm_config_db#(virtual AES_interface)::get(this,"","vif_env",vif_env))
        `uvm_error(get_full_name(),"Error in receving Res from top [env]!")
    uvm_config_db#(virtual AES_interface)::set(this,"aes_agent","vif_agt",vif_env);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    aes_agent.AP_agt.connect(aes_scoreboard.AI_score);
    aes_agent.AP_agt.connect(aes_subscriber.analysis_export);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
endtask

endclass