import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

class LiveUpdate {
  constructor() {
    this.channel = socket.channel("ex_monitor:rates", {})
  }

  join(){
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }
}

let liveUpdate = new LiveUpdate
liveUpdate.join()

export default socket