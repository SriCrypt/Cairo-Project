%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.storage import Storage
from starkware.cairo.common.alloc import alloc

struct dataStruct:
    member a : felt
    member b : felt
end

# Only felt arguments
@storage_var
func storage() -> (res : felt):
end

# Only felt arguments
@external
func write{storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(val : felt):
    helper_1(val)
    # Write functions are a transaction and should not return values.
    return ()
end

# Only felt arguments
@view
func read{storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (val_1 : felt, val_2 : felt,
        val_3 : felt):
    # Brackets around val_1 to receive the value from the helper_2() function.
    let (val_2) = helper_2()
    let (stored_val) = storage.read()
    # Arguments may be passed with their names.
    # If names are not used, they must precede all named arguments (E.g. '9').
    return (9, val_2=val_2, val_3=stored_val)
end

# Other arguments including felt allowed.
func helper_1{storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(val : felt):
    # Implicit arguments in curly brackets when required, such as for
    # storage-related pointers.
    storage.write(val)
    # This function does not return a value.
    return ()
end

# Return values are designated by an arrow '->'
func helper_2() -> (val : felt):
    # This function accepts 0 arguments and returns 1. No implicit arguments needed.
    # 'data' variable is assigned to a struct.
    let data = dataStruct(a=6, b=7)
    # The struct is passed as an argument.
    let (processed_data) = helper_3(data)
    # The use of the name of a return variable E.g., 'val')
    # is optional and here is omitted.
    return (processed_data)
end

func helper_3(a_b_data : dataStruct) -> (processed_data : felt):
    # This function accepts a pointer (to a dataStruct instance),
    # as seen by the '*' asterisk.
    # No implicit arguments needed.
    # A 'tempvar' variable is required for this compound expression.
    tempvar a_b_product = a_b_data.a * a_b_data.b
    return (processed_data=a_b_product)
end


