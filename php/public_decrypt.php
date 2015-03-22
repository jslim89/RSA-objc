<?php
$cipher_text = 'RPkS5hQtdcNTWSxrA0nKjH16dxjBiTJ1eydW6j/b+zTo6Fsqx65ILJS262bpGDR0vuSv7EmXZk8q2/3o7cuKPXZD/Agpm7GHDjjUCCPmHzaaohNlE3GFk7bpKB0Ezu/3300Zxzc3CiKCydcEYIdSGZgHFjO6tMBmXOvoyWEtgQdfbXcsIuEnzCVLydPrV3MpCr1iYsP+mM2FIzh8TnThnu7+7DQmFHaE8BxxItm/u8kI4zXq2voCMGGyLSEiXrMyOVB4egO+ge9ouSAmWznNbzaeF6iftDPgnlC9KVscDs+g8tw8+mwdEC07QDcca6xUkRVzi9nzJjRBw/qhRHIpfJW34fKMjkBnzKl/ovC9LQyZv7ga//CWDQ3n9lz2G5/S6BEgkn9IOx1AHpMfpPnlOh3GHgDa1ofcTtY0BAXAm/weZqHfwX6JaY4mM/554qT5YNXUCNvQ4KcefbsYy6ahb+y4xGUEwn4Km9msRKJKUkBJbYxkDiaMFabqdv9Dw2kcAyhGAzJi97GNrFXls50RkvMf1ZVp+Mvzx8rs0fVdN/owvOtNVEu+DDzJg3eKuPWbFbI1eWJ3h+NGaXL852ZJC3MmhqUWXaPMGUnaoyLMYhXLz7chYCkf85V7rjRXheXPIbBo65/LE092WsZobmeTrkicdTzQ9IrjDJzPkzc7IVCU/+lIdpVy+N6kdg8ImvT3g+lSsHNB+j+OVHV5UfM3dZVDA4EywJH+G+tLQOUAk3di8iv7hpgBIOX2BuVTDYST';

// decode the text to bytes
$encrypted = base64_decode($cipher_text);

// read the private key
$public_key = openssl_pkey_get_public(file_get_contents('../Resources/Keys/public_key.pem'));
$public_key_details = openssl_pkey_get_details($public_key);

// there is no need to minus the overhead
$decrypt_chunk_size = ceil($public_key_details['bits'] / 8);
$output = '';

// decrypt it back chunk-by-chunk
while ($encrypted) {
    $chunk = substr($encrypted, 0, $decrypt_chunk_size);
    $encrypted = substr($encrypted, $decrypt_chunk_size);
    $decrypted = '';
    if (!openssl_public_decrypt($chunk, $decrypted, $public_key))
        die('Failed to decrypt data');
    $output .= $decrypted;
}
openssl_free_key($public_key);
echo $output.PHP_EOL;
