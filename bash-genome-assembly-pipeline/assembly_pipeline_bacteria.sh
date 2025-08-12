#!/bin/bash
# Genome assembly pipeline for bacterial samples
# Pre-processing → Assembly → Evaluation
# Author: Sérgio de Alencar

set -e  # stop if any command fails

THREADS=8
OUTPUT_DIR="assembly_results"
mkdir -p "$OUTPUT_DIR"

# List of samples (names without the _R1/_R2 suffix)
SAMPLES=("ACS09_S3_L001" "MHM_S2_L001" "MAE_S1_L001" "PDM_S4_L001")

for SAMPLE in "${SAMPLES[@]}"; do
    echo "==============================================="
    echo "PROCESSING SAMPLE: $SAMPLE"
    echo "==============================================="

    READS1="${SAMPLE}_R1_001.fastq.gz"
    READS2="${SAMPLE}_R2_001.fastq.gz"

    SAMPLE_DIR="$OUTPUT_DIR/$SAMPLE"
    mkdir -p "$SAMPLE_DIR"

    # -----------------------------
    # 1. Pre-processing (FastQC + Trimmomatic)
    # -----------------------------
    echo "[1/4] Running FastQC..."
    fastqc "$READS1" "$READS2" -t $THREADS -o "$SAMPLE_DIR"

    echo "[2/4] Running Trimmomatic..."
    trimmomatic PE \
        -threads $THREADS \
        "$READS1" "$READS2" \
        "$SAMPLE_DIR/${SAMPLE}_trimmed_R1_paired.fq.gz" "$SAMPLE_DIR/${SAMPLE}_trimmed_R1_unpaired.fq.gz" \
        "$SAMPLE_DIR/${SAMPLE}_trimmed_R2_paired.fq.gz" "$SAMPLE_DIR/${SAMPLE}_trimmed_R2_unpaired.fq.gz" \
        ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:50

    # -----------------------------
    # 2. Assembly (SPAdes)
    # -----------------------------
    echo "[3/4] Running SPAdes..."
    spades.py \
        -1 "$SAMPLE_DIR/${SAMPLE}_trimmed_R1_paired.fq.gz" \
        -2 "$SAMPLE_DIR/${SAMPLE}_trimmed_R2_paired.fq.gz" \
        -t $THREADS \
        -o "$SAMPLE_DIR/${SAMPLE}_spades_output"

    # -----------------------------
    # 3. Evaluation (QUAST)
    # -----------------------------
    echo "[4/4] Running QUAST..."
    quast.py "$SAMPLE_DIR/${SAMPLE}_spades_output/contigs.fasta" \
        -o "$SAMPLE_DIR/${SAMPLE}_quast_report" \
        -t $THREADS

    echo "Sample $SAMPLE completed!"
done

echo "Pipeline finished for all samples!"

