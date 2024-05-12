const errorHandler = (error, request, reply) => {
    const statusCode = error.statusCode
    let response
  
    const { validation, validationContext } = error
  
    // check if we have a validation error
    if (validation) {
      response = {
        // validationContext will be 'body' or 'params' or 'headers' or 'query'
        message: `A validation error occurred when validating the ${validationContext}...`,
        // this is the result of your validation library...
        errors: validation
      }
    } else {
      response = {
        message: 'An error occurred...'
      }
    }
  
    // any additional work here, eg. log error
    // ...
  
    reply.status(statusCode).send(response)
  }

  export default errorHandler;