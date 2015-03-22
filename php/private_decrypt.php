<?php
$cipher_text = 'juM56/BE52ylurmydLvtSwpdh8ZPjjaAnQLSqVU3i4NXk3haFoabgvYHWOFMg0e3IrXw+W7spA42cMBZnbAO5wkjjUg8ALFOnoS8VxNanI00K14QbJAFsNe7kZ02j1OMnsonhvQgsOx0+lZXPO7uzYv5jGp7AjmGthMt2aFabxo6S1elXCHB0L3eHcRrQM0O0wppssw1gzxbtma361PwUYDg0Ty9wgHZ4Cp1eElmAqoiHx4E/w2fgl4ZFqgDgT4oC0OiF3Wl5ZB3hcvEjxkLAOxdcr3Cz3bvhPtCsi3iCvzMAcUFQckMc4+0WBSo0+7FmfwfzCptW3xK7rrRx6WayVeSqDJyGhrL+jg35LC2jr5lj2NnPpvG5vU4CVyFn2uv+xL8vbLvAmhCWMJZNoiJhF/G22fF3SVAnRtlDogvCGwZkPvGKN+kdYffpkj1VepN9V8cQsmHsj1FTGDG/kDzk6UaWHarUVD0MHydgEdsXzISG5pkGioxOT3X6ohJ368zh9iz3tfGUNi4AUN6SbDu9RbSB4SCTtpKtYP9NNObokU3WALOWTGFQ038or1XmsnCJBjLRlRDfPdvMylggM/AKISvCcmhZsd/kMsalSXlInEcY9rx6nwzGqOD9ue3zM0IeZXfwc+4lUKBJbkDK48hjOh2Z1O1OyRAJmAk03NGi3BYwMpXxLq9E7xxJBMu5QWtkk8ZXeiEADHk+WQB0VVzG9E8pOSakxeWCwKUlQqv6pWPOT0IE98epUEXwkqd3DxU';

// decode the text to bytes
$encrypted = base64_decode($cipher_text);

// read the private key
$private_key = openssl_pkey_get_private(file_get_contents('../Resources/Keys/private_key.pem'));
$private_key_details = openssl_pkey_get_details($private_key);

// there is no need to minus the overhead
$decrypt_chunk_size = ceil($private_key_details['bits'] / 8);
$output = '';

// decrypt it back chunk-by-chunk
while ($encrypted) {
    $chunk = substr($encrypted, 0, $decrypt_chunk_size);
    $encrypted = substr($encrypted, $decrypt_chunk_size);
    $decrypted = '';
    if (!openssl_private_decrypt($chunk, $decrypted, $private_key))
        die('Failed to decrypt data');
    $output .= $decrypted;
}
openssl_free_key($private_key);
echo $output.PHP_EOL;
