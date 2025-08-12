# Bacterial Genome Assembly Using Bash Pipeline

This repository contains a **Bash-based pipeline** for processing and assembling bacterial genomes from paired-end Illumina reads. It includes **pre-processing**, **assembly**, and **quality assessment** steps, and is designed to handle multiple samples in one run.

---

## Overview

### **Workflow**

```mermaid
flowchart LR
    A[Raw Paired-end Reads] --> B[FastQC: Quality Control]
    B --> C[Trimmomatic: Adapter Removal & Quality Trimming]
    C --> D[SPAdes: Genome Assembly]
    D --> E[QUAST: Assembly Evaluation]
    E --> F[Final Reports & Contigs]
```


## Input Files

Place all your `.fastq.gz` files in the same directory as the pipeline script.  
This example processes **four bacterial samples**, each with paired-end reads:

```
ACS09_S3_L001_R1_001.fastq.gz
ACS09_S3_L001_R2_001.fastq.gz
MHM_S2_L001_R1_001.fastq.gz
MHM_S2_L001_R2_001.fastq.gz
MAE_S1_L001_R1_001.fastq.gz
MAE_S1_L001_R2_001.fastq.gz
PDM_S4_L001_R1_001.fastq.gz
PDM_S4_L001_R2_001.fastq.gz
```


---

## Requirements

Make sure the following tools are installed and available in your `$PATH`:

- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [SPAdes](https://cab.spbu.ru/software/spades/)
- [QUAST](http://quast.sourceforge.net/)


## Usage

Run the pipeline:

bash [assembly_pipeline_bacteria.sh](https://github.com/sergiodealencar/bioinformatics-engineering-portfolio/blob/main/bash-genome-assembly-pipeline/assembly_pipeline_bacteria.sh)

```Script Parameters
THREADS: number of CPU threads to use (default: 8)

OUTPUT_DIR: directory where results will be stored (default: assembly_results/)

Output Structure
For each sample, a separate folder is created inside assembly_results/:

assembly_results/
├── ACS09_S3_L001/
│   ├── ACS09_S3_L001_trimmed_R1_paired.fq.gz
│   ├── ACS09_S3_L001_trimmed_R1_unpaired.fq.gz
│   ├── ACS09_S3_L001_trimmed_R2_paired.fq.gz
│   ├── ACS09_S3_L001_trimmed_R2_unpaired.fq.gz
│   ├── ACS09_S3_L001_spades_output/
│   └── ACS09_S3_L001_quast_report/
...

Customization
To add more samples, edit the SAMPLES array in assembly_pipeline_bacteria.sh.

Adjust Trimmomatic parameters for different adapter sets or quality thresholds.

Replace SPAdes with other assemblers (e.g., Velvet, MEGAHIT) if needed.




