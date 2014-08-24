tidy-data
=========

The programming assignment for the Getting and Cleaning Data course. Content of
this repo:

1. `README.md` - this file.
2. `run_analysis.R` - the script creating the analysis result
3. `find_names.R` - a helper script used by run_analysis
4. `tidy_data.txt` - result of running the script
5. `code_book.md` - a document describing the data

## Run Analysis

The script must be run with the current working directory set to a directory which
contains the source data in a directory called `UCI HAR Dataset`. This directory
is created as a result of unzipping the source data zip file.

The script begins with a check for the working directory. After that it reads
in the data files from train and test directories, and also the features list
from `features.txt` as well as activity labels from `activity_labels.txt`. All
reading occurs with read.table function.

Reading test data results in 3 distinct tables: `train_x` contains the computed
measurements, `train_y` contains exercise identifiers and `train_s` subjects. These
are rowbound with corresponding test data.

Data from `features.txt` is used to create the column names in `train_x`. After
this, we resort to the helper script `find_names`, whose job is to extract all
column names containing strings 'mean' and 'std'.

### Finding the variables with 'mean' and 'std'

We get the input as a factor. Because of how the R data structures work,
we set all entries not containing string 'mean' or 'std' to `NA`. Then, we remove
all NA entries from the factorial. Finally we convert the factorial to a character
vector. This is because the return value is used to select columns to keep later.

### Continuing with run analysis

The return value of find_names is used to extract the columns from `train_x` data set.
This is rather straightforward as the helper returns the data in proper format.

Then we rename the activities in train_y.

The final tidy data set is created using training subject data as a factor. This
allows us to use `tapply` function to compute the mean for each subject and each
variable. Again, some gymnastics is required with R data structures in order to
get the desired result. The tidy data set oucomes as a matrix, which we convert to
a data frame, so that we can plug in suitable names. Finally, we include the subject
data to the tidy data set, which means that we first use `table` function to
get the levels of a factor, then use names to get them out as a vector.

All in all, I found that tweaking R data structures was the most time consuming
and frustrating part of this programming assignment. The data itself and the
manipulations for it were simple.
