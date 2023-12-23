%lang starknet
%builtins range_check

# Alphabet substitution cipher for each letter.
# a = 01, b = 02, etc.

#define hello variable
const hello = 10000805121215  # 08, 05, 12, 12, 15.

#define world variable
const world = 10002315181204  # 23, 15, 18, 12, 04.

@view
func greeting() -> (number_1 : felt, number_2 : felt):
    return (hello, world)
end
