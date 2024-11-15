'use client'
import { error } from "console";
import {Socket} from "phoenix";

export default function Home() {
  let n = "hi"
  if (navigator.geolocation) {

    navigator.geolocation.getCurrentPosition(position => {

        // Access location data here (e.g., position.coords.latitude, position.coords.longitude)
      console.log(position)
    }, error => {

        // Handle permission denied or other errors
        console.error("Error getting location:", error);
    });

} else {

    console.log("Geolocation is not supported by this browser");

}

  let socket = new Socket("ws://localhost:4000/socket", {});
  socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42: 
let channel = socket.channel("chat:lobby", {})
channel.join()
  .receive("ok", (resp: any) => { console.log("Joined successfully", resp) })
  .receive("error", (resp: any) => { console.log("Unable to join", resp) })
channel.push("ping", {body: "hello"}).receive("ok", (resp: any) => { console.log("ping", resp) })
channel.push("shout", {body: n})
channel.on("shout", (payload: any) => { console.log("shout", payload) })
const test = () => {channel.push("ping", {body: "hello"}).receive("ok", (resp: any) => { console.log("ping", resp) })}

  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
       <h1>Suicune</h1>
       <p>Welcome.</p>
       <button onClick={test}>test</button>
    </div>
  );
}
