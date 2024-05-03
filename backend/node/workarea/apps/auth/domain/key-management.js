


module.exports = {
    generateSecretKey: async function() {
        const secretKey = await crypto.randomBytes(64).toString('hex');
        return secretKey;
    },
    generateKeyPair: async function() {
        const { privateKey, publicKey } = await crypto.generateKeyPairSync('rsa', {
            modulusLength: 2048,
            publicKeyEncoding: {
                type: 'spki',
                format: 'pem'
            },
            privateKeyEncoding: {
                type: 'pkcs8',
                format: 'pem'
            }
        });
        return [publicKey, privateKey];
    }
};


