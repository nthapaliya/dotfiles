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

def filtered_history
  Reline::HISTORY.reject { |s| ['exit', ''].include?(s) }
                 .reverse
                 .uniq
end

def fzf_history(line = '')
  Tempfile.open('histfile') do |tempfile|
    tempfile.write(filtered_history.join(0.chr))
    tempfile.close

    query = ['<', tempfile.path, 'fzf', "--query='#{line}'",
             '--read0', '--no-hscroll', '--preview', "'echo {}'",
             '--preview-window', 'up:3:hidden:wrap',
             '--bind', '?:toggle-preview'].join(' ')

    hist = `#{query}`
    return hist.empty? ? line : hist
  end
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
