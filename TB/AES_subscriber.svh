class AES_subscriber extends uvm_subscriber #(AES_sequence_item);
`uvm_component_utils(AES_subscriber)
AES_sequence_item item ;

covergroup cg_ase ();

// Cover reset behavior
cp_rs: coverpoint item.reset {
    bins deasserted = {1};
    bins asserted = {0};
}

// Cover valid_in transitions
cp_vi: coverpoint item.valid_in {
    bins low = {0};
    bins high = {1};
}

cp_text: coverpoint item.plan_text_128 {
    bins all_zero   = {128'h0};
    bins all_one    = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
    bins alt_pattern1 = {128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA};
    bins alt_pattern2 = {128'h55555555555555555555555555555555};
    bins alt_pattern3 = {128'h000102030405060708090a0b0c0d0e0f};
    bins random_val[] = default; // bucket everything else
}

// Key categories
cp_key: coverpoint item.cipher_key_128 {
    bins all_zero   = {128'h0};
    bins all_one    = {128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF};
    bins alt_pattern1 = {128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA};
    bins alt_pattern2 = {128'h55555555555555555555555555555555};
    bins alt_pattern3 = {128'h000102030405060708090a0b0c0d0e0f};
    bins random_val[] = default; // bucket everything else
}

cp_cross: cross cp_vi,cp_key {
    bins bin_o = binsof(cp_vi.high);
    option.cross_auto_bin_max = 0 ;
}

endgroup

function new (string name = "AES_subscriber", uvm_component parent = null);
    super.new(name,parent);
    cg_ase = new();
endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    $display("build Subscriber = [%0t]",$time);
    item = AES_sequence_item::type_id::create("item");
endfunction

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
endfunction

function void write(AES_sequence_item t);
    item = t ;
    cg_ase.sample();
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
endtask

function void report_phase (uvm_phase phase);
    $display("Report Subscriber = [%0t]",$time);
    `uvm_info("AES_sequence_item", $sformatf("coverage =%0d", cg_ase.get_coverage()), UVM_NONE);
endfunction

endclass