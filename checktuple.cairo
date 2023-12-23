%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.registers import get_fp_and_pc

@view
func read_tuple() -> (value : felt):
    alloc_locals
    # A tuple is defined.
    local felt_tuple : (felt, felt, felt, felt) = (9, 8, 7, 18)

    # Access the tuple at the selected index.
    # Cannot pass a variable index (e.g as function input).
    let val = felt_tuple[3]
    return (val)
end

@external
func pass_tuple(index_1 : felt, index_2 : felt) -> (sum : felt):
    # A tuple is passed by sending the address of the tuple.
    alloc_locals

    # A tuple is defined.
    local the_tuple : (felt, felt, felt, felt) = (4, 6, 8, 13)

    # Get the value of the fp register.
    let (__fp__, _) = get_fp_and_pc()
    let (total) = get_sum(&the_tuple, index_1, index_2)
    return (total)
end

func get_sum(tuple_pointer : felt*, idx_1 : felt, idx_2 : felt) -> (
    total : felt):

    let sum = tuple_pointer[idx_1] + tuple_pointer[idx_2]
    return (sum)
end
