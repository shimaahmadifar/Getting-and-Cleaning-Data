###Source Data Human Activity Recognition Using Smartphones Data Set

Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data Set Characteristics: Multivariate, Time-Series Number of Instances:10299 Number of Attributes:561 Missing Values:N/A Source:

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2) 1 - Smartlab - Non-Linear Complex Systems Laboratory DITEN - UniversitÃ degli Studi di Genova, Genoa (I-16145), Italy. 2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat PolitÃ¨cnica de Catalunya (BarcelonaTech). Vilanova i la GeltrÃº (08800), Spain activityrecognition '@' smartlab.ws

Citation Request:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

####Data Set Description:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information:

Each record in the dataset provides:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
###Data Processing : This dataset of 10299 rows x 561 observations was split among 6 files in the source data:

X_train.txt - accelerometer measurements from the training set
X_test.txt - accelerometer measurements from the training set
y_train.txt - activity label data corresponding to x_train.txt measurements
y_test.txt - activity label data corresponding to x_test.txt measurements
subject_train.txt -subject label data corresponding to x_train.txt measurements
subject_test.txt -subject label data corresponding to x_test.txt measurements
The run_analysis.R file processes this data as follows:

1.data is merged into a single 10299 x 565 data frame with columns for set (training or test), subject, activity and the 561 observations

2.Only observations measuring mean and standard deviation are needed for this analysis. These are identified by the observation names (i.e.column headings) for the 561 in the features.txt file. The observations of interest are consistently labelled with mean() or std(). Corresponding columns were extracted resulting in a 10299X69 dataset (set, subject, activity & 66 mean or stdev observations)

3.The coded activity labels 1,2,3,4,5,6 were replaced with text descriptions WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING defined in the activity_labels.txt file.

4.The observation names in features.txt are cleaned up for use as column headings: brackets and hyphens are removed, names are converted to lower case and the 't' and 'f' prefixes were replaced with the more descriptive 'time' and 'freq'. The meaning of column headings can be understood by reading the data owner's dataset description (above).

This results in a table of data as seen in the meansandstdevs.csv file.

5.The processed table is then grouped by subject and activity and the mean of each observations is calculated for each group.

This results in a table of data as seen in the groupedmeansandstdevs.csv file. The script writes this data to your working directory as a text file.

The comments in the run_analysis.R file identify each of these stages.
