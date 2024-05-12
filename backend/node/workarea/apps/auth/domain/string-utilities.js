
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
    }
}