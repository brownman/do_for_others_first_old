help='options: du1 du2 du3'

du1(){
du -b --max-depth 1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e'
}
du2(){
du -s * | sort -n | tail
}
du3(){
du -h --max-depth=1
}
du4(){
du -hs */
}


@$
