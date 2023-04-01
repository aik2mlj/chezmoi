function compress_videos_here
    mkdir ./compress
    for i in *.mp4 *.mkv *.m4v
        set name (echo $i | cut -d'.' -f1)
        echo $name
        ffmpeg -i $i -c:v hevc_nvenc -qp 26 -c:a libopus -b:a 128k ./compress/$i
    end
end
