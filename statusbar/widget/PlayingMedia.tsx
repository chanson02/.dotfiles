/**
Main Widget (Media)
  AlbumArt
  ProgressBar
    Fill
    SongInfo
*/
import { Gtk } from "astal/gtk3";
import { bind, Variable } from "astal";
import Mpris from "gi://AstalMpris";

const PROGRESS_BAR_WIDTH = 15;

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

function ProgressBar({ player }: { player: Mpris.Player }) {
  const progress = bind(player, "position").as(() => {
    const length = player.length || 1;
    return Math.min(player.position / length + 0.01, 1);
  });

  const animation = progress.as(progress => {
    const width = PROGRESS_BAR_WIDTH * progress;
    return (
      <box
        className="ProgressBar"
        css={`min-width: ${PROGRESS_BAR_WIDTH}em;`}
      >
        <box className="Fill" css={`min-width: ${width}em;`} />
      </box>
    );
  })

  // Root child update causes all other children to update
  // was getting flickers with animation as first child
  return (
    <overlay>
    <box css={`min-width: ${PROGRESS_BAR_WIDTH}em;`}/>
    {animation.as(a => a)}
    <SongInfo player={player} />
    </overlay>
  )
}

function SongInfo({ player }: { player: Mpris.Player }) {
  const onSongChange = bind(player, "artist");
  const labelText = onSongChange.as(() => `${player.title} - ${player.artist}`);
  const scrollPos = new Variable(0);

  const label = <box
    halign={Gtk.Align.START}
    css={scrollPos((pos) => `margin-left: ${pos}px; transition: margin-left 0.1s linear;`)}
    >
    <label label={labelText.as((text) => text)} />
  </box>;


  setInterval(() => {
    // print(label.get_allocated_width());
    const max = label.get_parent()?.get_allocated_width();
    let new_pos = scrollPos.get() - 1;
    if (label.get_allocated_width() <= 1) { new_pos = max || 200; }
    scrollPos.set(new_pos);
  }, 100);
  return label
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
          if (player === undefined) { return <box />; }
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





/**
  * Used for debugging purposes
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

function debugWidget(widget: Gtk.Widget) {
  print(`alloc width ${widget.get_allocated_width()}`);
  // print(`pref size ${widget.get_preferred_size()}`);
  print(`pref width ${widget.get_preferred_width()}`);
  print(`pref height: ${widget.get_preferred_height()}`);
  print(`clip width ${widget.get_clip().width}`);
  print(`clip height ${widget.get_clip().height}`);
}



*/
