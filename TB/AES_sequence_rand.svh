class AES_sequence_rand extends uvm_sequence;
`uvm_object_utils(AES_sequence_rand)
AES_sequence_item item ;

function new (string name = "AES_sequence_rand") ;
super.new(name) ;
endfunction

task pre_body();
    item = AES_sequence_item::type_id::create("item");
endtask 

task body();
    start_item(item);
        item.reset = 0 ;
        item.valid_in = 1 ;
        item.plan_text_128 = 0;
        item.cipher_key_128 = 8 ;
    finish_item(item);
    start_item(item);
        item.constr1.constraint_mode(1);
        item.constr2.constraint_mode(0);
        assert (item.randomize())
        else `uvm_error("SEQ", $sformatf("[Sequence] Randomize went wrong"))
        $display("--------------------------seq_rand---------------------------------");
        item.print();
    finish_item(item);
    repeat(200)
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