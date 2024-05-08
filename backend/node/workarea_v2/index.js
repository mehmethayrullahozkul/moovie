import Fastify from 'fastify'
import home from './main_route.js'
import ajv from './ajv_provider.js'

const fastify = Fastify({
    logger: true
  });


// Register the custom ajv instance as a validator compiler
fastify.setValidatorCompiler(({ schema, method, url, httpPart }) => { return ajv.compile(schema);});


// Regşster routes
fastify.register(home);


// Run the server!
fastify.listen({port: 3000, host: '0.0.0.0'}, function (err, address) {
    if (err) {
        fastify.log.error(err)
        process.exit(1)
    }
    fastify.log.info(`server listening on ${address}`)
});

