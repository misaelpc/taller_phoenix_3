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

  setupElements(){
    switch(window.location.pathname) {
      case "/balance":
      this.setupBalanceElements()
        break;
      default:
        break;
    }
  }
  setupBalanceElements(){
    let btcusd = document.querySelector("#btcBuyPrice")
    let ethusd = document.querySelector("#ethBuyPrice")
    this.channel.on("btc_usd", payload => {
      btcusd.innerHTML = `${payload.body} USD`
    })
    this.channel.on("eth_usd", payload => {
      ethusd.innerHTML = `${payload.body} USD`
    })
  }
}

let liveUpdate = new LiveUpdate
liveUpdate.join()
liveUpdate.setupElements()
export default socket