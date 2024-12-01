import { Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
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

function debugPlayer(player: Mpris.Player) {
  print(`
        identity: ${player.identity}
        bus: ${player.busName}
        loop: ${player.loopStatus}
        playback: ${player.playbackStatus}
        shuffle: ${player.shuffleStatus}
        trackid: ${player.trackid}
        position: ${player.position} / length: ${player.length}
        covertArt: ${player.coverArt}
        album: ${player.album}
        albumArtist: ${player.albumArtist}
        artists: ${player.artist}
        lyrics: ${player.lyrics}
        title: ${player.title}
        composer: ${player.composer}
        comments: ${player.comments}
        `)
        // playbackStatus PLAYING, PAUSED, STOPPED
        // loopSttus UNSUPPORTED, NONE, TRACK, PLAYLIST
        // shuffleStatus UNSUPPORTED, ON, OFF
}

function ProgressBar({ player }: { player: Mpris.Player }) {
  const progress = bind(player, "position").as(() => {
    const length = player.length || 1;
    return Math.min(player.position / length + 0.01, 1);
  });

  const MAX_WIDTH = 15;
  const animation = progress.as(progress => {
    const width = MAX_WIDTH * progress;
    return (
      <box
        className="ProgressBar"
        css={`min-width: ${MAX_WIDTH}em;`}
      >
        <box className="Fill" css={`min-width: ${width}em;`} />
      </box>
    );
  })

  return (
    <overlay>
    {animation.as(a => a)}
    <SongInfo player={player} />
    </overlay>
  )
}

function SongInfo({ player }: { player: Mpris.Player }) {
  const onSongChange = bind(player, "artist")
  return (
    <label
      label={
        onSongChange.as(() => `${player.title} - ${player.artist}`)
      }
    />
  )
}


export default function Media() {
    const mpris = Mpris.get_default();
    const activePlayer = Variable<Mpris.Player | undefined>(undefined);

    function update_player() {
      const players = mpris.get_players();
      const player = players.find(player => player.playbackStatus === Mpris.PlaybackStatus.PLAYING);
      if (player === activePlayer.get()) { return; }
      activePlayer.set(player || players[0] || undefined);
    }

    function watch_player(player: Mpris.Player) {
      player.connect("notify::playback-status", update_player);
    }


    mpris.connect("player-added", (_, player) => watch_player(player));
    mpris.connect("player-closed", (_, player) => {
      if (player === activePlayer.get()) { update_player(); }
    })

    update_player(); // set the initial player
    mpris.get_players().forEach(player => watch_player(player)); // watch any pre-existing players
    return (
      <box className="Media">{
        activePlayer(player => {
          if (player === undefined) { return null; }
          return (
            <box>
              <AlbumArt player={player} />
              <ProgressBar player={player} />
            </box>
          )
        })
      }</box>
    )
}
