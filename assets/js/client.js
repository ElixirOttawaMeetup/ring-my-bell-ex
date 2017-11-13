const L_ID = 'client_id'

function getId() {
  let id;
  id = window.localStorage.getItem(L_ID)

  if (!id) {
    id = generateId()
    window.localStorage.setItem(L_ID, id)
  }
  return id;
}

function generateId() {
  return Math.floor((Math.random() + 1) * 0x100000000).toString(16)
}

export default class Client {
  constructor(channelId) {
    this.channelId = channelId;
    this.id = getId();
  }
}

