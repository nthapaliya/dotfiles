# frozen_string_literal: true

HISTORY_FILE = File.join(
  ENV['HOME'],
  '.local',
  'share',
  'irb',
  'history'
)

begin
  require 'pry'
  require 'hirb'

  Hirb.enable

  Pry.config.print = proc do |output, value, pry|
    Hirb::View.view_or_page_output(value) ||
      Pry::DEFAULT_PRINT.call(output, value, pry)
  end

  Pry.config.history.file = HISTORY_FILE
  Pry.config.should_load_rc = false
  Pry.config.editor = 'vim'

  Pry.start

  exit
rescue LoadError => _e
  warn '=> Unable to load pry or hirb'

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = HISTORY_FILE
end
