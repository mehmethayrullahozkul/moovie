import * as EC from './error_codes.mjs';

async function tokenPreParse(request, reply, payload, done) {
    console.log('preParsing has been called');
    const token = request.headers['token'];
    if (!token) {
        /* const error = new Error('Token is required');
        error.statusCode = 401;
        done(error); */
        reply.status(EC.AUTHENTICATION_TOKEN_MISSING.status).send(EC.AUTHENTICATION_TOKEN_MISSING.error);
        return;
    }
    done()
};

export default tokenPreParse;