import { query } from 'gamedig'
// up handler

export async function serverGetStatus() {
  await query({
    type: 'valheim',
    host: ''
  })
    .then((state) => {
      console.log(state)
      console.log({ playerCount: state?.raw })
      return state?.raw
    })
    .catch((error) => {
      console.log('Server is offline')
      console.log(error)
    })
}
