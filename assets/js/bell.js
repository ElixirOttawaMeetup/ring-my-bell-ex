import Maybe from './maybe'
import Client from './client'

class View {
  constructor(client) {
    this.client = client;
    this.waitingClients = []
    this.$view = document.getElementById("bell")
    this.$waiters = this.$view.querySelector(".waiters");
  }

  render() {
    this.$waiters.innerHTML = `${this.waitingClients.length} folk(s) waiting`
  }

  addWaitingClient(clientId) {
    if (this.waitingClients.indexOf(clientId) === -1){
      this.waitingClients.push(clientId)
    }

    this.render();
  }
}
function getBellId() {
  return Maybe(document.getElementById("bell"))
    .getAttribute('data-bell-id')
    .value;
}

export default function(socket) {
  const bellId = getBellId();
  if (!bellId) return;

  const client = new Client(bellId)
  const view = new View(client)

  const channel = socket.channel(`door:${bellId}`, {})

  channel.join()
    .receive("ok", resp => { console.log("Joined the channel") })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on("ring", ({client_id}) => {
    view.addWaitingClient(client_id)
  })
}
