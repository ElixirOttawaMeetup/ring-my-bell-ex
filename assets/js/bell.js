import Maybe from './maybe'
import Client from './client'

class View {
  constructor(client, channel) {
    this.client = client
    this.channel = channel
    this.waitingClients = []
    this.$comingButton = document.getElementById('coming-button')
    this.$view = document.getElementById('bell')
    this.$waiters = this.$view.querySelector('.waiters')

    this.$comingButton.addEventListener('click', this.sendComing.bind(this), false)
  }

  render() {
    this.$waiters.innerHTML = `${this.waitingClients.length} folk(s) waiting`
  }

  addWaitingClient(clientId) {
    if (this.waitingClients.indexOf(clientId) === -1){
      this.waitingClients.push(clientId)
    }

    this.render()
  }

  clearWaitingClients() {
    this.waitingClients = []
    this.render()
  }

  sendComing(){
    this.clearWaitingClients()
    this.channel.push('coming', {client_id: this.client.id})
  }
}

function getBellId() {
  return Maybe(document.getElementById('bell'))
    .getAttribute('data-bell-id')
    .value
}

export default function(socket) {
  const bellId = getBellId()
  if (!bellId) return

  const channel = socket.channel(`door:${bellId}`, {})

  const client = new Client(bellId)

  channel.join()
    .receive('ok', _resp => { console.log('Joined the channel') })
    .receive('error', resp => { console.log('Unable to join', resp) })

  const view = new View(client, channel)

  channel.on('ring', ({client_id}) => {
    view.addWaitingClient(client_id)
  })
}
