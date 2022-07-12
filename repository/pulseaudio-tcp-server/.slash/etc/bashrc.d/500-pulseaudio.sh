pulseaudioid=`pgrep pulseaudio`
if [ -z $pulseaudioid ]; then
    pulseaudio -D &
fi
