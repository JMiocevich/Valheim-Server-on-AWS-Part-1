import { serverGetStatus } from './domainFunction'

export async function handler() {
  await serverGetStatus()
}
