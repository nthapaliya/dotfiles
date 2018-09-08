function vdirty
    argparse 'i/interactive' -- $argv

    set -l git_args $argv

    test -n "$_flag_interactive"
    and set -l dirty_files ( gf $git_args )
    or set -l dirty_files ( git status -s -- $git_args | cut -c4- )

    e $dirty_files
end
