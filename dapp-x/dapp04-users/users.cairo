# Example contract on goerli
# 0x06025b128311f11cc277aced9151ef6c12ce78a818a2a71381c45fde2ae93d86

# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
# Check Math functions: https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/cairo/common/math.cairo
from starkware.cairo.common.math import assert_nn, assert_le

# Define a struct
struct Employee:
    member id_number : felt
    member phone_number : felt
    member salary : felt
end

# Define a storage variable.
@storage_var
func datas(id : felt) -> (employee_data : Employee):
end

@storage_var
func next_id() -> (next_id : felt):
end


# Returns the user data.
@view
func get_employee_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(id : felt) -> (employee_data : Employee):
    let (employee_data) = datas.read(id)
    return (employee_data)
end

# Change user data
@external
func set_employee_data{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(id: felt, new_employee_data : Employee):

    let (_next_id) = next_id.read()

    with_attr error_message(
            "Next_id must be bigger than id. Got: Id:{id}, next id: {_next_id}."):
        assert_le(id, _next_id)
    end

    # Update data.
    datas.write(id, new_employee_data)
    return ()
end

# Change user data
@external
func add_new_user{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(new_employee_data : Employee):

    let (_next_id) = next_id.read()

    # Update data.
    datas.write(_next_id, new_employee_data)
    next_id.write(_next_id + 1)
    return ()
end