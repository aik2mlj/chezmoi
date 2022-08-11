function lnmv
    set files $argv[1..-2]
    set dest_dir $argv[-1]

    for f in $files
        set fname (string split / $f)[-1]
        set dest $dest_dir$fname
        install -D -- $f $dest
        mv -- $f $dest
        ln -s -- $dest $f
    end
end
