
const fastify = require('fastify')({logger: true})
const path = require('node:path')

fastify.register(require('@fastify/static'), {
  root: path.join(__dirname, '.'),
  prefix: '/', // optional: default '/'
})

// Run the server!
fastify.listen({ port: 3000 }, (err, address) => {
    if (err) {
        fastify.log.error(err)
        process.exit(1)
      }
  // Server is now listening on ${address}
})