concurrency_values=(128 64 32 16 8 4)

for concurrency in "${concurrency_values[@]}"; do
        echo "Running benchmark with --max-concurrency ${concurrency}"
        log_file="benchmark_MINIMAX-M2_1k1k_tp4_conc_${concurrency}.log"
        num_prompts=1024 #$(( concurrency * 8 ))
        python3 -m sglang.bench_serving \
                --backend sglang \
                --dataset-name random \
                --random-range-ratio 1 \
                --port 8000 \
                --num-prompt "${num_prompts}" \
                --random-input 1024 \
                --random-output 1024 \
                --seed "${concurrency}" \
                --max-concurrency "${concurrency}"\
                > "$log_file" 2>&1

        echo "--------------------------------------"
        echo "Output saved to $log_file"
done




