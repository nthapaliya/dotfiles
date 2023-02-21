# frozen_string_literal: true

# vim: set ft=ruby:

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = File.join(Dir.home, '.local', 'share', 'irb', 'history')

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
end

def reload
  # puts "reloading #{__FILE__}"

  warn_level = $VERBOSE

  # This is to suppress the annoying already initialized constant warnings
  $VERBOSE = nil

  load __FILE__

  $VERBOSE = warn_level

  true
end

require 'tempfile'

def fzf_history(line = '')
  hist = ''
  hist_array = Reline::HISTORY
               .reject { |s| s == 'exit' }
               .reject { |s| s.chomp == '' }
               .reverse
               .uniq

  Tempfile.open('histfile') do |tempfile|
    tempfile.write(hist_array.join(0.chr))
    tempfile.close

    hist = `< #{tempfile.path} fzf --query="#{line}" --read0 --no-hscroll --preview 'echo {}' --preview-window up:3:hidden:wrap --bind '?:toggle-preview'`
  end

  hist
end

module Reline
  class LineEditor
    private def incremental_search_history(_key)
      @buffer_of_lines = fzf_history(@line).split("\n")
      @buffer_of_lines = [String.new(encoding: @encoding)] if @buffer_of_lines.empty?
      @line_index = @buffer_of_lines.size - 1
      @line = @buffer_of_lines.last
      @rerender_all = true
      @cursor_max = calculate_width(@line)
      @cursor = @byte_pointer = @line.length
    end
  end
end
