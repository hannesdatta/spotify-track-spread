all: initiation data_prep descriptives calculate_influence analysis_prep analysis_fill analysis


# summary of workflow
initiation: src/data-preparation/init.py
	python src/data-preparation/init.py
data_prep: gen/data-preparation/input/data.csv gen/data-preparation/output/01_data_prep.html
descriptives: gen/data-preparation/output/02_descriptives.html
calculate_influence: gen/data-preparation/input/data_influence.csv gen/data-preparation/output/03_calculate_influence.html
analysis_prep: gen/data-preparation/temp/playlist_match_1000.csv gen/data-preparation/temp/pl_all_combinations_1000.csv
analysis_fill: gen/analysis/temp/analysis_input_1000.csv
analysis: gen/anlysis/output/workspace_1000.Rdata gen/anlysis/output/06_analysis.html


# detail of workflow
# data preparation
gen/data-preparation/input/data.csv gen/data-preparation/output/01_data_prep.html: src/data-preparation/01_data_prep.Rmd data/parsed_playlists.csv
	Rscript -e "rmarkdown::render('src/data-preparation/01_data_prep.Rmd', output_file='../../gen/data-preparation/output/01_data_prep.html')" 

# describe the data
gen/data-preparation/output/02_descriptives.html: src/data-preparation/02_descriptives.Rmd gen/data-preparation/input/data.csv
	Rscript -e "rmarkdown::render('src/data-preparation/02_descriptives.Rmd', output_file='../../gen/data-preparation/output/02_descriptives.html')" 

# calculate influence
gen/data-preparation/input/data_influence.csv gen/data-preparation/output/03_calculate_influence.html: src/data-preparation/03_calculate_influence.Rmd gen/data-preparation/input/data.csv
	Rscript -e "rmarkdown::render('src/data-preparation/03_calculate_influence.Rmd', output_file='../../gen/data-preparation/output/03_calculate_influence.html')" 

# prepare for the analysis
gen/data-preparation/temp/playlist_match_1000.csv gen/data-preparation/temp/pl_all_combinations_1000.csv: src/data-preparation/04_analysis_prep.R gen/data-preparation/input/data_influence.csv
	Rscript "src/data-preparation/04_analysis_prep.R"

# analysis fill
gen/analysis/temp/analysis_input_1000.csv: src/analysis/05_analysis_fill.R gen/data-preparation/input/data.csv gen/data-preparation/temp/playlist_match_1000.csv gen/data-preparation/temp/pl_all_combinations_1000.csv
	Rscript "src/analysis/05_analysis_fill.R"

# analysis the data
gen/anlysis/output/workspace_1000.Rdata gen/anlysis/output/06_analysis.html: src/analysis/06_analysis.Rmd gen/analysis/temp/analysis_input_1000.csv
	Rscript -e "rmarkdown::render('src/analysis/06_analysis.Rmd', output_file='../../gen/analysis/output/06_analysis.html')" 


.PHONY: clean
clean:
	RM -f -r "gen"
	# RM -f -r "data"