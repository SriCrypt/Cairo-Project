%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.storage import Storage

@storage_var
func criterion() -> (val : felt):
end

@storage_var
func met_criteria_memory() -> (val : felt):
end

@view
func match_count{
        storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (count : felt):
    let (num) = met_criteria_memory.read()
    return (num)
end

@external
func is_match{
        storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(number : felt) -> (result : felt):
    let (condition) = criterion.read()
    if number == condition:
        let (total) = do_thing()
        return (total)
    else:
        return (0)
    end
end

@external
func store_criterion{
        storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(number : felt):
    criterion.write(number)
    return ()
end

func do_thing{
        storage_ptr : Storage*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (total : felt):
    let (mem) = met_criteria_memory.read()
    met_criteria_memory.write(mem + 1)
    return (mem + 1)
end
