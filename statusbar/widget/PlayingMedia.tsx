import { Gtk } from "astal/gtk3";
import { bind } from "astal";
import Mpris from "gi://AstalMpris";

function AlbumArt({ player }: { player: Mpris.Player }) {
  const coverArt = bind(player, "coverArt");
  return (
    <box
      className="Cover"
      valign={Gtk.Align.CENTER}
      css={coverArt.as(url => `background-image: url('${url}')`)}
    />
  )
}

function SongInfo({ player }: { player: Mpris.Player }) {
  const onSongChange = bind(player, "title")
  return (
    <label
      label={
        onSongChange.as(() => `${player.title} - ${player.artist}`)
      }
    />
  )
}

export default function Media() {
    const mpris = Mpris.get_default()
    const onPlayerChange = bind(mpris, "players");

    return (
      <box className="Media">{
        onPlayerChange.as(players => {
          if (players.length === 0) { return null; }

          return (
            <box>
              <AlbumArt player={players[0]} />
              <SongInfo player={players[0]} />
            </box>
          )
        })
      }</box>
    )
}
