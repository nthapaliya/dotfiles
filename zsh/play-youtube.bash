play-yt() {
  youtube-dl \
    --default-search 'ytsearch' \
    --no-playlist \
    -f bestaudio \
    --output '/tmp/%(title)s.%(ext)s' \
    --extract-audio --audio-format mp3 --keep-video \
    --exec 'mpv {}' \
    "$1"
}
