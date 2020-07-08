# spotify-track-spread

## Workflow for 
> Fenne Schoot, 2019, "Analyzing Spotify's network of playlists: how tracks spread through playlists on Spotify", Tilburg University Thesis.

1) `01_data_prep.Rmd`
Reads raw data from parsed_playlists.csv,
cleans and prepares data.

2) `02_descriptives.Rmd`
Generates descriptive statistics from data.csv

3) `03_calculate_influence.Rmd`
Uses data.csv to calculate the influence degrees of all
playlist combinations for which the influence degree is not
equal to 0.

4) `04_analysis_prep.R`
Combines all playlists in the data to make playlist pairs.
 
5) `05_analysis_pairs.R`
Adds the calculated influence degrees to the playlist pairs,
and 0 to the playlist pairs for which the influence degree
is 0.

6) `06_analysis.Rmd`
Prepares and runs ANCOVA.


## Dependencies

Please follow the installation guide on http://tilburgsciencehub.com/.

- Python. [Installation Guide](http://tilburgsciencehub.com/setup/python/).
- R. [Installation Guide](http://tilburgsciencehub.com/setup/r/).


## How to run it

Open your command line tool:

- Check whether your present working directory is  `spotify-track-spread` by typing `pwd` in terminal

  - if not, type `cd yourpath/spotify-track-spread` to change your directory to `spotify-track-spread`

- Type `make` in the command line.

## Directory Structure

```txt
├── data
├── gen
│   ├── analysis
│   │   ├── input
│   │   ├── output
│   │   └── temp
│   ├── data-preparation
│   │   ├── input
│   │   ├── output
│   │   └── temp
│   └── paper
│       ├── input
│       ├── output
│       └── temp
└── src
    ├── analysis
    ├── data-preparation
    └── 
```
