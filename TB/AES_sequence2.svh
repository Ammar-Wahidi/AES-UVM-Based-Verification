class AES_sequence2 extends uvm_sequence;
`uvm_object_utils(AES_sequence2)
AES_sequence_item item ;

function new (string name = "AES_sequence2") ;
super.new(name) ;
endfunction

task pre_body();
    item = AES_sequence_item::type_id::create("item");
    item.constr1.constraint_mode(0);
endtask 

task body();
    start_item(item);
    item.reset = 1 ;
    item.valid_in = 0 ;
    item.plan_text_128 = 128'h_00112233445566778899aabbccddeeff;
    item.cipher_key_128 = 128'h_000102030405060708090a0b0c0d0e0f;
    $display("--------------------------seq_rand---------------------------------");
    item.print();
    // expected128 = 128'h_69c4e0d86a7b0430d8cdb78070b4c55a;
    finish_item(item);
    start_item(item);
    item.reset = 1 ;
    item.valid_in = 1 ;
    item.plan_text_128 = 0;
    item.cipher_key_128 = 0 ;
    $display("--------------------------seq_rand---------------------------------");
    item.print();
    finish_item(item);
    start_item(item);
    item.reset = 1 ;
    item.valid_in = 1 ;
    item.plan_text_128 = 8;
    item.cipher_key_128 = 8 ;
    $display("--------------------------seq_rand---------------------------------");
    item.print();
    finish_item(item);
endtask

endclass