
noblacklist ${HOME}/.config/nvim
noblacklist ${HOME}/.config/bash
noblacklist ${HOME}/.local/bin
noblacklist ${HOME}/.cargo

noblacklist ${PATH}/cc
noblacklist ${PATH}/rustc
noblacklist ${PATH}/g++
noblacklist ${PATH}/ld
noblacklist ${PATH}/gcc*
noblacklist ${PATH}/*-g++*
noblacklist ${PATH}/*-gcc*
noblacklist ${PATH}/clangd


noblacklist /usr/lib/gcc
noblacklist /usr/lib64/rustlib

noblacklist /usr/include
noblacklist /usr/local
noblacklist /usr/local/include

ignore noexec /usr/bin

noblacklist ${HOME}/dev
noblacklist ${HOME}/downloads

read-write ${HOME}/.config/bash
read-write ${HOME}/.config/nvim



