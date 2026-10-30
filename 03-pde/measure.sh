rm -f diff.txt
for i in $(seq 20); do
  method=$(shuf -i 1-2 -n 1)
  function=$(shuf -i 1-2 -n 1)
  iters=$(shuf -i 500-1000 -n 1)
  args="1 $method 64 $function 2 $iters"

  srun -n1 -pwest /usr/bin/time -f "%e" -o t_new.txt ./partdiff-seq.x $args >/dev/null &
  srun -n1 -pwest /usr/bin/time -f "%e" -o t_old.txt ./partdiff-seq-base.x $args >/dev/null &
  wait

  awk -v m="$method" -v f="$function" -v it="$iters" -v o="$(cat t_old.txt)" -v n="$(cat t_new.txt)" \
    'BEGIN { printf "%d %d %d %.2f %.2f %.3fx\n", m, f, it, o, n, o/n }' >>diff.txt
done

rm -f t_new.txt t_old.txt
column -t diff.txt
awk 'NR>1 { s += $6 } END { printf "mean speedup: %.3fx\n", s/(NR-1) }' diff.txt
