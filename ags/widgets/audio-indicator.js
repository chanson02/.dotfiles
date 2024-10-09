const audio = await Service.import('audio');
// audio.speaker.state in ['ready', 'connecting', 'failed']
// audio.speaker.description in ['USB Audio Front Headphones', 'USB Audio Speakers']
// audio.apps[?].description == 'Spotify' .name == 'spotify'


function iconName() {
  const name = audio.speaker.description?.toLowerCase().includes('headphone') ? 'headphones' : 'speakers';
  return `audio-${name}-symbolic`;
}

function AudioIndicator() {
  const volume = Widget.Label().hook(audio.speaker, self => {
    const vol = Math.floor(audio.speaker.volume * 100);
    self.label = `${vol}%`;
  })

  const icon = Widget.Icon({
    icon: iconName(),
    size: 20
  }).hook(audio.speaker, self => {
    self.icon = iconName()
  });

  return Widget.Box({
    children: [
      volume,
      icon,
    ]
  })
}

export { AudioIndicator };
