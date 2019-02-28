IRB.conf[:SAVE_HISTORY] ||= 1000
IRB.conf[:HISTORY_FILE] ||= File.join(
  ENV['HOME'],
  '.local',
  'share',
  'irb',
  'history'
)

begin
  require 'pry'
  Pry.start
  exit
rescue LoadError => _e
  warn '=> Unable to load pry'
end
