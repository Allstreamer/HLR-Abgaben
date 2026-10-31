# srun -n1 -p west ./partdiff-seq.x 1 1 64 1 2 900 | diff - ./referenz/1_1_64_1_2_900.txt
# srun -n1 -p west ./partdiff-seq.x 1 1 64 2 2 400 | diff - ./referenz/1_1_64_2_2_400.txt
# srun -n1 -p west ./partdiff-seq.x 1 2 64 1 2 900 | diff - ./referenz/1_2_64_1_2_900.txt
# srun -n1 -p west ./partdiff-seq.x 1 2 64 2 2 400 | diff - ./referenz/1_2_64_2_2_400.txt

# Eigene Testwerte
# srun -n1 -p west ./partdiff-seq.x 1 2 64 1 2 9000 | diff - ./referenz/1_2_64_1_2_9000.txt
# srun -n1 -p west ./partdiff-seq.x 1 2 64 2 2 4000 | diff - ./referenz/1_2_64_2_2_4000.txt



./partdiff-seq.x 1 1 64 1 2 900 | diff - ./referenz/1_1_64_1_2_900.txt
./partdiff-seq.x 1 1 64 2 2 400 | diff - ./referenz/1_1_64_2_2_400.txt
./partdiff-seq.x 1 2 64 1 2 900 | diff - ./referenz/1_2_64_1_2_900.txt
./partdiff-seq.x 1 2 64 2 2 400 | diff - ./referenz/1_2_64_2_2_400.txt

# Eigene Testwerte
./partdiff-seq.x 1 2 64 1 2 9000 | diff - ./referenz/1_2_64_1_2_9000.txt
./partdiff-seq.x 1 2 64 2 2 4000 | diff - ./referenz/1_2_64_2_2_4000.txt
