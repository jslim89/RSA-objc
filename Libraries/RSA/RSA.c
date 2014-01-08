//
//  RSA.c
//  RSA Example
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/err.h>
#include "Base64.h"

char *js_private_decrypt(const char *cipher_text, const char *private_key_path) {
    RSA *rsa_privateKey = NULL;
    FILE *fp_privateKey;
    int rsa_private_len;
    
    if ((fp_privateKey = fopen(private_key_path, "r")) == NULL) {
        printf("Could not open %s\n", private_key_path);
        return '\0';
    }
    
    if ((rsa_privateKey = PEM_read_RSAPrivateKey(fp_privateKey, NULL, NULL, NULL)) == NULL) {
        printf("Error loading RSA Private Key File.");
        return '\0';
    }
    fclose(fp_privateKey);
    
    printf("Cipher text: %s\n", cipher_text);
    
    rsa_private_len = RSA_size(rsa_privateKey);
    printf("RSA private length: %d\n", rsa_private_len);
    
    size_t crypt_len = 0;
    
    unsigned char *crypt = base64_decode(cipher_text, strlen(cipher_text), &crypt_len);
    
    printf("Decoded cipher: %s\nCrypt length: %ld\n", crypt, crypt_len);
    
    // If no static, it will cause "address of stack memory associated with local variable ...", which mean the variable will released from memory after the end of this function
    static char plain_char[200];
    // initialize
    strcpy(plain_char, "");
    
    char *err = NULL;
    for (int i = 0; i < crypt_len; i += rsa_private_len) {
        char crypt_chunk[rsa_private_len];
        memcpy(&crypt_chunk[0], &crypt[i], rsa_private_len);
        
        printf("Crypt chunk: %s\n", crypt_chunk);
        
        char *result_chunk = malloc(crypt_len);
        int result_length = RSA_private_decrypt(rsa_private_len, (unsigned char*)crypt_chunk, (unsigned char *)result_chunk, rsa_privateKey, RSA_PKCS1_PADDING);
        // chunk length should be the size of privatekey (in bytes) minus 11 (overhead during encryption)
        printf("Result chunk: %s\nChunk length: %d\n", result_chunk, result_length);
        
        // this is to omit the dummy character behind
        // i.e. Result chunk: ABC-1234567-201308101427371250-abcdefghijklmnopqrstuv\240Z
        //      Chunk length: 53
        //      New chunk: ABC-1234567-201308101427371250-abcdefghijklmnopqrstuv
        //
        // by copying the chunk to a temporary variable with an extra length (i.e. in this case is 54)
        // and then set the last character of temporary variable to NULL
        char tmp_result[result_length + 1];
        strcpy(tmp_result, result_chunk);
        tmp_result[result_length] = '\0';
        printf("New chunk: %s\n", tmp_result);
        
        if (result_length == -1) {
            ERR_load_CRYPTO_strings();
            fprintf(stderr, "Error %s\n", ERR_error_string(ERR_get_error(), err));
            fprintf(stderr, "Error %s\n", err);
        }
        
        strcat(plain_char, tmp_result);
    }
    
    RSA_free(rsa_privateKey);
    printf("Final result: %s\n", plain_char);
    
    return plain_char;
}

char *js_public_encrypt(const char *plain_text, const char *public_key_path) {
    RSA *rsa_publicKey = NULL;
    FILE *fp_publicKey;
    int rsa_public_len;
    
    if ((fp_publicKey = fopen(public_key_path, "r")) == NULL) {
        printf("Could not open %s\n", public_key_path);
        return '\0';
    }
    
    if ((rsa_publicKey = PEM_read_RSA_PUBKEY(fp_publicKey, NULL, NULL, NULL)) == NULL) {
        printf("Error loading RSA Public Key File.");
        return '\0';
    }
    fclose(fp_publicKey);
    
    printf("Plain text: %s\n", plain_text);
    
    rsa_public_len = RSA_size(rsa_publicKey);
    printf("RSA public length: %d\n", rsa_public_len);
    
    char cipher_char[1000];
    // initialize
    strcpy(cipher_char, "");
    
    // 11 bytes is overhead required for encryption
    int chunk_length = rsa_public_len - 11;
    // plain text length
    int plain_char_len = strlen(plain_text);
    
    char *err = NULL;
    for (int i = 0; i < plain_char_len; i += chunk_length) {
        // take out chunk of plain text
        char plain_chunk[chunk_length];
        memcpy(&plain_chunk[0], &plain_text[i], chunk_length);
        
        printf("Plain chunk: %s\n", plain_chunk);
        
        char *result_chunk = malloc(chunk_length);
        
        int result_length = RSA_public_encrypt(chunk_length, (unsigned char*)plain_chunk, (unsigned char*)result_chunk, rsa_publicKey, RSA_PKCS1_PADDING);
        printf("Result chunk: %s\nChunk length: %d\n", result_chunk, result_length);
        
        if (result_length == -1) {
            ERR_load_CRYPTO_strings();
            fprintf(stderr, "Error %s\n", ERR_error_string(ERR_get_error(), err));
            fprintf(stderr, "Error %s\n", err);
        }
        
        strcat(cipher_char, result_chunk);
    }
    
    RSA_free(rsa_publicKey);
    size_t total_len = 0;
    char *encrypted = base64_encode(cipher_char, strlen(cipher_char), &total_len);
    printf("Final result: %s\n Final result length: %zu", encrypted, total_len);
    
    return encrypted;
}