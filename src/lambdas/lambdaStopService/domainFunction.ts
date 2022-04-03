import { ECSClient, UpdateServiceCommand } from '@aws-sdk/client-ecs'

// up handler
export async function serverStop() {
  // get env vars
  const cluster = process.env.CLUSTER
  const service = process.env.SERVICE

  console.log(cluster)
  console.log(service)

  // start

  const input = {
    desiredCount: 0,
    service: service,
    cluster: cluster
  }

  const config = {}
  const client = new ECSClient(config)
  const command = new UpdateServiceCommand(input)
  const response = await client.send(command)
  console.log(response)

  return { message: 'Server Stopped' }
}
