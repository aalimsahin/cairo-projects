#                AAA               LLLLLLLLLLL             IIIIIIIIIIMMMMMMMM               MMMMMMMM 
#               A:::A              L:::::::::L             I::::::::IM:::::::M             M:::::::M
#              A:::::A             L:::::::::L             I::::::::IM::::::::M           M::::::::M
#             A:::::::A            LL:::::::LL             II::::::IIM:::::::::M         M:::::::::M
#            A:::::::::A             L:::::L                 I::::I  M::::::::::M       M::::::::::M
#           A:::::A:::::A            L:::::L                 I::::I  M:::::::::::M     M:::::::::::M
#          A:::::A A:::::A           L:::::L                 I::::I  M:::::::M::::M   M::::M:::::::M
#         A:::::A   A:::::A          L:::::L                 I::::I  M::::::M M::::M M::::M M::::::M
#        A:::::A     A:::::A         L:::::L                 I::::I  M::::::M  M::::M::::M  M::::::M
#       A:::::AAAAAAAAA:::::A        L:::::L                 I::::I  M::::::M   M:::::::M   M::::::M
#      A:::::::::::::::::::::A       L:::::L                 I::::I  M::::::M    M:::::M    M::::::M
#     A:::::AAAAAAAAAAAAA:::::A      L:::::L         LLLLLL  I::::I  M::::::M     MMMMM     M::::::M
#    A:::::A             A:::::A   LL:::::::LLLLLLLLL:::::LII::::::IIM::::::M               M::::::M
#   A:::::A               A:::::A  L::::::::::::::::::::::LI::::::::IM::::::M               M::::::M
#  A:::::A                 A:::::A L::::::::::::::::::::::LI::::::::IM::::::M               M::::::M
# AAAAAAA                   AAAAAAALLLLLLLLLLLLLLLLLLLLLLLLIIIIIIIIIIMMMMMMMM               MMMMMMMM


#    SSSSSSSSSSSSSSS              AAA               HHHHHHHHH     HHHHHHHHHIIIIIIIIIINNNNNNNN        NNNNNNNN
#  SS:::::::::::::::S            A:::A              H:::::::H     H:::::::HI::::::::IN:::::::N       N::::::N
# S:::::SSSSSS::::::S           A:::::A             H:::::::H     H:::::::HI::::::::IN::::::::N      N::::::N
# S:::::S     SSSSSSS          A:::::::A            HH::::::H     H::::::HHII::::::IIN:::::::::N     N::::::N
# S:::::S                     A:::::::::A             H:::::H     H:::::H    I::::I  N::::::::::N    N::::::N
# S:::::S                    A:::::A:::::A            H:::::H     H:::::H    I::::I  N:::::::::::N   N::::::N
#  S::::SSSS                A:::::A A:::::A           H::::::HHHHH::::::H    I::::I  N:::::::N::::N  N::::::N
#   SS::::::SSSSS          A:::::A   A:::::A          H:::::::::::::::::H    I::::I  N::::::N N::::N N::::::N
#     SSS::::::::SS       A:::::A     A:::::A         H:::::::::::::::::H    I::::I  N::::::N  N::::N:::::::N
#        SSSSSS::::S     A:::::AAAAAAAAA:::::A        H::::::HHHHH::::::H    I::::I  N::::::N   N:::::::::::N
#             S:::::S   A:::::::::::::::::::::A       H:::::H     H:::::H    I::::I  N::::::N    N::::::::::N
#             S:::::S  A:::::AAAAAAAAAAAAA:::::A      H:::::H     H:::::H    I::::I  N::::::N     N:::::::::N
# SSSSSSS     S:::::S A:::::A             A:::::A   HH::::::H     H::::::HHII::::::IIN::::::N      N::::::::N
# S::::::SSSSSS:::::SA:::::A               A:::::A  H:::::::H     H:::::::HI::::::::IN::::::N       N:::::::N
# S:::::::::::::::SSA:::::A                 A:::::A H:::::::H     H:::::::HI::::::::IN::::::N        N::::::N
#  SSSSSSSSSSSSSSS AAAAAAA                   AAAAAAAHHHHHHHHH     HHHHHHHHHIIIIIIIIIINNNNNNNN         NNNNNNN


# Declare this file as a StarkNet contract.
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import assert_nn


################################################################
########################### STORAGE ############################
################################################################

# Define a storage variable.
@storage_var
func balance(user : felt) -> (res : felt):
end

################################################################
######################### CONSTRUCTOR ##########################
################################################################


################################################################
############################ VIEWS #############################
################################################################

# Returns the current balance.
@view
func get_balance{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(user : felt) -> (res : felt):
    let (res) = balance.read(user=user)
    return (res)
end

################################################################
########################## EXTERNAL ############################
################################################################


# Increases the balance of the user by the given amount.
@external
func increase_balance{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(amount : felt):
    # Verify that the amount is positive.
    with_attr error_message(
            "Amount must be positive. Got: {amount}."):
        assert_nn(amount)
    end

    # Obtain the address of the account contract.
    let (user) = get_caller_address()

    # Read and update its balance.
    let (res) = balance.read(user=user)
    balance.write(user, res + amount)
    return ()
end



@external
func compare_arrays(
    a_len : felt, a : felt*, b_len : felt, b : felt*
):
    assert a_len = b_len
    if a_len == 0:
        return ()
    end
    assert a[0] = b[0]
    return compare_arrays(
        a_len=a_len - 1, a=&a[1], b_len=b_len - 1, b=&b[1]
    )
end

################################################################
########################## INTERNAL ############################
################################################################
