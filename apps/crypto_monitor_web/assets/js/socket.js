import {Socket} from "phoenix"
import {ChartApp} from "./chartapp.js"

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
      case "/":
      this.setupIndexElements()
       break;
      case "/balance":
      this.setupBalanceElements()
        break;
      case "/charts":
      this.setupChartElements()
        break;
      default:
        break;
    }
  }
  setupChartElements(){
    var chart =  new ChartApp()
    chart.render()
    this.channel.on("btc_usd", payload => {
      chart.updateSeries2(payload.body)
    })

    this.channel.on("eth_usd", payload => {
      chart.updateSeries1(payload.body)
    })
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
  setupIndexElements(){
    let btcusd = document.querySelector("#btc_usd")
    let btcimg = document.querySelector("#btc_img")
    this.channel.on("btc_usd", payload => {
      btcusd.innerHTML = `${payload.body}`
    })
    this.channel.on("btc_img", payload => {
      btcimg.src = `${payload.body}`
    })
  }
}

let liveUpdate = new LiveUpdate
liveUpdate.join()
liveUpdate.setupElements()
export default socket