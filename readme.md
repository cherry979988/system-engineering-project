## System Engineering Project ###

### Description

In general, different methods learned in class are applied to predict or analyze traffic flow data in Beijing.

- Task 1: Use multiple linear regression to predict traffic flow; 
- Task 2: Use principal component analysis (PCA) to describe the key features in traffic flow on a daily basis
- Task 3: Use K-means clustering to classify rush hour traffic; 
- Task 4 (optional) Use neural net fitting and compare the results with 1.
- Task 6 (optional) Use self-organizing map and compare the results with 3

Note that I'm not working on the optional task 5 :)

### How to Run?
- Task 1: This task is divided into two subtasks in order to find out the more suitable model setting and data selection;
    - Subtask 1: Run 'problem1.m'; 'period' can be changed to a multiplier of 5 (minutes) to adjust the time period of prediction;
    - Subtask 2: Run 'problem1_2.m';
- Task 2: Run 'problem2.m';
- Task 3: This task is also divided into two subtasks;
    - Subtask 1: Set 'flag' to 0 and run 'problem3.m';
    - Subtask 2: Set 'flag' to 1 and run 'problem3.m';
    - 'numberChosen' can be set to other numbers. This variable indicate the number of clusters;
- Task 4: Run 'problem4.m', similar settings of 'period' in Task 1 applies here;
- Task 6: Run 'problem6.m';

### More Details
A detailed report, 'se-project-report.pdf', is written in Chinese as a part of the project.