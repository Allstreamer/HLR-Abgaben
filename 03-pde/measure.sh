
# To prove null hypothisis (p = 0.03)
#runs=10; need=9     # p = 0.011
#runs=20; need=15     # p = 0.021
runs=30; need=20    # p = 0.049
#runs=50; need=32    # p = 0.032
#runs=100; need=59   # p = 0.044

worker() {
  for i in $(seq $((runs / 2))); do
    method=$(shuf -i 1-2 -n 1)
    function=$(shuf -i 1-2 -n 1)
    iters=$(shuf -i 250-1000 -n 1)
    args="1 $method 64 $function 2 $iters"

    # https://www.youtube.com/watch?v=r-TLSBdHe1A
    pad=$(head -c "$(shuf -i 0-4095 -n 1)" /dev/zero | tr '\0' x)

    node=$(sinfo -h -p west -N -t idle -o %N | shuf -n 1)

    # Account for hot cache & cpu throttling
    order="new old"; (( RANDOM % 2 )) && order="old new"
    for v in $order; do
      [[ $v == new ]] && bin=./partdiff-seq.x || bin=./partdiff-seq-base.x
      srun -n1 -pwest -w "$node" env PAD="$pad" /usr/bin/time -f "%e" -o t_$1_$v.txt $bin $args >/dev/null
    done

    awk -v m="$method" -v f="$function" -v it="$iters" -v o="$(cat t_$1_old.txt)" -v n="$(cat t_$1_new.txt)" \
      'BEGIN { printf "%d %d %d %.2f %.2f %.3fx\n", m, f, it, o, n, o/n }' >>diff.txt
  done
}

rm -f diff.txt
worker a & worker b & wait
rm -f t_a_*.txt t_b_*.txt
column -t diff.txt
awk -v need=$need '{ if ($5 <= $4) w++ } END { printf "new faster in %d/%d runs (need %d) -> %s\n", w, NR, need, (w >= need ? "significant (p<0.05)" : "not significant") }' diff.txt