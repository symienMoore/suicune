import {Socket} from "phoenix";

export default function Home() {
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
channel.push("shout", {body: "yo yo"})


  return (
    <div className="grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20 font-[family-name:var(--font-geist-sans)]">
       <h1>Suicune</h1>
    </div>
  );
}
