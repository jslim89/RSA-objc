<?php
$plain_text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

// read the private key
$private_key = openssl_pkey_get_private(file_get_contents('../Resources/Keys/private_key.pem'));
$private_key_details = openssl_pkey_get_details($private_key);

// there is no need to minus the overhead
$encrypt_chunk_size = ceil($private_key_details['bits'] / 8) - 11;
$output = '';

// encrypt it back chunk-by-chunk
while ($plain_text) {
    $chunk = substr($plain_text, 0, $encrypt_chunk_size);
    $plain_text = substr($plain_text, $encrypt_chunk_size);
    $encrypted = '';
    if (!openssl_private_encrypt($chunk, $encrypted, $private_key))
        die('Failed to encrypt data');
    $output .= $encrypted;
}
openssl_free_key($private_key);
echo base64_encode($output).PHP_EOL;
