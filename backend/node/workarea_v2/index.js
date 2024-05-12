import Fastify from 'fastify';
import home from './authentication_routes.mjs';
import ajv from './ajv_provider.js';
import * as DR from './data_routes.mjs';
import fastifyHelmet from '@fastify/helmet';
import errorHandler from './error_handler.mjs';

const fastify = Fastify({
    logger: false
  });

fastify.register(fastifyHelmet, { global: true });

// Register the custom ajv instance as a validator compiler
fastify.setValidatorCompiler(({ schema, method, url, httpPart }) => { return ajv.compile(schema);});

// Register the custom error handler
fastify.setErrorHandler(errorHandler);

// Regşster routes
/* fastify.register(home); */
fastify.route(home);
fastify.route(DR.home);
fastify.route(DR.secretData);


// Run the server!
fastify.listen({port: 3000, host: '0.0.0.0'}, function (err, address) {
    if (err) {
        fastify.log.error(err)
        process.exit(1)
    }
    fastify.log.info(`server listening on ${address}`)
});

