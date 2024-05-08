
import validateOpts from './validate_options.mjs';
/* const bodyJsonSchema = {
  type: 'object',
  required: ['username', 'password'],
  properties: {
    someKey: { type: 'string' },
    someOtherKey: { type: 'number' },
    username: {
      type: 'string',

      maxItems: 3,
      items: { type: 'integer' }
    },
    nullableKey: { type: 'number', nullable: true }, // or { type: 'number', nullable: true }
    multipleTypesKey: { type: ['boolean', 'number'] },
    multipleRestrictedTypesKey: {
      oneOf: [
        { type: 'string', maxLength: 5 },
        { type: 'number', minimum: 10 }
      ]
    },
    enumKey: {
      type: 'string',
      enum: ['John', 'Foo']
    },
    notTypeKey: {
      not: { type: 'array' }
    }
  }
} */

const bodyJsonSchema = {
  type: 'object',
  required: ['username', 'password', 'language'],
  properties: {
    username: { 
      type: 'string',
      minLength: validateOpts.MIN_USERNAME_LENGTH,
      maxLength: validateOpts.MAX_USERNAME_LENGTH,
      pattern: validateOpts.USERNAME_PATTERN
    },
    password: {
      type: 'string',
      minLength: validateOpts.MIN_PASSWORD_LENGTH,
      maxLength: validateOpts.MAX_PASSWORD_LENGTH,
      pattern: validateOpts.PASSWORD_PATTERN
    },
    language: {
      type: 'string',
      enum: ['TR-tr', 'US-en']
    },
  }
}

const queryStringJsonSchema = {
  type: 'object',
  properties: {
    name: { type: 'string' },
    excitement: { type: 'integer' }
  }
}

const paramsJsonSchema = {
  type: 'object',
  properties: {
    par1: { type: 'string' },
    par2: { type: 'number' }
  }
}

const headersJsonSchema = {
  type: 'object',
  properties: {
    'x-foo': { type: 'string' }
  },
  required: ['x-foo']
}



const opts = {
  schema: {
    body: bodyJsonSchema,
  }
}


async function authentication (fastify, options) {
    fastify.post('/api/login', opts, async (request, reply) => {
      return { hello: 'world' }
    })
  }

  

  export default authentication;