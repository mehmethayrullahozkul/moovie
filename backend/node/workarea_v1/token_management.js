
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const express = require('express');
const strutl = require('./string_utilities');
require('dotenv').config();



const sha_SignOptions = {
    algorithm: "HS512",
    expiresIn: '30s'
};


const sha_VerifyOptions = {
    algorithms: ['HS512'],
};


const tokenOptions = {
    min: 40,
    max: 500
};



module.exports = {

    // Authentication middleware
    authenticate: async function(req, res, next)
    {
        const token = await req.headers['token'];
        // check if identifier, password and name send by request
        if(!token)
        {
            res.status(431).send();
        }

        const [result, message, is_sign_valid, is_token_valid] = await module.exports.VerifyToken(token);

        if(!result)
        {
            res.status(432).send({msg: message});
        }
        
        if(result)
            next();
    },
    
    generateAccessToken: async function(username)
    {
        try {
            const encrypt_sign = await crypto.createSign('RSA-SHA512');
            var sha_token = await jwt.sign({username : username}, `${process.env.TOKEN_SECRET}`, sha_SignOptions);
            const [sha_header, sha_payload, sha_oldsign] = await sha_token.split('.', 3);
            //const hmac = await crypto.createHmac('sha512', process.env.TOKEN_SECRET);
            //await hmac.update(sha_header+'.'+sha_payload);
            //const hashed_data = await hmac.digest('base64url');
            await encrypt_sign.update(sha_oldsign);
            const encrpyted_signature = await encrypt_sign.sign(`${process.env.TOKEN_PRIVATE_KEY}`, 'base64url');
            const token = await sha_header + '.' + sha_payload + '.' + encrpyted_signature;
            return {status: true, result: {token: token}, error: null};
        }
        catch (e) {
            return {status: false, result: null, error: e.message};
        }
    },
    verifyToken: async function(token)
    {
        if(await !module.exports.isTokenIntact(token)) {
            return {status: false, result: {rsa: null, hsa: null}, error: 'token_invalid'};
        }
        
        const decrypt_verify = crypto.createVerify('RSA-SHA512');
        const encrypt_sign = crypto.createSign('RSA-SHA512');

        const [token_header, token_payload, token_signature] = await token.split('.', 3);

        // check token

        if(!token_header || !token_payload || !token_signature)
            return {status: false, result: {rsa: false, hsa: null}, error: 'token_invalid'};

        const token_primary = await token_header + '.' + token_payload;
        
        const hmac = await crypto.createHmac('sha512', process.env.TOKEN_SECRET);
        await hmac.update(token_primary);
        const hashed_data = await hmac.digest('base64url');

        // ***************************
        // actual data - not encrypted
        // ***************************
        await decrypt_verify.update(hashed_data);
        // token signature is the encrypted data
        const is_token_sign_valid = await decrypt_verify.verify(process.env.TOKEN_PUBLIC_KEY, token_signature, 'base64url');
        if(!is_token_sign_valid)
            return {status: false, result: {rsa: false, hsa: null}, error: 'token_authentication_failed'};

        /* console.log(token_primary + '.' + hashed_data); */
        try 
        {
            const is_token_valid = await jwt.verify(token_primary + '.' + hashed_data, process.env.TOKEN_SECRET, sha_VerifyOptions);
            return {status: true, result: {rsa: true, hsa: true}, error: null};
        } catch (error) 
        {
            return {status: false, result: {rsa: true, hsa: false}, error: error.message};
        }
    },
    isTokenIntact: function(token) {
        if(!strutl.isString(token)) {
            return false;
        }
        if(!strutl.inSize(tokenOptions.min, tokenOptions.max, token)) {
            return false;
        }
        if(!strutl.isBase64Url(token)) {
            return false;
        }
        if(token.match((/[\.]/g) || []).length != 2) {
            return false;
        }
        return true;
    }
    
};