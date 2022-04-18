# Example contract on goerli
# 0x01bc8eb61c988ef60450d8188637fc8215096ba6fc24200d95f23f712db80eb9

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

# Returns the certain number.
@view
func see_my_number{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (res : felt):
    let res = 7
    return (res)
end


