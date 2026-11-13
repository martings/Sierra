FROM bioconductor/bioconductor_docker:RELEASE_3_18

LABEL org.opencontainers.image.source="https://github.com/martings/Sierra"
LABEL org.opencontainers.image.description="Sierra with native strandMode support (unstranded/forward/reverse)"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"

WORKDIR /opt/sierra-src
COPY . /opt/sierra-src

RUN Rscript -e 'install.packages("BiocManager", repos = "https://cloud.r-project.org"); \
    BiocManager::install(c("GenomicRanges", "GenomicAlignments", "S4Vectors", "Rsamtools", \
                           "GenomeInfoDb", "GenomicFeatures", "BiocGenerics", "BiocParallel", \
                           "Biostrings", "IRanges", "SummarizedExperiment", "rtracklayer", \
                           "SingleCellExperiment", "DEXSeq", "genefilter", "Gviz", "BSgenome", \
                           "BiocStyle"), update = FALSE, ask = FALSE); \
    install.packages(c("reshape2", "plyr", "dplyr", "foreach", "doParallel", "Matrix", \
                       "MLmetrics", "progress", "ggplot2", "cowplot", "flock", "magrittr", \
                       "R.utils", "data.table", "scales"), repos = "https://cloud.r-project.org")' \
    && R CMD INSTALL --no-multiarch /opt/sierra-src \
    && rm -rf /opt/sierra-src
