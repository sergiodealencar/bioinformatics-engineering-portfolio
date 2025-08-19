🔍 16S Metataxonomical Analysis with Snakemake + QIIME2

This repository provides a reproducible Snakemake workflow for processing and analyzing 16S rRNA sequencing data using QIIME2 inside Docker.

The pipeline automates:

✅ Importing paired-end FASTQ data

✅ Quality control and denoising with DADA2

✅ Feature table and representative sequences generation

✅ Taxonomic classification using the SILVA database

✅ Interactive visualizations (demux summaries, taxa barplots, feature tables)


📂 Project Structure

```
projeto-16S/
├── dados/               # Input FASTQ.gz files
├── results/             # Workflow outputs (QIIME2 .qza/.qzv files)
├── Snakefile            # Snakemake workflow definition
├── config.yaml          # Configuration (sample names, parameters, paths)
└── envs/                # Conda env specs (if needed outside Docker)
```

⚙️ Requirements

Docker

Snakemake
 (optional outside container)

The workflow runs inside a prebuilt QIIME2 Docker image, ensuring reproducibility.

🚀 Usage
1. Clone the repository

```
git clone https://github.com/<your-username>/projeto-16S.git
cd projeto-16S
```

2. Run QIIME2 in Docker

Mount your project directory into the container:

```
docker run -it \
  -v /Users/<your-user>/Downloads/projeto-16S:/projeto-16S \
  quay.io/qiime2/amplicon:2025.7 \
  /bin/bash
```

3. Inside the container, run the Snakemake workflow

```
cd /projeto-16S
snakemake --cores 4
```

🧪 Example Input

dados/ must contain your paired-end FASTQ files named like:

```
sample1_R1.fastq.gz
sample1_R2.fastq.gz
sample2_R1.fastq.gz
sample2_R2.fastq.gz
```

The config.yaml file maps your samples to these files.

📊 Outputs

All results are stored in results/, including:

demux.qzv → sequence quality visualization

table.qza / table.qzv → feature table

rep-seqs.qza / rep-seqs.qzv → representative sequences

taxonomy.qza / taxonomy.qzv → taxonomy assignments

taxa-bar-plots.qzv → barplots of taxa composition

Open .qzv files using QIIME2 View
.

🛠️ Customization

Modify config.yaml to adapt to your dataset and parameters.

Extend the Snakefile to include additional steps (e.g., diversity analysis, phylogenetic trees).

📖 References

QIIME2 Documentation

Snakemake Documentation
