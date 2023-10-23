function euler
    cd ~/Projects/euler

    set num $argv[1]

    if test -n "$num"
        set padded_num (string pad --char 0 --width 3 $num)
        set file "problem_$padded_num.rb"
        set link "https://projecteuler.net/problem=$padded_num"
        open $link

        if test -e $file
            vi $file
        else
            touch $file
            echo "# frozen_string_literal: true" >>$file
            echo "" >>$file
            echo "# $link" >>$file
            vi $file
        end
    else
        open "https://projecteuler.net/archives"
    end
end
