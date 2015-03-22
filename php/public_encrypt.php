<?php
$plain_text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

// read the public key
$public_key = openssl_pkey_get_public(file_get_contents('../Resources/Keys/public_key.pem'));
$public_key_details = openssl_pkey_get_details($public_key);
// there are 11 bytes overhead for PKCS1 padding
$encrypt_chunk_size = ceil($public_key_details['bits'] / 8) - 11;
$output = '';
// loop through the long plain text, and divide by chunks
while ($plain_text) {
    $chunk = substr($plain_text, 0, $encrypt_chunk_size);
    $plain_text = substr($plain_text, $encrypt_chunk_size);
    $encrypted = '';
    if (!openssl_public_encrypt($chunk, $encrypted, $public_key))
        die('Failed to encrypt data');
    $output .= $encrypted;
}
openssl_free_key($public_key);
echo base64_encode($output).PHP_EOL;
