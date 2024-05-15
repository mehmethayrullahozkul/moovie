const crypto = require('crypto');


module.exports = {
    isString: function(str) {
        if (typeof str === 'string' || str instanceof String) {
            return true;
        }
        else {
            return false;
        }
    },
    inSize: function(min, max, str) {
        if(str.length <= max && str.length >= min) {
            return true;
        }
        else {
            return false;
        }
    },
    isBase64Url: function(str) {
        const pattern_base64url = /[^A-Za-z0-9\.\-_]/g;
        if((str.match(pattern_base64url) || []).length != 0) {
            return false;
        }
        else {
            return true;
        }
    },
    uid:  function(str)  {
        const salt = 'RANDOMTODOSALT';
        const hmac = crypto.createHmac('md5', '');
        hmac.update(str + salt);
        const uuid16Byte =  hmac.digest('base64').slice(0, 22);
        const uuid8Byte = uuid16Byte.slice(0, 8);
        return this.byteArrayToUrlToDecimal(this.base64urlToByteArray(uuid8Byte));
    },
    base64urlToByteArray: function(base64String) {
        
        let binaryString = atob(base64String);
        // Convert binary string to byte array
        let byteArray = new Uint8Array(binaryString.length);
        for (let i = 0; i < binaryString.length; i++) {
            byteArray[i] = binaryString.charCodeAt(i);
        }
        return byteArray;
    },
    byteArrayToUrlToDecimal: function (byteArray) {
        // Convert byte array to unsigned long string
        let result = '';
        for (let i = 0; i < byteArray.length; i++) {
            result += byteArray[i].toString().padStart(3, '0'); // Ensure each byte has at least 3 digits
        }
        return result;
    }

}