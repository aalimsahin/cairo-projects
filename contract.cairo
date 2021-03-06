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



################################################################
########################### STORAGE ############################
################################################################

# Define a storage variable.
@storage_var
func balance() -> (res : felt):
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
}() -> (res : felt):
    let (res) = balance.read()
    return (res)
end


################################################################
########################## EXTERNAL ############################
################################################################

# Increases the balance by the given amount.
@external
func increase_balance{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(amount : felt):
    let (res) = balance.read()
    balance.write(res + amount)
    return ()
end

################################################################
########################## INTERNAL ############################
################################################################
