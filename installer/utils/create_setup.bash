#!/bin/bash

# TOP_DIR の設定 (必要に応じて適切なディレクトリに変更)
TOP_DIR="${ROOT_DIR}/usr/local"
#echo ${ROOT_DIR}

# 環境変数の定義
LD_LIBRARY_PATH_VAR="${TOP_DIR}/lib/hakoniwa:${TOP_DIR}/lib/hakoniwa/py"
PATH_VAR="${TOP_DIR}/bin/hakoniwa"
PYTHONPATH_VAR="${TOP_DIR}/lib/hakoniwa:${TOP_DIR}/lib/hakoniwa/py"

#BIN_PATH
BIN_PATH_VAR="${ROOT_DIR}/usr/local/bin/hakoniwa"
CONFIG_PATH_VAR="${ROOT_DIR}/var/lib/hakoniwa/config"
HAKO_CONFIG_PATH_VAR="${ROOT_DIR}/etc/hakoniwa/cpp_core_config.json"
HAKO_BINARY_PATH_VAR="${ROOT_DIR}/usr/local/lib/hakoniwa/hako_binary/offset"

# setup.bash に環境変数を追加する関数
add_to_setup() {
    local var_name="$1"
    local var_value="$2"
    
    echo "export ${var_name}=${var_value}" >> ./setup.bash
    echo "${var_name} added to setup.bash"
}
rm -f setup.bash

# 環境変数を.setupに追加 (すでに存在しない場合のみ)
if [ ${OS_TYPE} = "linux" ]
then
    add_to_setup "LD_LIBRARY_PATH" "${LD_LIBRARY_PATH_VAR}:\$LD_LIBRARY_PATH"
else
    add_to_setup "DYLD_LIBRARY_PATH" "${LD_LIBRARY_PATH_VAR}:\$DYLD_LIBRARY_PATH"
fi
add_to_setup "PATH" "${PATH_VAR}:\$PATH"
add_to_setup "PYTHONPATH" "${PYTHONPATH_VAR}:\$PYTHONPATH"
add_to_setup "BIN_PATH" "${BIN_PATH_VAR}"
add_to_setup "CONFIG_PATH" "${CONFIG_PATH_VAR}"
add_to_setup "HAKO_CONFIG_PATH" "${HAKO_CONFIG_PATH_VAR}"
add_to_setup "HAKO_BINARY_PATH" "${HAKO_BINARY_PATH_VAR}"
echo "Installation complete. Environment variables have been set."