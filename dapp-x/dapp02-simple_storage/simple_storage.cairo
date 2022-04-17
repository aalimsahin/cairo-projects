# Example contract on goerli
# 0x07c8880bcefcb3a8b46b1d45842fca703e20dce81e0f1fcb23b0371636aba751

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn

# Define a storage variable.
@storage_var
func data() -> (data : felt):
end


# Returns the current balance.
@view
func get_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}() -> (data : felt):
    let (_data) = data.read()
    return (_data)
end

# Increases the balance of the user by the given amount.
@external
func set_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(new_data : felt):
    # Verify that the new_data is positive.
    with_attr error_message(
            "New_data must be positive. Got: {new_data}."):
        assert_nn(new_data)
    end

    # Update data.
    data.write(new_data)
    return ()
end