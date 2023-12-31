%lang starknet

from starkware.cairo.common.registers import get_fp_and_pc

@view
func use_pointer(number : felt) -> (res : felt):
    # The variable 'tuple' is assigned to the the pointer
    # to the tuple returned by the function.
    # The variable is of type 'felt*'.
    let (tuple) = tuple_maker(number)
    # The variable 'val' is set to the value of the third element.
    let val = tuple[2]
    return (val)
end

# The function returns a pointer to a tuple.
func tuple_maker(val : felt) -> (a_tuple : felt*):
    alloc_locals
    # Declare a tuple.
    local tuple : (felt, felt, felt) = (5, 6, 2*val)
    # Local variables are based on the frame pointer, which
    # can be accessed with this library module.
    let (__fp__, _) = get_fp_and_pc()
    # '&' denotes the address, in this case, the address of the tuple.
    return (&tuple)
end
