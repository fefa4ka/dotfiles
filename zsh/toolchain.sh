# IDF
alias get_idf='. $HOME/Toolchain/esp-idf/export.sh'

# WTF? Why it needed?
export PATH="/usr/local/opt/node@14/bin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/fefa4ka/Toolchain/xpack-riscv-none-embed-gcc-10.2.0-1.2/bin:$PATH"

# Zephyr
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH=/usr/local/

export ZEPHYR_TOOLCHAIN_VARIANT="espressif"
export ESPRESSIF_TOOLCHAIN_PATH="${HOME}/.espressif/tools/xtensa-esp32-elf/esp-2020r3-8.4.0/xtensa-esp32-elf"
export PATH=$PATH:$ESPRESSIF_TOOLCHAIN_PATH/bin
