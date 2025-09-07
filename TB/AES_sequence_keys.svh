class AES_sequence_keys extends uvm_sequence;
`uvm_object_utils(AES_sequence_keys)
AES_sequence_item item ;

function new (string name = "AES_sequence_keys") ;
super.new(name) ;
endfunction

task pre_body();
    item = AES_sequence_item::type_id::create("item");
    item.constr1.constraint_mode(1);
    item.constr2.constraint_mode(1);
endtask 

task body();
    start_item(item);
        item.reset = 0 ;
        item.valid_in = 1 ;
        item.plan_text_128 = 0;
        item.cipher_key_128 = 8 ;
    finish_item(item);
    start_item(item);
        item.cipher_key_128.rand_mode(0);
        item.cipher_key_128 = 128'h000102030405060708090a0b0c0d0e0f;
        assert (item.randomize())
        else `uvm_error("SEQ", $sformatf("[Sequence] Randomize went wrong"))
        $display("--------------------------seq_rand---------------------------------");
        item.print();
    finish_item(item);
    start_item(item);
        item.cipher_key_128.rand_mode(1);
        assert (item.randomize())
        else `uvm_error("SEQ", $sformatf("[Sequence] Randomize went wrong"))
        $display("--------------------------seq_rand---------------------------------");
        item.print();
    finish_item(item);
    repeat(400)
    begin
        start_item(item);
            assert (item.randomize())
            else `uvm_error("SEQ", $sformatf("[Sequence] Randomize went wrong"))
            $display("--------------------------seq_rand---------------------------------");
            item.print();
        finish_item(item);
    end
    start_item(item);
        item.reset = 1 ;
        item.valid_in = 1 ;
        item.plan_text_128 = 8;
        item.cipher_key_128 = 8 ;
    finish_item(item);
endtask

endclass