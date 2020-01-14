# frozen_string_literal: true

begin
  require 'pry'

  Pry.start

  exit
rescue LoadError => _e
  warn '=> Unable to load pry'

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = File.join(Dir.home, '.local', 'share', 'irb', 'history')
end
