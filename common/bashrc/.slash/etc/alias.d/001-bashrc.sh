# Allows check a program i/o by searching a string in process list (e.g. by parameter)
function ioproc {
    program_name="$1"
    echo "writes (MB): $1"
    ps aux | grep "$program_name" | awk '{print $2}' | xargs -I {} cat /proc/{}/io 2>/dev/null | grep '^write_bytes' | awk '{print $2/1024/1024}'
    echo
    echo "reads (MB): $1"
    ps aux | grep "$program_name" | awk '{print $2}' | xargs -I {} cat /proc/{}/io 2>/dev/null | grep '^read_bytes' | awk '{print $2/1024/1024}'
}
