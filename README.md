# soloway_snATAC

## Requirements to run the snakemake workflow

1. Ensure that git and conda are installed on your machine.
2. Clone the following git repositories:

    ```sh
    git clone https://github.com/r3fang/snATAC.git
    git clone https://github.com/okartal/snATAC_pipeline.git
3. Checkout the fixed branch in snATAC_pipeline:

    ```sh
    cd snATAC_pipeline
    git checkout --track hotfix/file-folder-handling
4. Export the paths for the binaries of both repositories:

    ```sh
    export PATH=$PATH:<path-to-snATAC>/bin/
    export PATH=$PATH:<path-to-snATAC_pipeline>/bin/
5. Clone this repository and checkout the snakemake branch

    ```sh
    git clone https://github.com/okartal/soloway_snATAC.git
    git checkout --track feature/snakemake-workflow
6. In .test/config.yaml, check correct paths, e.g. to the reference genome, and run the test from the command line:

    ```sh
    cd .test
    snakemake -pj --use-conda --snakefile ../Snakefile

If the test has worked, you can copy .test/config.yaml and .test/data into your project's working directory and modify the files according to your needs (parameters, barcodes and sequencing units). Then you simply run

   ```sh
   snakemake -pj --use-conda --snakefile <path-to-soloway_snATAC/Snakefile>
