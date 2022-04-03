import { serverStart } from './domainFunction'

export async function handler() {
  await serverStart()
}
