function generateId() {
  return Math.floor((Math.random() + 1) * 0x100000000).toString(16)
}

export default class Client {
  constructor(channelId) {
    this.channelId = channelId;
    this.id = generateId();
  }
}

