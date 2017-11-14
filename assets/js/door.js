import Maybe from './maybe'
import Client from './client'

class View {
  constructor(client) {
    this.client = client
    this.$view = document.getElementById('door')
    this.$message = this.$view.querySelector('.message')
  }

  changeMessage(newMsg) {
    this.$message.innerHTML = newMsg
  }

  appendMessage(newMsg) {
    this.$message.innerHTML += `<br /> ${newMsg}`
  }

  bellRang() {
    this.changeMessage('Notified the organizers')
  }
}

/* Helpers
 *
 */

function getDoorId() {
  const maybeDoorDom = Maybe(document.getElementById('door'))
  const maybeDoorId = maybeDoorDom.getAttribute('data-door-id')

  return maybeDoorId.value
}

/* Public interface
 *
 */
export default function(socket) {
  const doorId = getDoorId()
  if (!doorId) return

  const client = new Client(doorId)
  const view = new View(client)

  const channel = socket.channel(`door:${doorId}`, {})

  channel.join()
    .receive('ok', _resp => {
      channel.push('ring', {client_id: client.id})
    })
    .receive('error', resp => { console.log('Unable to join', resp) })

  channel.on('coming', _ => {
    view.appendMessage('An organizer is coming down!')
  })
}
