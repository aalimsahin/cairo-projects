# Example contract on goerli
# 0x042e61e7aba6dd643824a285c78b5bd49eebc8993a21b3312c48890fd13e08c3

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn

# Define a storage variable.
@storage_var
func datas(id: felt) -> (data : felt):
end


# Returns the current data.
@view
func get_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(id: felt) -> (data : felt):
    let (_data) = datas.read(id)
    return (_data)
end

# Set new data.
@external
func set_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(id : felt, new_data : felt):
    # Verify that the id and new_data is positive.
    with_attr error_message(
            "id and new_data must be positive. Got: id={id}, new_data={new_data}."):
        assert_nn(id)
        assert_nn(new_data)
    end

    # Update data.
    datas.write(id, new_data)
    return ()
end